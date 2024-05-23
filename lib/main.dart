import 'package:firebase_core/firebase_core.dart';
import 'package:ponto_eletronico/screens/login.dart';
import 'package:ponto_eletronico/util/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// ignore: prefer_typing_uninitialized_variables
late final kToken;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLogged = await verifyToken();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(PontoEletronico(isLogged: isLogged));
}

Future<bool> verifyToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? token = preferences.getString("accessToken");
  if (token != null) {
    kToken = token;
    return true;
  }
  return false;
}

class PontoEletronico extends StatelessWidget {
  final bool isLogged;
  const PontoEletronico({super.key, required this.isLogged});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ponto Eletrônico',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('pt', 'BR')
      ],
      theme: theme,
      initialRoute: isLogged ? "home" : "login",
      routes: {
        "home": (context) => const HomeScreen(title: 'Registro de Ponto'),
        "login": (context) => LoginScreen(),
      },
    );
  }
}
