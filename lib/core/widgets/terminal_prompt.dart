import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Elemento de assinatura visual: cada seção é "anunciada" como um
/// comando de terminal sendo digitado (ex: "$ cat experience.log").
/// Isso conecta o tema cyber ao conteúdo de forma literal, não decorativa.
class TerminalPrompt extends StatelessWidget {
  final String command;

  const TerminalPrompt({super.key, required this.command});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('\$ ', style: AppTypography.terminalPrompt),
        Text(
          command,
          style: AppTypography.terminalPrompt.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(width: 6),
        _BlinkingCursor(),
      ],
    );
  }
}

class _BlinkingCursor extends StatefulWidget {
  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: 9,
        height: 18,
        color: AppColors.accentPrimary,
      ),
    );
  }
}
