import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'animation/splash_screen.dart';
import 'animation/welcome_screen.dart';
import 'login/register/login_screen.dart';
import 'login/register/register_screen.dart';
import 'login/password/forgot_password_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBzWrjT8pxL_yRjfURIaazi3SqBElc_oIY",
        authDomain: "ulenguage.firebaseapp.com",
        projectId: "ulenguage",
        storageBucket: "ulenguage.appspot.com",
        messagingSenderId: "250811921383",
        appId: "1:250811921383:web:98bf58c7b2f785d5028342", // Usa el appId de la web si lo tienes, este puede funcionar
        // measurementId: "G-XXXXXXXXXX", // (opcional para Analytics)
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ulenguage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD72631)),
        useMaterial3: true,
        fontFamily: 'Montserrat',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/forgot': (context) => const ForgotPasswordScreen(),
      },
    );
  }
}