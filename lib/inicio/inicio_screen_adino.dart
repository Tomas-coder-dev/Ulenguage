import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// PALETA
const Color kRed = Color(0xFFEF233C);
const Color kBg = Color(0xFFF6F6F9);
const Color kCard = Color(0xFFFFFFFF);
const Color kTextMain = Color(0xFF212529);
const Color kTextSoft = Color(0xFF868E96);
const Color kGreen = Color(0xFF50C878);

class InicioScreen extends StatelessWidget {
  final String userName;
  const InicioScreen({super.key, this.userName = "Explorador"});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: kBg,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
        border: null,
        middle: Text(
          "¡Allin p'unchay, $userName!",
          style: const TextStyle(
            color: kTextMain,
            fontWeight: FontWeight.bold,
            fontFamily: 'SF Pro Display',
            fontSize: 18,
          ),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          minSize: 0,
          onPressed: () {},
          child: const Icon(CupertinoIcons.bell_fill, color: kRed, size: 25),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: [
            // Estado y Paquetes (minimalista)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _StatusChip(
                  icon: CupertinoIcons.wifi,
                  text: "Conectado",
                  color: kGreen,
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  onPressed: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: kCard,
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(color: kRed.withOpacity(.13)),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          CupertinoIcons.cloud_download,
                          color: kRed,
                          size: 17,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Offline",
                          style: TextStyle(
                            color: kRed,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // PROGRESO
            Container(
              decoration: BoxDecoration(
                color: kCard,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(
                        CupertinoIcons.star_lefthalf_fill,
                        color: kRed,
                        size: 19,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Nivel 3 - Explorador",
                        style: TextStyle(
                          color: kRed,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "¡Sigue aprendiendo sobre la cultura de Cusco!",
                    style: TextStyle(color: kTextMain, fontSize: 14.2),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Progreso al siguiente nivel",
                        style: TextStyle(
                          color: kTextSoft,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.5,
                        ),
                      ),
                      Text(
                        "65%",
                        style: TextStyle(
                          color: kRed,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    child: LinearProgressIndicator(
                      value: 0.65,
                      backgroundColor: kRed.withOpacity(0.13),
                      color: kRed,
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            // ESTADÍSTICAS (compactas)
            Row(
              children: [
                Expanded(
                  child: _InfoCard(
                    icon: CupertinoIcons.globe,
                    iconColor: kRed,
                    mainValue: "124",
                    title: "Traducciones",
                  ),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: _InfoCard(
                    icon: CupertinoIcons.map,
                    iconColor: kRed,
                    mainValue: "8",
                    title: "Lugares",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 11),
            Row(
              children: [
                Expanded(
                  child: _InfoCard(
                    icon: CupertinoIcons.cloud_download,
                    iconColor: kRed,
                    mainValue: "45",
                    title: "Offline",
                  ),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: _InfoCard(
                    icon: CupertinoIcons.book_solid,
                    iconColor: kRed,
                    mainValue: "5",
                    title: "Culturales",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            // LOGROS
            const Text(
              "Logros recientes",
              style: TextStyle(
                color: kRed,
                fontWeight: FontWeight.bold,
                fontSize: 15.5,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _AchievementIcon(
                  icon: CupertinoIcons.star_fill,
                  color: kRed,
                  label: "Nivel 3",
                ),
                const SizedBox(width: 14),
                _AchievementIcon(
                  icon: CupertinoIcons.book_fill,
                  color: kRed.withOpacity(0.82),
                  label: "Cultura+",
                ),
                const SizedBox(width: 14),
                _AchievementIcon(
                  icon: CupertinoIcons.location_solid,
                  color: kGreen,
                  label: "Explorador",
                ),
                const SizedBox(width: 14),
                _AchievementIcon(
                  icon: CupertinoIcons.bolt_fill,
                  color: kRed.withOpacity(0.82),
                  label: "Offline",
                ),
              ],
            ),
            const SizedBox(height: 24),
            CupertinoButton(
              padding: EdgeInsets.zero,
              minSize: 0,
              onPressed: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: kRed,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 18,
                ),
                child: Row(
                  children: [
                    const Icon(
                      CupertinoIcons.cloud_download,
                      color: Colors.white,
                      size: 22,
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Gestión Offline",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Administra contenido sin conexión",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      CupertinoIcons.gear_alt,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  const _StatusChip({
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(13),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13.5,
              fontFamily: 'SF Pro Display',
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String mainValue;
  const _InfoCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.mainValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                mainValue,
                style: TextStyle(
                  color: iconColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'SF Pro Display',
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  color: kTextSoft,
                  fontSize: 12.5,
                  fontFamily: 'SF Pro Display',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AchievementIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _AchievementIcon({
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
