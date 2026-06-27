import 'package:equatable/equatable.dart';

/// Entidade pura — não conhece Flutter, BLoC, nem Firebase (D do SOLID).
/// Representa apenas o conceito de "projeto" no domínio do portfólio.
class Project extends Equatable {
  final String title;
  final String description;
  final List<String> stack;

  const Project({
    required this.title,
    required this.description,
    required this.stack,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['title'] as String,
      description: json['description'] as String,
      stack: List<String>.from(json['stack'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'stack': stack,
    };
  }

  @override
  List<Object?> get props => [title, description, stack];
}
