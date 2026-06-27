import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/terminal_prompt.dart';
import '../../domain/entities/contact_link.dart';
import 'section_wrapper.dart';

class ContactSection extends StatelessWidget {
  final List<ContactLink> contacts;
  final String name;

  const ContactSection({super.key, required this.contacts, required this.name});

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 720;

    return SectionWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TerminalPrompt(command: 'contact --info'),
          const SizedBox(height: 16),
          Text(
            'Vamos conversar sobre a próxima oportunidade.',
            style: AppTypography.bodyLarge,
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: contacts
                .map((c) => _ContactCard(
                      contact: c,
                      onTap: () => _open(c.url),
                      fullWidth: isMobile,
                    ))
                .toList(),
          ),
          const SizedBox(height: 64),
          Divider(color: AppColors.border),
          const SizedBox(height: 24),
          Text(
            '© 2026 $name — built with Flutter',
            style: AppTypography.label.copyWith(fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _ContactCard extends StatefulWidget {
  final ContactLink contact;
  final VoidCallback onTap;
  final bool fullWidth;

  const _ContactCard({
    required this.contact,
    required this.onTap,
    required this.fullWidth,
  });

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _hovering = false;

  IconData get _icon {
    switch (widget.contact.type) {
      case ContactType.email:
        return Icons.mail_outline;
      case ContactType.linkedin:
        return Icons.business_center_outlined;
      case ContactType.github:
        return Icons.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _hovering ? AppColors.accentPrimary : AppColors.border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_icon, size: 18, color: AppColors.accentPrimary),
              const SizedBox(width: 10),
              Text(
                widget.contact.label,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return widget.fullWidth ? SizedBox(width: double.infinity, child: content) : content;
  }
}
