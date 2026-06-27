import 'package:flutter/material.dart';

/// Design tokens — paleta "Terminal Hacker".
/// Centralizar aqui evita "magic numbers" de cor espalhados pela UI (DRY)
/// e é o único lugar que precisa mudar se a identidade visual evoluir (OCP).
class AppColors {
  AppColors._();

  static const Color background = Color(0xFF0A0E14);
  static const Color surface = Color(0xFF11161D);
  static const Color surfaceHover = Color(0xFF161D26);
  static const Color border = Color(0xFF1F2630);

  static const Color accentPrimary = Color(0xFF00FF9C); // verde terminal
  static const Color accentAlert = Color(0xFFFF3B5C); // vermelho status

  static const Color textPrimary = Color(0xFFE6EDF3);
  static const Color textSecondary = Color(0xFF7D8590);
  static const Color textMuted = Color(0xFF4A5260);
}
