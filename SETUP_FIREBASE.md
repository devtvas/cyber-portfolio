# 🔥 Setup do Firebase/Firestore

Guia passo a passo para conectar o portfólio ao Firestore, permitindo editar o conteúdo sem precisar dar `git push`.

---

## 1. Criar o projeto no Firebase

1. Acesse https://console.firebase.google.com
2. **Adicionar projeto** → dê um nome (ex: `cyber-portfolio`)
3. Pode desabilitar o Google Analytics (não é necessário aqui)

## 2. Registrar um app Web

1. No painel do projeto, clique no ícone **`</>`** (Web)
2. Apelido do app: `cyber-portfolio-web`
3. **Não** marque "Configurar Firebase Hosting" (estamos usando GitHub Pages)
4. Copie o objeto de configuração que aparece, algo como:

```js
const firebaseConfig = {
  apiKey: "AIza...",
  authDomain: "cyber-portfolio.firebaseapp.com",
  projectId: "cyber-portfolio",
  storageBucket: "cyber-portfolio.appspot.com",
  messagingSenderId: "123456789",
  appId: "1:123456789:web:abc123"
};
```

## 3. Preencher `lib/firebase_options.dart`

Abra o arquivo `lib/firebase_options.dart` no projeto e substitua os placeholders pelos valores que você copiou:

| Placeholder no código | Valor do Firebase Console |
|---|---|
| `SUA_API_KEY_AQUI` | `apiKey` |
| `SEU_APP_ID_AQUI` | `appId` |
| `SEU_SENDER_ID_AQUI` | `messagingSenderId` |
| `SEU_PROJECT_ID_AQUI` | `projectId` |

## 4. Criar o Firestore Database

1. No menu lateral: **Build → Firestore Database**
2. **Criar banco de dados**
3. Modo: **Produção** (vamos configurar regras de segurança no passo 6)
4. Localização: escolha `southamerica-east1` (São Paulo) para menor latência

## 5. Criar o documento de conteúdo

1. Clique em **Iniciar coleção**
2. **ID da coleção:** `portfolio`
3. **ID do documento:** `content`
4. Adicione os campos abaixo (use o conteúdo de `lib/features/portfolio/data/portfolio_data.dart` como referência do que preencher):

| Campo | Tipo | Exemplo |
|---|---|---|
| `name` | string | `Tarcísio Valentim` |
| `role` | string | `Desenvolvedor Mobile Flutter Sênior` |
| `location` | string | `Goiânia – GO` |
| `summary` | string | *(o texto de resumo)* |
| `skills` | array de strings | `["Flutter & Dart", "Firebase", ...]` |
| `experiences` | array de maps | *(ver estrutura abaixo)* |
| `projects` | array de maps | *(ver estrutura abaixo)* |
| `contacts` | array de maps | *(ver estrutura abaixo)* |

### Estrutura de cada item em `experiences` (array de map):
```json
{
  "company": "Rumina / Claro Brasil / Tech Partners",
  "role": "Engenheiro de Software Mobile (Flutter)",
  "period": "2021 — Atual",
  "stack": "Flutter, Dart, Modular Architecture, Bloc/Cubit, Firebase, CI/CD",
  "highlights": [
    "Implementação de Arquitetura Modular...",
    "Liderança na integração com APIs REST..."
  ]
}
```

### Estrutura de cada item em `projects` (array de map):
```json
{
  "title": "Plataformas Mobile Corporativas & Fintech",
  "description": "Concepção arquitetural e desenvolvimento modular...",
  "stack": ["Flutter", "Modular", "REST APIs", "Firebase"]
}
```

### Estrutura de cada item em `contacts` (array de map):
```json
{
  "type": "email",
  "label": "tarcisio.word@gmail.com",
  "url": "mailto:tarcisio.word@gmail.com"
}
```
> `type` aceita exatamente: `email`, `linkedin` ou `github`.

> 💡 **Dica:** no painel do Firestore, ao criar um campo do tipo *array*, você pode adicionar itens do tipo *map* dentro dele e preencher campo por campo visualmente — não precisa escrever JSON na mão.

## 6. Configurar regras de segurança (importante!)

Por padrão, o Firestore em modo Produção **bloqueia tudo**. Como o conteúdo é público (qualquer visitante do site precisa LER, mas só você precisa EDITAR), configure assim:

**Build → Firestore Database → Regras**, cole:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /portfolio/{document} {
      allow read: if true;
      allow write: if false; // edite manualmente pelo Console
    }
  }
}
```

Isso permite que o site **leia** os dados publicamente, mas a **escrita só pode ser feita por você**, direto no painel do Firebase Console (ninguém de fora pode alterar via código).

## 7. Testar

```bash
flutter pub get
flutter run -d chrome
```

Se tudo estiver certo, o site vai carregar os dados direto do Firestore. Para editar qualquer informação depois, **basta voltar no Firestore Console e mudar o campo desejado** — sem precisar tocar em código ou fazer deploy.

---

## ⚠️ Nota sobre o ambiente de testes do Claude

Não tenho como testar esta integração de verdade aqui (sem Flutter SDK e sem acesso à rede do Firebase no meu ambiente). Se ao rodar você encontrar algum erro — de tipagem, de parsing do JSON, ou de configuração — me envie a mensagem de erro completa que eu ajusto o código.
