import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../bloc/portfolio_bloc.dart';
import '../bloc/portfolio_event.dart';
import '../bloc/portfolio_state.dart';
import '../widgets/contact_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/portfolio_navbar.dart';
import '../widgets/projects_section.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _inicioKey = GlobalKey();
  final _projetosKey = GlobalKey();
  final _experienciaKey = GlobalKey();
  final _contatoKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PortfolioBloc()..add(const PortfolioContentRequested()),
      child: Scaffold(
        appBar: PortfolioNavbar(
          inicioKey: _inicioKey,
          projetosKey: _projetosKey,
          experienciaKey: _experienciaKey,
          contatoKey: _contatoKey,
          onNavTap: (section) => context
              .read<PortfolioBloc>()
              .add(PortfolioSectionChanged(section)),
        ),
        body: BlocBuilder<PortfolioBloc, PortfolioState>(
          builder: (context, state) {
            switch (state.status) {
              case PortfolioStatus.loading:
                return const _LoadingView();
              case PortfolioStatus.error:
                return _ErrorView(message: state.errorMessage ?? 'Erro desconhecido');
              case PortfolioStatus.loaded:
                final content = state.content!;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      KeyedSubtree(
                        key: _inicioKey,
                        child: HeroSection(content: content),
                      ),
                      KeyedSubtree(
                        key: _projetosKey,
                        child: ProjectsSection(projects: content.projects),
                      ),
                      KeyedSubtree(
                        key: _experienciaKey,
                        child: ExperienceSection(experiences: content.experiences),
                      ),
                      KeyedSubtree(
                        key: _contatoKey,
                        child: ContactSection(
                          contacts: content.contacts,
                          name: content.name,
                        ),
                      ),
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: AppColors.accentPrimary),
          const SizedBox(height: 16),
          Text('carregando dados...', style: AppTypography.label),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: AppColors.accentAlert, size: 40),
            const SizedBox(height: 16),
            Text(
              message,
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
