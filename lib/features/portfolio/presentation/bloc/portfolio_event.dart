import 'package:equatable/equatable.dart';
import '../../domain/entities/portfolio_content.dart';

enum PortfolioSection { inicio, projetos, experiencia, contato }

abstract class PortfolioEvent extends Equatable {
  const PortfolioEvent();

  @override
  List<Object?> get props => [];
}

/// Disparado quando o usuário clica num item do menu de navegação.
class PortfolioSectionChanged extends PortfolioEvent {
  final PortfolioSection section;

  const PortfolioSectionChanged(this.section);

  @override
  List<Object?> get props => [section];
}

/// Disparado uma vez ao iniciar o app — carrega conteúdo do cache
/// (instantâneo) e dispara a sincronização em segundo plano.
class PortfolioContentRequested extends PortfolioEvent {
  const PortfolioContentRequested();
}

/// Disparado internamente quando a busca em segundo plano no Firestore
/// retorna uma versão atualizada do conteúdo.
class PortfolioContentRefreshed extends PortfolioEvent {
  final PortfolioContent content;

  const PortfolioContentRefreshed(this.content);

  @override
  List<Object?> get props => [content];
}
