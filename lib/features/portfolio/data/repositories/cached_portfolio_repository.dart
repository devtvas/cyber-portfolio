import '../../domain/entities/portfolio_content.dart';
import '../../domain/repositories/portfolio_repository.dart';
import 'firestore_portfolio_repository.dart';
import 'local_cache_portfolio_repository.dart';

/// Decorator (padrão de design): "envolve" o repositório remoto com
/// uma camada de cache, sem que nenhum dos dois saiba da existência
/// do outro. Isso é o Open/Closed Principle em ação — adicionamos
/// comportamento (cache) sem modificar o FirestorePortfolioRepository.
///
/// Estratégia "stale-while-revalidate":
/// 1. Retorna o que tem em cache imediatamente (se existir) — UI instantânea.
/// 2. Em paralelo, busca a versão fresca no Firestore.
/// 3. Atualiza o cache local com o que veio do Firestore.
///
/// O BLoC consome [getPortfolioContent] (cache) e [refreshContent] (rede)
/// separadamente, podendo decidir quando reagir a cada um.
class CachedPortfolioRepository implements PortfolioRepository {
  final FirestorePortfolioRepository _remote;
  final LocalCachePortfolioRepository _cache;

  CachedPortfolioRepository({
    FirestorePortfolioRepository? remote,
    LocalCachePortfolioRepository? cache,
  })  : _remote = remote ?? FirestorePortfolioRepository(),
        _cache = cache ?? LocalCachePortfolioRepository();

  /// Usado na carga inicial: tenta cache primeiro, cai para rede se vazio.
  @override
  Future<PortfolioContent> getPortfolioContent() async {
    final cached = await _cache.getCachedContent();
    if (cached != null) return cached;

    final fresh = await _remote.getPortfolioContent();
    await _cache.saveContent(fresh);
    return fresh;
  }

  /// Busca a versão mais recente no Firestore e atualiza o cache.
  /// Retorna null silenciosamente se a rede falhar — a UI já tem
  /// o conteúdo em cache exibido, então um erro de rede aqui não
  /// deve quebrar a experiência do visitante.
  Future<PortfolioContent?> refreshContent() async {
    try {
      final fresh = await _remote.getPortfolioContent();
      await _cache.saveContent(fresh);
      return fresh;
    } catch (_) {
      return null;
    }
  }
}
