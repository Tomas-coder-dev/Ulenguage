import 'package:flutter/cupertino.dart';
import '../widgets/andino_bottom_nav_bar.dart';
import '../widgets/quick_card.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Allin Tuta, Fabricio!'),
        backgroundColor: CupertinoColors.white,
        trailing: Icon(CupertinoIcons.bell_fill, color: Color(0xFFD72631)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                children: [
                  // Header
                  Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Buen Día, Explorador Cultural",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SF Pro Display',
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          "Listo para descubrir más de Cusco",
                          style: TextStyle(
                            color: CupertinoColors.systemGrey,
                            fontSize: 15,
                            fontFamily: 'SF Pro Display',
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Progreso Cultural
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFFD72631,
                          ).withValues(alpha: 0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Progreso Cultural",
                              style: TextStyle(
                                color: Color(0xFFD72631),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'SF Pro Display',
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFFD72631,
                                ).withValues(alpha: 0.14),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: const [
                                  Icon(
                                    CupertinoIcons.star_fill,
                                    color: Color(0xFFD72631),
                                    size: 15,
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    "3",
                                    style: TextStyle(color: Color(0xFFD72631)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Linear progress bar iOS style
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          child: Container(
                            height: 8,
                            color: CupertinoColors.systemGrey5,
                            child: Stack(
                              children: [
                                FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: 0.65,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFD72631),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "65% Hacia el siguiente nivel",
                          style: TextStyle(
                            color: CupertinoColors.systemGrey,
                            fontSize: 13,
                            fontFamily: 'SF Pro Display',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Tarjetas rápidas
                  SizedBox(
                    height: 160,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        QuickCard(
                          title: "Traducciones",
                          value: "12 Hoy",
                          icon: CupertinoIcons.arrow_2_squarepath,
                          color: Color(0xFFD72631),
                          subtitle: "Traducción Manual",
                        ),
                        QuickCard(
                          title: "Lugares Explorados",
                          value: "3",
                          icon: CupertinoIcons.map_fill,
                          color: Color(0xFF50C878),
                          subtitle: "Rutas Completadas",
                        ),
                        QuickCard(
                          title: "Traducciones",
                          value: "45",
                          icon: CupertinoIcons.globe,
                          color: Color(0xFFFFE066),
                          subtitle: "Modo Sin Conexión",
                        ),
                        QuickCard(
                          title: "Objetos Culturales",
                          value: "5",
                          icon: CupertinoIcons.person_crop_rectangle,
                          color: Color(0xFFD72631),
                          subtitle: "¡Sigue Así!",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  // Gestión Offline
                  Container(
                    margin: const EdgeInsets.only(bottom: 24, top: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: CupertinoColors.systemGrey.withValues(
                            alpha: 0.09,
                          ),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          CupertinoIcons.cloud,
                          color: CupertinoColors.systemGrey,
                          size: 28,
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Gestión Offline",
                                style: TextStyle(
                                  color: CupertinoColors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontFamily: 'SF Pro Display',
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "Administra contenido sin conexión",
                                style: TextStyle(
                                  color: CupertinoColors.systemGrey,
                                  fontSize: 13,
                                  fontFamily: 'SF Pro Display',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          CupertinoIcons.settings,
                          color: CupertinoColors.systemGrey,
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AndinoBottomNavBar(
              currentIndex: 0,
              onTab: (i) {
                if (i == 0) return;
                final routes = [
                  '/inicio',
                  '/traducir',
                  '/camara',
                  '/explorar',
                  '/perfil',
                ];
                Navigator.of(context).pushReplacementNamed(routes[i]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
