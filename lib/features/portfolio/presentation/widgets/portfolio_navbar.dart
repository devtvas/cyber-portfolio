import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../bloc/portfolio_event.dart';

class PortfolioNavbar extends StatelessWidget implements PreferredSizeWidget {
  final void Function(PortfolioSection) onNavTap;
  final GlobalKey inicioKey;
  final GlobalKey projetosKey;
  final GlobalKey experienciaKey;
  final GlobalKey contatoKey;

  const PortfolioNavbar({
    super.key,
    required this.onNavTap,
    required this.inicioKey,
    required this.projetosKey,
    required this.experienciaKey,
    required this.contatoKey,
  });

  @override
  Size get preferredSize => const Size.fromHeight(72);

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 720;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 48),
          child: Row(
            children: [
              Text('devtvas', style: AppTypography.terminalPrompt),
              const Text('.sh', style: TextStyle(color: AppColors.textMuted)),
              const Spacer(),
              if (!isMobile) ..._navItems(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _navItems() {
    return [
      _NavItem(label: 'início', onTap: () => _scrollTo(inicioKey)),
      _NavItem(label: 'projetos', onTap: () => _scrollTo(projetosKey)),
      _NavItem(label: 'experiência', onTap: () => _scrollTo(experienciaKey)),
      _NavItem(label: 'contato', onTap: () => _scrollTo(contatoKey)),
    ];
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavItem({required this.label, required this.onTap});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: AppTypography.navLink.copyWith(
              color: _hovering ? AppColors.accentPrimary : AppColors.textSecondary,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}
