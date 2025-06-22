import 'package:flutter/cupertino.dart';

const Color kBrandRed = Color(0xFFD72631);
const Color kBg = Color(0xFFF7F7FA);
const Color kCard = Color(0xFFFFFFFF);
const Color kTextPrimary = Color(0xFF23272E);
const Color kTextSecondary = Color(0xFF75787D);
const Color kBorder = Color(0xFFECECEC);
const Color kShadow = Color(0x141A1A1A);
const Color kSuccess = Color(0xFF50C878);
const Color kPurple = Color(0xFF8B5CF6);
const Color kYellow = Color(0xFFFFE066);

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulación de datos de usuario (tipado correcto)
    final String nombre = "Fabricio Quispe";
    final String avatar = "https://randomuser.me/api/portraits/men/62.jpg";
    final int nivel = 3;
    final String rol = "Explorador Cultural";
    final double progreso = 0.68;
    final int logros = 7;
    final int objetos = 23;
    final int traducciones = 57;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Perfil'),
        backgroundColor: CupertinoColors.white,
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            // Navega a configuración
          },
          child: const Icon(CupertinoIcons.settings, color: kYellow),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(18),
                children: [
                  // Card de usuario
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: kCard,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: kShadow,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 76,
                          height: 76,
                          decoration: BoxDecoration(
                            color: kYellow.withAlpha(41),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(avatar),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nombre,
                                style: const TextStyle(
                                  color: kTextPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'SF Pro Display',
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    CupertinoIcons.star_fill,
                                    color: kYellow,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "Nivel $nivel • $rol",
                                    style: const TextStyle(
                                      color: kTextSecondary,
                                      fontSize: 13,
                                      fontFamily: 'SF Pro Display',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Progreso
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  height: 8,
                                  color: kBorder,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      height: 8,
                                      width: 180 * progreso,
                                      decoration: BoxDecoration(
                                        color: kBrandRed,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${(progreso * 100).toStringAsFixed(0)}% al siguiente nivel",
                                style: const TextStyle(
                                  color: kTextSecondary,
                                  fontSize: 12,
                                  fontFamily: 'SF Pro Display',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  // Estadísticas rápidas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _PerfilStat(
                        icon: CupertinoIcons.star_fill,
                        color: kYellow,
                        label: "Logros",
                        value: logros.toString(),
                      ),
                      _PerfilStat(
                        // Cambiado a un icono Cupertino válido
                        icon: CupertinoIcons
                            .cube_box, // Antes: CupertinoIcons.leaf (no existe)
                        color: kPurple,
                        label: "Objetos",
                        value: objetos.toString(),
                      ),
                      _PerfilStat(
                        icon: CupertinoIcons.globe,
                        color: kBrandRed,
                        label: "Traducciones",
                        value: traducciones.toString(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 23),
                  // Opciones de perfil
                  const Text(
                    "Opciones",
                    style: TextStyle(
                      color: kTextPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'SF Pro Display',
                    ),
                  ),
                  const SizedBox(height: 10),
                  _PerfilOption(
                    icon: CupertinoIcons.pencil,
                    color: kBrandRed,
                    label: "Editar perfil",
                    onTap: () {},
                  ),
                  _PerfilOption(
                    icon: CupertinoIcons.lock,
                    color: kPurple,
                    label: "Seguridad y privacidad",
                    onTap: () {},
                  ),
                  _PerfilOption(
                    icon: CupertinoIcons.clock,
                    color: kYellow,
                    label: "Historial de actividad",
                    onTap: () {},
                  ),
                  _PerfilOption(
                    icon: CupertinoIcons.square_arrow_right,
                    color: kTextSecondary,
                    label: "Cerrar sesión",
                    onTap: () {
                      // Implementa lógica de logout
                    },
                  ),
                  const SizedBox(height: 20),
                  // Información institucional
                  Center(
                    child: Text(
                      "App Andina © 2025\nUNSAAC - Cusco",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kTextSecondary.withAlpha(166),
                        fontSize: 12,
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _AndinoBottomNavBar(
              currentIndex: 4,
              onTab: (i) {
                final routes = [
                  '/inicio',
                  '/traducir',
                  '/camara',
                  '/explorar',
                  '/perfil',
                ];
                if (i == 4) return;
                Navigator.of(context).pushReplacementNamed(routes[i]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PerfilStat extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;
  const _PerfilStat({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: color.withAlpha(41),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: kTextPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 15,
            fontFamily: 'SF Pro Display',
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: kTextSecondary,
            fontSize: 12,
            fontFamily: 'SF Pro Display',
          ),
        ),
      ],
    );
  }
}

class _PerfilOption extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;
  const _PerfilOption({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withAlpha(33),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: kTextPrimary,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'SF Pro Display',
                  fontSize: 15,
                ),
              ),
            ),
            const Icon(
              CupertinoIcons.chevron_forward,
              color: kBorder,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

// Barra de navegación inferior estilo Cupertino
class _AndinoBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTab;
  const _AndinoBottomNavBar({required this.currentIndex, required this.onTab});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabBar(
      backgroundColor: CupertinoColors.white,
      activeColor: kBrandRed,
      inactiveColor: CupertinoColors.inactiveGray,
      iconSize: 26,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.refresh),
          label: 'Traducir',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.camera),
          label: 'Escanear',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.map),
          label: 'Explorar',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person),
          label: 'Perfil',
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTab,
    );
  }
}
