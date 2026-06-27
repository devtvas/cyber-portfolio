import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/cached_portfolio_repository.dart';
import 'portfolio_event.dart';
import 'portfolio_state.dart';

/// Orquestra o carregamento do conteúdo (cache → Firestore em segundo
/// plano) e a navegação entre seções. Depende apenas de
/// [CachedPortfolioRepository] — não sabe que existe Firestore por trás.
class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final CachedPortfolioRepository _repository;

  PortfolioBloc({CachedPortfolioRepository? repository})
      : _repository = repository ?? CachedPortfolioRepository(),
        super(const PortfolioState()) {
    on<PortfolioSectionChanged>(_onSectionChanged);
    on<PortfolioContentRequested>(_onContentRequested);
    on<PortfolioContentRefreshed>(_onContentRefreshed);
  }

  void _onSectionChanged(
    PortfolioSectionChanged event,
    Emitter<PortfolioState> emit,
  ) {
    emit(state.copyWith(activeSection: event.section));
  }

  Future<void> _onContentRequested(
    PortfolioContentRequested event,
    Emitter<PortfolioState> emit,
  ) async {
    try {
      // 1. Carrega do cache local (ou Firestore, se for o primeiro acesso)
      //    — isso já deixa a tela pronta para o visitante rapidamente.
      final content = await _repository.getPortfolioContent();
      emit(state.copyWith(status: PortfolioStatus.loaded, content: content));
    } catch (e) {
      emit(state.copyWith(
        status: PortfolioStatus.error,
        errorMessage: 'Não foi possível carregar o conteúdo.',
      ));
      return;
    }

    // 2. Em paralelo (sem bloquear a UI), busca a versão mais recente
    //    no Firestore e atualiza a tela só se algo realmente mudou.
    final refreshed = await _repository.refreshContent();
    if (refreshed != null && refreshed != state.content) {
      add(PortfolioContentRefreshed(refreshed));
    }
  }

  void _onContentRefreshed(
    PortfolioContentRefreshed event,
    Emitter<PortfolioState> emit,
  ) {
    emit(state.copyWith(status: PortfolioStatus.loaded, content: event.content));
  }
}
