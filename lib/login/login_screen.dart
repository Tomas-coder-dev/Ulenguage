import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../password/forgot_password_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// PALETA
const Color kRed = Color(0xFFEF233C);
const Color kBg = Color(0xFFF6F6F9);
const Color kCard = Color(0xFFFFFFFF);
const Color kText = Color(0xFF212529);
const Color kText2 = Color(0xFF868E96);
const Color kGreen = Color(0xFF50C878);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool obscurePassword = true;

  Future<void> _signIn() async {
    setState(() => isLoading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/inicio');
      _showSnackBar("¡Bienvenido!");
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      _showSnackBar(e.message ?? 'Error al iniciar sesión');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() => isLoading = true);
    try {
      final googleSignIn = GoogleSignIn(
        clientId: kIsWeb
            ? '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.apps.googleusercontent.com'
            : null,
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        if (mounted) setState(() => isLoading = false);
        return;
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/inicio');
      _showSnackBar("Sesión iniciada con Google");
    } catch (e) {
      if (!mounted) return;
      _showSnackBar("Error con Google: $e");
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
              color: kCard,
              borderRadius: BorderRadius.circular(13),
              boxShadow: [
                BoxShadow(
                  color: kRed.withOpacity(0.07),
                  blurRadius: 9,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                msg,
                style: const TextStyle(
                  color: kRed,
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

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscure = false,
    VoidCallback? toggle,
  }) {
    return CupertinoTextField(
      controller: controller,
      keyboardType: isPassword
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
      obscureText: isPassword ? obscure : false,
      style: const TextStyle(color: kText, fontFamily: 'SF Pro Display'),
      placeholder: hint,
      prefix: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Icon(icon, color: kText2, size: 22),
      ),
      suffix: isPassword
          ? CupertinoButton(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              onPressed: toggle,
              child: Icon(
                obscure ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                color: kText2,
              ),
            )
          : null,
      placeholderStyle: const TextStyle(color: kText2),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: kBg,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 45),
              // Logo y título
              Container(
                margin: const EdgeInsets.only(bottom: 32),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: kCard,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Image.network(
                        'https://res.cloudinary.com/dd5phul5v/image/upload/v1750397736/LOGOTIPO_2.0_xhl3l4.png',
                        height: 54,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      "Inicia sesión",
                      style: TextStyle(
                        color: kText,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SF Pro Display',
                        fontSize: 22,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: kCard,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _inputField(
                      controller: emailController,
                      hint: "Correo electrónico",
                      icon: CupertinoIcons.mail,
                    ),
                    const SizedBox(height: 14),
                    _inputField(
                      controller: passwordController,
                      hint: "Contraseña",
                      icon: CupertinoIcons.lock,
                      isPassword: true,
                      obscure: obscurePassword,
                      toggle: () =>
                          setState(() => obscurePassword = !obscurePassword),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => const ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "¿Olvidaste tu contraseña?",
                          style: TextStyle(
                            color: kRed,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SF Pro Display',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoButton(
                        borderRadius: BorderRadius.circular(16),
                        color: kRed,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        onPressed: isLoading ? null : _signIn,
                        child: isLoading
                            ? const CupertinoActivityIndicator(
                                color: CupertinoColors.white,
                              )
                            : const Text(
                                "Iniciar Sesión",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'SF Pro Display',
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoButton(
                        borderRadius: BorderRadius.circular(16),
                        color: kCard,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        onPressed: isLoading ? null : _signInWithGoogle,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              'https://img.icons8.com/?size=100&id=YpTJTJYKapL1&format=png&color=000000',
                              height: 22,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "Iniciar sesión con Google",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: kText,
                                fontFamily: 'SF Pro Display',
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "¿No tienes una cuenta?",
                          style: TextStyle(
                            color: kText2,
                            fontFamily: 'SF Pro Display',
                            fontSize: 15,
                          ),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              '/register',
                            );
                          },
                          child: const Text(
                            "Regístrate",
                            style: TextStyle(
                              color: kRed,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SF Pro Display',
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
