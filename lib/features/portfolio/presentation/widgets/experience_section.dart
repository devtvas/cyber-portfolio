import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/terminal_prompt.dart';
import '../../domain/entities/experience.dart';
import 'section_wrapper.dart';

class ExperienceSection extends StatelessWidget {
  final List<Experience> experiences;

  const ExperienceSection({super.key, required this.experiences});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TerminalPrompt(command: 'cat experience.log'),
          const SizedBox(height: 32),
          for (final exp in experiences)
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: _ExperienceItem(experience: exp),
            ),
        ],
      ),
    );
  }
}

class _ExperienceItem extends StatelessWidget {
  final Experience experience;

  const _ExperienceItem({required this.experience});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(color: AppColors.accentPrimary, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                experience.role,
                style: AppTypography.displayMedium.copyWith(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${experience.company} · ${experience.period}',
            style: AppTypography.label.copyWith(
              color: AppColors.accentPrimary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(
            experience.highlights.length,
            (i) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('▸ ', style: TextStyle(color: AppColors.accentPrimary)),
                  Expanded(
                    child: Text(
                      experience.highlights[i],
                      style: AppTypography.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'stack: ${experience.stack}',
            style: AppTypography.label.copyWith(fontSize: 11),
          ),
        ],
      ),
    );
  }
}
