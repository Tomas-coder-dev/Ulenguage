import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

// PALETA DE COLORES SEGÚN IDENTIDAD Y GUÍA UI/UX
const Color kBrandRed = Color(0xFFD72631);
const Color kBg = Color(0xFFF7F7FA); // Fondo muy claro
const Color kCard = Color(0xFFFFFFFF); // Tarjeta blanco puro
const Color kTextPrimary = Color(0xFF23272E); // Gris oscuro
const Color kTextSecondary = Color(0xFF75787D); // Gris medio
const Color kShadow = Color(0x141A1A1A); // Sombra sutil

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  Future<void> _resetPassword() async {
    setState(() => isLoading = true);
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      if (!mounted) return;
      _showSnackBar(
        'Revisa tu correo electrónico para restablecer la contraseña.',
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      _showSnackBar(e.message ?? 'Error al enviar el correo.');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _showSnackBar(String msg) {
    final overlay = Overlay.of(context, rootOverlay: true);
    final entry = OverlayEntry(
      builder: (context) => Positioned(
        top: 48,
        left: 30,
        right: 30,
        child: CupertinoPopupSurface(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey6,
              borderRadius: BorderRadius.circular(13),
              boxShadow: [
                BoxShadow(
                  color: kShadow,
                  blurRadius: 9,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                msg,
                style: const TextStyle(
                  color: kBrandRed,
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    overlay.insert(entry);
    Future.delayed(const Duration(seconds: 2), entry.remove);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: kBg,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Container(
            width: 400,
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 38),
            decoration: BoxDecoration(
              color: kCard,
              borderRadius: BorderRadius.circular(28),
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
                // Logo
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://res.cloudinary.com/dd5phul5v/image/upload/v1750397736/LOGOTIPO_2.0_xhl3l4.png',
                    height: 70,
                  ),
                ),
                const SizedBox(height: 14),
                // Título principal
                const Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: kTextPrimary,
                    fontFamily: 'SF Pro Display',
                  ),
                ),
                const SizedBox(height: 10),
                // Subtítulo
                const Text(
                  'Ingresa tu correo electrónico vinculado para poder restablecer tu contraseña.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: kTextSecondary,
                    fontFamily: 'SF Pro Display',
                  ),
                ),
                const SizedBox(height: 24),
                // Input
                CupertinoTextField(
                  controller: emailController,
                  placeholder: 'Correo electrónico',
                  placeholderStyle: const TextStyle(
                    color: kTextSecondary,
                    fontFamily: 'SF Pro Display',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    color: kTextPrimary,
                    fontFamily: 'SF Pro Display',
                  ),
                  decoration: BoxDecoration(
                    color: kBg,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 14,
                  ),
                ),
                const SizedBox(height: 22),
                // Botón principal: rojo, acción clave
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton.filled(
                    borderRadius: BorderRadius.circular(18),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    onPressed: isLoading ? null : _resetPassword,
                    child: isLoading
                        ? const CupertinoActivityIndicator(
                            color: CupertinoColors.white,
                          )
                        : const Text(
                            "Restablecer contraseña",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: 'SF Pro Display',
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 12),
                // Botón secundario: texto, limpio y claro
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Volver a iniciar sesión',
                    style: TextStyle(
                      color: kBrandRed,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SF Pro Display',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
