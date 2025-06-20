import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: "app_logo",
              child: Image.network(
                "https://res.cloudinary.com/dd5phul5v/image/upload/v1750397736/LOGOTIPO_2.0_xhl3l4.png",
                height: 160,
              ),
            ),
            const SizedBox(height: 38),
            Text(
              "Bienvenido a Ulenguage",
              style: TextStyle(
                color: Color(0xFF003A71),
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Aprende lenguas originarias con tecnología moderna",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF287271),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 38),
            SizedBox(
              width: 220,
              child: ElevatedButton.icon(
                icon: Icon(Icons.login, color: Colors.white, size: 22),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD72631),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                label: const Text(
                  "Iniciar Sesión",
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: 220,
              child: OutlinedButton.icon(
                icon: Icon(Icons.person_add_alt_1_rounded, color: Color(0xFFD72631), size: 22),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFD72631), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                label: const Text(
                  "Registrarse",
                  style: TextStyle(
                      color: Color(0xFFD72631), fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 18),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/forgot');
              },
              child: const Text(
                "¿Olvidaste tu Contraseña?",
                style: TextStyle(
                    color: Color(0xFF003A71),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}