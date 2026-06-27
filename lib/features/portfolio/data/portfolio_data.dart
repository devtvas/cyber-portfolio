import 'package:cyber_portfolio/features/portfolio/domain/entities/contact_link.dart';
import 'package:cyber_portfolio/features/portfolio/domain/entities/experience.dart'
    show Experience;
import 'package:cyber_portfolio/features/portfolio/domain/entities/project.dart'
    show Project;

/// ⚠️ Este arquivo NÃO é mais a fonte de dados em runtime do app.
/// Os dados reais agora vêm do Firestore (ver [CachedPortfolioRepository]).
///
/// Serve apenas como SEED DATA: o conteúdo aqui é o que você deve colar
/// na primeira criação do documento no Firestore Console, ou usar com
/// o script de seed (ver SETUP_FIREBASE.md).
class PortfolioData {
  PortfolioData._();

  static const String name = 'Tarcísio Valentim';
  static const String role = 'Desenvolvedor Mobile Flutter Sênior';
  static const String location = 'Goiânia – GO';
  static const String summary =
      'Engenheiro de software com trajetória sólida em aplicações mobile '
      'de alta performance e arquiteturas escaláveis no ecossistema Flutter & Dart. '
      'Atuação em liderança técnica de soluções ponta a ponta — apps corporativos, '
      'fintechs e automação — com integração de sistemas complexos (REST, Firebase, gRPC). '
      'Atualmente em transição de carreira para Cibersegurança.';

  static const List<String> skills = [
    'Flutter & Dart',
    'Arquitetura Modular',
    'Gerência de Estado (Bloc/Cubit)',
    'Injeção de Dependências',
    'Firebase Ecossistema',
    'CI/CD (GitHub Actions)',
    'Node.js & APIs REST',
    'JavaScript & TypeScript',
    'SQL & SQLite',
    'Metodologias Ágeis (Scrum)',
  ];

  static const List<Experience> experiences = [
    Experience(
      company: 'Rumina / Claro Brasil / Tech Partners',
      role: 'Engenheiro de Software Mobile (Flutter)',
      period: '2021 — Atual',
      stack: 'Flutter, Dart, Modular Architecture, Bloc/Cubit, Firebase, CI/CD',
      highlights: [
        'Implementação de Arquitetura Modular em projetos complexos, garantindo manutenibilidade e testabilidade desacoplada.',
        'Liderança na integração com APIs REST, GraphQL e fluxos de autenticação OAuth2/Firebase Auth.',
        'Automação de pipelines de CI/CD via GitHub Actions e Fastlane para deploy contínuo nas lojas.',
        'Otimização de performance, mitigando gargalos de renderização e vazamentos de memória.',
      ],
    ),
    Experience(
      company: 'Microsum Tecnologia',
      role: 'Analista de Sistemas e Engenharia de Operações',
      period: '2018 — 2021',
      stack: 'JavaScript, TypeScript, SQL Server, PostgreSQL',
      highlights: [
        'Levantamento de requisitos corporativos e mapeamento de integração de ERPs.',
        'Automação de processos internos com JavaScript/TypeScript, eliminando gargalos operacionais.',
        'Análise de incidentes críticos de dados e infraestrutura.',
      ],
    ),
  ];

  static const List<Project> projects = [
    Project(
      title: 'Plataformas Mobile Corporativas & Fintech',
      description:
          'Concepção arquitetural e desenvolvimento modular de aplicações para '
          'arranjos de pagamento, carteiras digitais e benefícios corporativos. '
          'Gerenciamento de regras de negócio complexas baseadas em permissões de usuário.',
      stack: ['Flutter', 'Modular', 'REST APIs', 'Firebase'],
    ),
    Project(
      title: 'Ecossistemas de Automação de Operações em Campo',
      description:
          'Aplicativos mobile para coleta de dados em tempo real com funcionamento '
          'offline-first e sincronização resiliente com bancos de dados centrais.',
      stack: ['Flutter', 'SQLite', 'Offline-first', 'Sync'],
    ),
  ];

  static const List<ContactLink> contacts = [
    ContactLink(
      type: ContactType.email,
      label: 'tarcisio.word@gmail.com',
      url: 'mailto:tarcisio.word@gmail.com',
    ),
    ContactLink(
      type: ContactType.linkedin,
      label: 'linkedin.com/in/devtvas',
      url: 'https://linkedin.com/in/devtvas',
    ),
    ContactLink(
      type: ContactType.github,
      label: 'github.com/devtvas',
      url: 'https://github.com/devtvas',
    ),
  ];
}
