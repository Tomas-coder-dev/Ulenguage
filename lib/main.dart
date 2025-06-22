import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'login/login_screen.dart' as login;
import 'register/register_screen.dart' as register;
import 'inicio/inicio_screen_adino.dart';
import 'perfil/perfil_screen_andino.dart';
import 'Explorar/explorar_screen_andino.dart';
import 'Traduccion/traducir_screen_andino.dart';

// Paleta base
const Color kRed = Color(0xFFEF233C);
const Color kBg = Color(0xFFF6F6F9);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        scaffoldBackgroundColor: kBg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kRed,
          primary: kRed,
          surface: kBg, // ¡surface recomendado!
        ),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const login.LoginScreen(),
        '/register': (_) => const register.RegisterScreen(),
        '/inicio': (_) => const MainScaffold(),
        '/perfil': (_) => const PerfilScreen(),
        '/explorar': (_) => const ExplorarScreen(),
        '/traducir': (_) => const TraducirScreen(),
      },
    );
  }
}

/// Barra de navegación y páginas principales iOS nativa
class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});
  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const InicioScreen(),
    const TraducirScreen(),
    Container(), // Central (puedes poner aquí tu pantalla de escaneo/cámara)
    const ExplorarScreen(),
    const PerfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: kBg,
        activeColor: kRed,
        inactiveColor: CupertinoColors.systemGrey,
        iconSize: 27,
        border: null,
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house_fill),
            label: 'Inicio',
          ),
          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.globe),
            label: 'Traducir',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                color: kRed,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: kRed.withOpacity(0.18),
                    blurRadius: 14,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(9),
              child: const Icon(
                CupertinoIcons.camera_fill,
                color: CupertinoColors.white,
                size: 29,
              ),
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.map_fill),
            label: 'Explorar',
          ),
          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_crop_circle),
            label: 'Perfil',
          ),
        ],
      ),
      tabBuilder: (context, index) => _pages[index],
    );
  }
}
