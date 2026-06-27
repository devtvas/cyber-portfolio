import 'package:equatable/equatable.dart';
import '../../domain/entities/portfolio_content.dart';
import 'portfolio_event.dart';

enum PortfolioStatus { loading, loaded, error }

class PortfolioState extends Equatable {
  final PortfolioSection activeSection;
  final PortfolioStatus status;
  final PortfolioContent? content;
  final String? errorMessage;

  const PortfolioState({
    this.activeSection = PortfolioSection.inicio,
    this.status = PortfolioStatus.loading,
    this.content,
    this.errorMessage,
  });

  PortfolioState copyWith({
    PortfolioSection? activeSection,
    PortfolioStatus? status,
    PortfolioContent? content,
    String? errorMessage,
  }) {
    return PortfolioState(
      activeSection: activeSection ?? this.activeSection,
      status: status ?? this.status,
      content: content ?? this.content,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [activeSection, status, content, errorMessage];
}
