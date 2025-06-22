import 'package:flutter/material.dart';

// Paleta UIX
const Color kBrandRed = Color(0xFFD72631);
const Color kBg = Color(0xFFF7F7FA); // Fondo claro para el background final
const Color kCard = Color(0xFFFFFFFF); // Blanco puro por si se usa overlay

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoScale;
  late Animation<double> _logoFade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );
    _logoScale = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _logoFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.forward();

    Future.delayed(const Duration(milliseconds: 1700), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed("/welcome");
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fondo degradado sutil, con rojo de marca solo en la base y fondo claro arriba
    return Scaffold(
      backgroundColor: kBg,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Degradado sutil
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [kBg, kBrandRed],
                stops: [0.0, 1.0],
              ),
            ),
          ),
          // Logo animado centrado en una "tarjeta" blanca con sombra suave
          Center(
            child: FadeTransition(
              opacity: _logoFade,
              child: ScaleTransition(
                scale: _logoScale,
                child: Container(
                  decoration: BoxDecoration(
                    color: kCard,
                    borderRadius: BorderRadius.circular(36),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x291A1A1A), // sombra sutil
                        blurRadius: 26,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(34),
                  child: Hero(
                    tag: "app_logo",
                    child: Image.network(
                      "https://res.cloudinary.com/dd5phul5v/image/upload/v1750397736/LOGOTIPO_2.0_xhl3l4.png",
                      height: 120,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Opcional: Branding minimalista en la parte inferior
          Positioned(
            left: 0,
            right: 0,
            bottom: 38,
            child: FadeTransition(
              opacity: _logoFade,
              child: Text(
                "Ulenguage",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'SF Pro Display',
                  color: kCard,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  letterSpacing: 1.6,
                  shadows: [
                    Shadow(
                      color: Color(0x50000000),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
