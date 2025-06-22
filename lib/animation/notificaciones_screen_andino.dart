import 'package:flutter/material.dart';

// PALETA ANDINA Y DE MARCA SEGÚN GUÍA
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

class NotificacionesScreen extends StatelessWidget {
  const NotificacionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notificaciones = [
      {
        "titulo": "¡Nuevo logro desbloqueado!",
        "detalle": "Has alcanzado el nivel 4. ¡Sigue explorando y traduciendo!",
        "hora": "Hace 2 min",
        "icon": Icons.emoji_events,
        "color": kYellow,
        "leido": false,
      },
      {
        "titulo": "Traducción guardada",
        "detalle": "Agregaste una traducción a tus favoritos.",
        "hora": "Hace 12 min",
        "icon": Icons.translate,
        "color": kBrandRed,
        "leido": true,
      },
      {
        "titulo": "Nuevo objeto descubierto",
        "detalle": "Encontraste un objeto cultural: 'Tumi'.",
        "hora": "Ayer",
        "icon": Icons.pets,
        "color": kSuccess,
        "leido": false,
      },
      {
        "titulo": "Ruta completada",
        "detalle": "¡Completaste la ruta Sacsayhuamán!",
        "hora": "Ayer",
        "icon": Icons.map_rounded,
        "color": kPurple,
        "leido": true,
      },
    ];

    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        backgroundColor: kBrandRed,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Notificaciones',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'SF Pro Display',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_rounded, color: kYellow),
            tooltip: "Limpiar todo",
            onPressed: () {
              // Limpiar notificaciones (lógica pendiente)
            },
          ),
        ],
      ),
      body: SafeArea(
        child: notificaciones.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.notifications_off, color: kBrandRed, size: 54),
                    const SizedBox(height: 10),
                    const Text(
                      "Sin notificaciones por ahora",
                      style: TextStyle(
                        color: kTextSecondary,
                        fontSize: 16,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),
                itemCount: notificaciones.length,
                separatorBuilder: (context, i) => const SizedBox(height: 13),
                itemBuilder: (context, i) {
                  final n = notificaciones[i];
                  return Container(
                    decoration: BoxDecoration(
                      color: n["leido"]
                          ? kCard
                          : kBrandRed.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: kShadow,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      border: n["leido"]
                          ? null
                          : Border.all(
                              color: kBrandRed.withValues(alpha: 0.18),
                              width: 1,
                            ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: n["color"].withValues(alpha: 0.15),
                        child: Icon(n["icon"], color: n["color"]),
                      ),
                      title: Text(
                        n["titulo"],
                        style: TextStyle(
                          color: kTextPrimary,
                          fontWeight: n["leido"]
                              ? FontWeight.w500
                              : FontWeight.bold,
                          fontFamily: 'SF Pro Display',
                          fontSize: 15,
                        ),
                      ),
                      subtitle: Text(
                        n["detalle"],
                        style: const TextStyle(
                          color: kTextSecondary,
                          fontSize: 13,
                          fontFamily: 'SF Pro Display',
                        ),
                      ),
                      trailing: Text(
                        n["hora"],
                        style: TextStyle(
                          color: n["leido"] ? kTextSecondary : kBrandRed,
                          fontSize: 12,
                          fontFamily: 'SF Pro Display',
                        ),
                      ),
                      onTap: () {
                        // Marcar como leído, ir al detalle, etc.
                      },
                    ),
                  );
                },
              ),
      ),
      bottomNavigationBar: _AndinoBottomNavBar(
        currentIndex: -1,
        onTab: (i) {
          // Implementa navegación entre tabs
        },
      ),
    );
  }
}

// Barra de navegación inferior con FAB central (igual que en Inicio)
class _AndinoBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTab;
  const _AndinoBottomNavBar({required this.currentIndex, required this.onTab});

  @override
  Widget build(BuildContext context) {
    final items = [
      _NavItem(icon: Icons.home_rounded, label: 'Inicio'),
      _NavItem(icon: Icons.translate, label: 'Traducir'),
      _NavItem(icon: Icons.camera_alt_rounded, label: 'Escanear', isFab: true),
      _NavItem(icon: Icons.map_rounded, label: 'Explorar'),
      _NavItem(icon: Icons.person_rounded, label: 'Perfil'),
    ];
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 66,
              decoration: const BoxDecoration(
                color: kBrandRed,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: kShadow,
                    blurRadius: 12,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 0; i < items.length; i++)
                    if (i == 2)
                      const SizedBox(width: 54)
                    else
                      _NavButton(
                        item: items[i],
                        isActive: i == currentIndex,
                        onTap: () => onTab(i),
                      ),
                ],
              ),
            ),
            // FAB central destacado
            Positioned(
              bottom: 20,
              child: GestureDetector(
                onTap: () => onTab(2),
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: kYellow,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: kBrandRed.withValues(alpha: 0.3),
                        blurRadius: 19,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(items[2].icon, color: kBrandRed, size: 34),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final bool isFab;
  const _NavItem({required this.icon, required this.label, this.isFab = false});
}

class _NavButton extends StatelessWidget {
  final _NavItem item;
  final bool isActive;
  final VoidCallback onTap;
  const _NavButton({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 54,
        height: 66,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, color: isActive ? kYellow : Colors.white, size: 28),
            const SizedBox(height: 3),
            Text(
              item.label,
              style: TextStyle(
                color: isActive ? kYellow : Colors.white,
                fontSize: 10,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w400,
                fontFamily: 'SF Pro Display',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
