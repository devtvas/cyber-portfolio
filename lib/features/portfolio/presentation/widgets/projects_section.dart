import 'package:flutter/material.dart';
import '../../../../core/widgets/terminal_prompt.dart';
import '../../domain/entities/project.dart';
import 'project_card.dart';
import 'section_wrapper.dart';

class ProjectsSection extends StatelessWidget {
  final List<Project> projects;

  const ProjectsSection({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 720;

    return SectionWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TerminalPrompt(command: 'ls ./projetos'),
          const SizedBox(height: 32),
          isMobile
              ? Column(
                  children: projects
                      .map((p) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: ProjectCard(project: p),
                          ))
                      .toList(),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: projects
                      .map((p) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: ProjectCard(project: p),
                            ),
                          ))
                      .toList(),
                ),
        ],
      ),
    );
  }
}
