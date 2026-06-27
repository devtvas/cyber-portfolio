# devtvas — Portfólio Cyber 🔐

Portfólio pessoal de **Tarcísio Valentim**, Desenvolvedor Mobile Flutter Sênior em transição para Cibersegurança.

🔗 **Live:** https://devtvas.github.io/cyber-portfolio/

## Stack

- **Flutter Web**
- **flutter_bloc** — gerenciamento de estado
- **Cloud Firestore** — conteúdo editável sem precisar fazer deploy
- **SharedPreferences** — cache local (site abre instantâneo, atualiza em segundo plano)
- **Clean Architecture** — separação em camadas (`domain`, `data`, `presentation`)
- **google_fonts** (JetBrains Mono + Inter)
- **GitHub Actions** — deploy automático no GitHub Pages a cada push na `main`

## Arquitetura

```
lib/
├── core/                  # tema, design tokens, widgets compartilhados
└── features/
    └── portfolio/
        ├── domain/
        │   ├── entities/         # Project, Experience, ContactLink, PortfolioContent
        │   └── repositories/     # abstração PortfolioRepository (D do SOLID)
        ├── data/
        │   ├── portfolio_data.dart        # seed data (referência p/ popular o Firestore)
        │   └── repositories/
        │       ├── firestore_portfolio_repository.dart   # busca remota
        │       ├── local_cache_portfolio_repository.dart  # cache local
        │       └── cached_portfolio_repository.dart        # decorator (cache + rede)
        └── presentation/   # bloc, páginas e widgets de UI
```

## ✏️ Editando o conteúdo sem fazer deploy

O conteúdo do portfólio (nome, projetos, experiências, contatos) vive no **Firestore**, não no código.
Para editar: acesse o Firebase Console → Firestore Database → coleção `portfolio` → documento `content`.

Veja o guia completo de configuração inicial em [`SETUP_FIREBASE.md`](./SETUP_FIREBASE.md).

## Rodando localmente

```bash
flutter pub get
flutter run -d chrome
```

## Build manual para web

```bash
flutter build web --release --base-href "/cyber-portfolio/"
```

## Deploy

O deploy é automático via GitHub Actions (`.github/workflows/deploy.yml`) a cada push na branch `main`.
Para habilitar pela primeira vez: **Settings → Pages → Source: GitHub Actions**.
