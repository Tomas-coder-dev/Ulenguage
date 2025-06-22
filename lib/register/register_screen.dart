import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// PALETA DE COLORES SEGÚN IDENTIDAD Y GUÍA UI/UX
const Color kBrandRed = Color(0xFFD72631);
const Color kBg = Color(0xFFF7F7FA); // Fondo muy claro
const Color kCard = Color(0xFFFFFFFF); // Tarjeta blanco puro
const Color kTextPrimary = Color(0xFF23272E); // Gris oscuro
const Color kTextSecondary = Color(0xFF75787D); // Gris medio
const Color kBorder = Color(0xFFECECEC); // Bordes sutiles
const Color kShadow = Color(0x141A1A1A); // Sombra sutil

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isLoading = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => isLoading = true);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (!mounted) return;

      Navigator.pushReplacementNamed(context, '/inicio');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("¡Registro exitoso! Bienvenido")),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Error al registrar')),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> _registerWithGoogle() async {
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

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("¡Registro con Google exitoso! Bienvenido"),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error con Google: $e")));
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  InputDecoration _inputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: const TextStyle(
        color: kTextSecondary,
        fontFamily: 'SF Pro Display',
      ),
      hintStyle: const TextStyle(
        color: kTextSecondary,
        fontFamily: 'SF Pro Display',
      ),
      filled: true,
      fillColor: kBg,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Container(
            width: 400,
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 38),
            decoration: BoxDecoration(
              color: kCard,
              borderRadius: BorderRadius.circular(28),
              boxShadow: const [
                BoxShadow(color: kShadow, blurRadius: 18, offset: Offset(0, 6)),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      'https://res.cloudinary.com/dd5phul5v/image/upload/v1750397736/LOGOTIPO_2.0_xhl3l4.png',
                      height: 75,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    "Crear una cuenta",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: kTextPrimary,
                      fontFamily: 'SF Pro Display',
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    "Completa tus datos para comenzar a aprender",
                    style: TextStyle(
                      fontSize: 15,
                      color: kTextSecondary,
                      fontFamily: 'SF Pro Display',
                    ),
                  ),
                  const SizedBox(height: 22),
                  TextFormField(
                    controller: nameController,
                    style: const TextStyle(
                      color: kTextPrimary,
                      fontFamily: 'SF Pro Display',
                    ),
                    decoration: _inputDecoration(
                      'Nombre completo',
                      'Tu nombre y apellido',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese su nombre completo';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      color: kTextPrimary,
                      fontFamily: 'SF Pro Display',
                    ),
                    decoration: _inputDecoration(
                      'Correo electrónico',
                      'example@email.com',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese su correo';
                      }
                      if (!value.contains('@')) {
                        return 'Ingrese un correo válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(
                      color: kTextPrimary,
                      fontFamily: 'SF Pro Display',
                    ),
                    decoration: _inputDecoration(
                      'Número de teléfono',
                      '+123 456 789',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese su número de teléfono';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: birthController,
                    style: const TextStyle(
                      color: kTextPrimary,
                      fontFamily: 'SF Pro Display',
                    ),
                    decoration: _inputDecoration(
                      'Fecha de nacimiento',
                      'DD / MM / YYYY',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese su fecha de nacimiento';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: passwordController,
                    obscureText: obscurePassword,
                    style: const TextStyle(
                      color: kTextPrimary,
                      fontFamily: 'SF Pro Display',
                    ),
                    decoration: _inputDecoration('Contraseña', '').copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: kTextSecondary,
                        ),
                        onPressed: () {
                          setState(() => obscurePassword = !obscurePassword);
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese su contraseña';
                      }
                      if (value.length < 6) {
                        return 'La contraseña debe tener al menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: obscureConfirmPassword,
                    style: const TextStyle(
                      color: kTextPrimary,
                      fontFamily: 'SF Pro Display',
                    ),
                    decoration: _inputDecoration('Confirmar contraseña', '')
                        .copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: kTextSecondary,
                            ),
                            onPressed: () {
                              setState(
                                () => obscureConfirmPassword =
                                    !obscureConfirmPassword,
                              );
                            },
                          ),
                        ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirme su contraseña';
                      }
                      if (value != passwordController.text) {
                        return 'Las contraseñas no coinciden';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kBrandRed,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'SF Pro Display',
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        elevation: 0,
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.6,
                              ),
                            )
                          : const Text("Crear cuenta"),
                    ),
                  ),
                  const SizedBox(height: 13),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: isLoading ? null : _registerWithGoogle,
                      icon: Image.network(
                        'https://img.icons8.com/?size=100&id=YpTJTJYKapL1&format=png&color=000000',
                        height: 22,
                      ),
                      label: const Text(
                        "Registrarse con Google",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'SF Pro Display',
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: kTextPrimary,
                        side: const BorderSide(color: kBrandRed, width: 2),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        textStyle: const TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "¿Ya tienes una cuenta?",
                        style: TextStyle(
                          color: kTextSecondary,
                          fontFamily: 'SF Pro Display',
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: kBrandRed,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SF Pro Display',
                          ),
                        ),
                        child: const Text("Iniciar sesión"),
                      ),
                    ],
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
