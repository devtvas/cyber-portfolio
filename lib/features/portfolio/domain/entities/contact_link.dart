import 'package:equatable/equatable.dart';

enum ContactType { email, linkedin, github }

class ContactLink extends Equatable {
  final ContactType type;
  final String label;
  final String url;

  const ContactLink({
    required this.type,
    required this.label,
    required this.url,
  });

  factory ContactLink.fromJson(Map<String, dynamic> json) {
    return ContactLink(
      type: ContactType.values.firstWhere(
        (t) => t.name == json['type'],
        orElse: () => ContactType.email,
      ),
      label: json['label'] as String,
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'label': label,
      'url': url,
    };
  }

  @override
  List<Object?> get props => [type, label, url];
}
