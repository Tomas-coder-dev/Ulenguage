import 'package:flutter/material.dart';

// PALETA DE COLORES SEGÚN TU BRANDING Y REGLAS
const Color kBrandRed = Color(0xFFD72631);
const Color kBg = Color(0xFFF7F7FA); // Fondo principal, muy claro
const Color kCard = Color(0xFFFFFFFF); // Tarjeta/Container blanco puro
const Color kTextPrimary = Color(
  0xFF23272E,
); // Gris oscuro para textos principales
const Color kTextSecondary = Color(
  0xFF75787D,
); // Gris medio para textos secundarios
const Color kBorder = Color(0xFFECECEC); // Bordes y divisores sutiles
const Color kShadow = Color(0x141A1A1A); // Sombra muy sutil

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
              decoration: BoxDecoration(
                color: kCard,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: kShadow,
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Hero(
                    tag: "app_logo",
                    child: Image.network(
                      "https://res.cloudinary.com/dd5phul5v/image/upload/v1750397736/LOGOTIPO_2.0_xhl3l4.png",
                      height: 128,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    "Bienvenido a Ulenguage",
                    style: const TextStyle(
                      color: kTextPrimary,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      fontFamily: 'SF Pro Display', // iOS style
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Aprende lenguas originarias\ncon tecnología moderna",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: kTextSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'SF Pro Display',
                    ),
                  ),
                  const SizedBox(height: 32),
                  // BOTÓN PRINCIPAL: Rojo de marca, solo CTA principal
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.login,
                        color: Colors.white,
                        size: 22,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kBrandRed,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      label: const Text(
                        "Iniciar Sesión",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'SF Pro Display',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // BOTÓN SECUNDARIO: Outline, rojo solo en borde e icono
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      icon: const Icon(
                        Icons.person_add_alt_1_rounded,
                        color: kBrandRed,
                        size: 22,
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: kBrandRed, width: 1.6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: kCard,
                        foregroundColor: kBrandRed,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      label: const Text(
                        "Registrarse",
                        style: TextStyle(
                          color: kBrandRed,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'SF Pro Display',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Link de Olvidaste tu contraseña: solo texto, color gris oscuro, limpio
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgot');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: kTextPrimary,
                      padding: EdgeInsets.zero,
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                    child: const Text("¿Olvidaste tu Contraseña?"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
