import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // <- este archivo debe estar en /lib

import 'login/login_screen.dart' as login;
import 'register/register_screen.dart' as register;
import 'Inicio/inicio_screen_andino.dart';
import 'perfil/perfil_screen_andino.dart';
import 'Explorar/explorar_screen_andino.dart';
import 'Traduccion/traducir_screen_andino.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // ¡Esto arregla tu error!
  );
  runApp(const AndinaApp());
}

class AndinaApp extends StatelessWidget {
  const AndinaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Andina',
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'SF Pro Display',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD72631),
          primary: const Color(0xFFD72631),
          surface: const Color(
            0xFFF7F7FA,
          ), // ¡Usa 'surface' en vez de 'background'!
        ),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const login.LoginScreen(),
        '/register': (_) => const register.RegisterScreen(),
        '/inicio': (_) => const InicioScreen(),
        '/perfil': (_) => const PerfilScreen(),
        '/explorar': (_) => const ExplorarScreen(),
        '/traducir': (_) => const TraducirScreen(),
      },
    );
  }
}
