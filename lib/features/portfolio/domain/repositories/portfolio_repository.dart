import 'package:cyber_portfolio/features/portfolio/domain/entities/portfolio_content.dart'
    show PortfolioContent;

/// Abstração pura — não sabe se os dados vêm de Firestore, cache local,
/// ou de um arquivo estático. O BLoC depende só disto (D do SOLID).
/// Trocar a fonte de dados no futuro não exige tocar em UI nem no BLoC.
abstract class PortfolioRepository {
  Future<PortfolioContent> getPortfolioContent();
}
