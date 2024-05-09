import 'package:firebase_core/firebase_core.dart';
import 'package:ponto_eletronico/theme.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

import 'screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const PontoEletronico());
}

class PontoEletronico extends StatelessWidget {
  const PontoEletronico({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ponto Eletrônico',
      theme: theme,
      home: const MyHomePage(title: 'Registro de Ponto'),
    );
  }
}



