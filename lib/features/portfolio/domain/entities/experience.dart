import 'package:equatable/equatable.dart';

class Experience extends Equatable {
  final String company;
  final String role;
  final String period;
  final List<String> highlights;
  final String stack;

  const Experience({
    required this.company,
    required this.role,
    required this.period,
    required this.highlights,
    required this.stack,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      company: json['company'] as String,
      role: json['role'] as String,
      period: json['period'] as String,
      highlights: List<String>.from(json['highlights'] as List),
      stack: json['stack'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company': company,
      'role': role,
      'period': period,
      'highlights': highlights,
      'stack': stack,
    };
  }

  @override
  List<Object?> get props => [company, role, period, highlights, stack];
}
