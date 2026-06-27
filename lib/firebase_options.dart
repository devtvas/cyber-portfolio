// ⚠️ ARQUIVO DE EXEMPLO — substitua os valores abaixo pelas chaves
// reais do SEU projeto Firebase antes de rodar o app.
//
// Onde encontrar essas chaves:
// Firebase Console → Project Settings (ícone de engrenagem) →
// role até "Seus apps" → selecione o app Web → "Configuração do SDK".
//
// Alternativa automática (caso decida usar no futuro):
//   dart pub global activate flutterfire_cli
//   flutterfire configure
// Isso gera este arquivo automaticamente com as chaves corretas.

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform => web;

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyAO-Oe8ojrtXijJvafCxdynQh0Q2NYT6iQ",
      authDomain: "cyber-portfolio-b25aa.firebaseapp.com",
      projectId: "cyber-portfolio-b25aa",
      storageBucket: "cyber-portfolio-b25aa.firebasestorage.app",
      messagingSenderId: "594464194909",
      appId: "1:594464194909:web:b7bc6173e208daa10868b4",
      measurementId: "G-C7TY9SL6XY");
}
