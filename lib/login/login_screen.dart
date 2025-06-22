import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../password/forgot_password_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// PALETA DE COLORES SEGÚN IDENTIDAD Y GUÍA UI/UX
const Color kBrandRed = Color(0xFFD72631);
const Color kBg = Color(0xFFF7F7FA);
const Color kCard = Color(0xFFFFFFFF);
const Color kTextPrimary = Color(0xFF23272E);
const Color kTextSecondary = Color(0xFF75787D);
const Color kBorder = Color(0xFFECECEC);
const Color kShadow = Color(0x141A1A1A);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                  blurRadius: 18,
                  offset: const Offset(0, 6),
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
                    height: 82,
                  ),
                ),
                const SizedBox(height: 16),
                // Título principal
                const Text(
                  "Bienvenido",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: kTextPrimary,
                    letterSpacing: 0.6,
                    fontFamily: 'SF Pro Display',
                  ),
                ),
                const SizedBox(height: 7),
                // Subtítulo
                const Text(
                  "Accede a tu cuenta para seguir aprendiendo",
                  style: TextStyle(
                    fontSize: 15,
                    color: kTextSecondary,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'SF Pro Display',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 26),
                // Email
                CupertinoTextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    color: kTextPrimary,
                    fontFamily: 'SF Pro Display',
                  ),
                  placeholder: 'Correo electrónico',
                  placeholderStyle: const TextStyle(color: kTextSecondary),
                  decoration: BoxDecoration(
                    color: kBg,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 14,
                  ),
                ),
                const SizedBox(height: 12),
                // Password
                CupertinoTextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  style: const TextStyle(
                    color: kTextPrimary,
                    fontFamily: 'SF Pro Display',
                  ),
                  placeholder: 'Contraseña',
                  placeholderStyle: const TextStyle(color: kTextSecondary),
                  decoration: BoxDecoration(
                    color: kBg,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 14,
                  ),
                  suffix: CupertinoButton(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    onPressed: () =>
                        setState(() => obscurePassword = !obscurePassword),
                    child: Icon(
                      obscurePassword
                          ? CupertinoIcons.eye_slash
                          : CupertinoIcons.eye,
                      color: kTextSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Olvidaste tu contraseña
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
                        color: kBrandRed,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'SF Pro Display',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Botón principal: rojo, sólo para acción
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton.filled(
                    borderRadius: BorderRadius.circular(18),
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
                const SizedBox(height: 14),
                // Botón secundario: outline con rojo, solo en borde e icono
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(
                    borderRadius: BorderRadius.circular(18),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    color: CupertinoColors.white,
                    onPressed: isLoading ? null : _signInWithGoogle,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://img.icons8.com/?size=100&id=YpTJTJYKapL1&format=png&color=000000',
                          height: 24,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Iniciar sesión con Google",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: kTextPrimary,
                            fontFamily: 'SF Pro Display',
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                // Divider visual cupertino (usando Container para evitar warnings)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Container(height: 1, color: kBorder)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "o",
                        style: TextStyle(
                          color: kTextSecondary,
                          fontFamily: 'SF Pro Display',
                        ),
                      ),
                    ),
                    Expanded(child: Container(height: 1, color: kBorder)),
                  ],
                ),
                const SizedBox(height: 9),
                // Registro
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "¿No tienes una cuenta?",
                      style: TextStyle(
                        color: kTextSecondary,
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/register');
                      },
                      child: const Text(
                        "Regístrate",
                        style: TextStyle(
                          color: kBrandRed,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SF Pro Display',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
