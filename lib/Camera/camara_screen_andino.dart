import 'package:flutter/cupertino.dart';
import '../widgets/andino_bottom_nav_bar.dart';

class CamaraScreen extends StatefulWidget {
  const CamaraScreen({super.key});
  @override
  State<CamaraScreen> createState() => _CamaraScreenState();
}

class _CamaraScreenState extends State<CamaraScreen> {
  bool isOnline = true;
  bool isLoading = false;
  String scanResult = '';
  String recognizedObject = '';
  double confidence = 0.89;
  int selectedHistory = -1;

  final List<Map<String, dynamic>> scanHistory = [
    {
      "title": "Escaneo de texto",
      "location": "Museo Pedro",
      "date": "9:21",
      "icon": CupertinoIcons.doc_text,
      "color": CupertinoColors.systemPurple,
    },
    {
      "title": "Tumi",
      "location": "Museo de Casa",
      "date": "9:23",
      "icon": CupertinoIcons.shield,
      "color": Color(0xFFD72631),
    },
    {
      "title": "Lugares",
      "location": "Sacsayhuamán",
      "date": "9:25",
      "icon": CupertinoIcons.location_solid,
      "color": CupertinoColors.systemGreen,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Escanear'),
        trailing: Icon(CupertinoIcons.photo, color: Color(0xFFD72631)),
        backgroundColor: CupertinoColors.white,
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(18),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _ActionButton(
                        icon: CupertinoIcons.camera_viewfinder,
                        label: "Escanear",
                        color: const Color(0xFFD72631),
                        onTap: () {},
                      ),
                      _ActionButton(
                        icon: CupertinoIcons.photo,
                        label: "Galería",
                        color: CupertinoColors.systemPurple,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isOnline
                              ? CupertinoColors.systemGreen.withAlpha(38)
                              : const Color(0xFFD72631).withAlpha(26),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isOnline
                                  ? CupertinoIcons.wifi
                                  : CupertinoIcons.wifi_slash,
                              color: isOnline
                                  ? CupertinoColors.systemGreen
                                  : const Color(0xFFD72631),
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              isOnline ? "Modo online" : "Modo offline",
                              style: TextStyle(
                                color: isOnline
                                    ? CupertinoColors.systemGreen
                                    : const Color(0xFFD72631),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'SF Pro Display',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      if (!isOnline)
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            CupertinoIcons.settings_solid,
                            color: Color(0xFFD72631),
                            size: 20,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  // Card principal para escanear
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: CupertinoColors.systemGrey.withAlpha(30),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          CupertinoIcons.camera,
                          color: Color(0xFFD72631),
                          size: 36,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          isOnline
                              ? "Listo para escanear"
                              : "Escaneo disponible solo en modo offline",
                          style: TextStyle(
                            color: isOnline
                                ? const Color(0xFFD72631)
                                : CupertinoColors.systemGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'SF Pro Display',
                          ),
                        ),
                        const SizedBox(height: 12),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 450),
                          child: isLoading
                              ? const CupertinoActivityIndicator(
                                  radius: 15,
                                  color: Color(0xFFD72631),
                                )
                              : CupertinoButton.filled(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 12,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true;
                                      recognizedObject = '';
                                      scanResult = '';
                                    });
                                    await Future.delayed(
                                      const Duration(milliseconds: 1200),
                                    );
                                    setState(() {
                                      isLoading = false;
                                      recognizedObject = 'Objeto andino';
                                      scanResult =
                                          'Texto extraído: “Qhapaq Ñan”\nConfianza: ${(confidence * 100).toStringAsFixed(1)}%';
                                    });
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(
                                        CupertinoIcons.scope,
                                        color: CupertinoColors.white,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        "Escanear",
                                        style: TextStyle(
                                          fontFamily: 'SF Pro Display',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                        if (recognizedObject.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Container(
                                      width: 120,
                                      height: 160,
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFFD72631,
                                        ).withAlpha(23),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(
                                        CupertinoIcons.photo,
                                        color: Color(0xFFD72631),
                                        size: 60,
                                      ),
                                    ),
                                    Positioned(
                                      right: 8,
                                      top: 8,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: CupertinoColors.systemGreen
                                              .withAlpha(230),
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: Text(
                                          "${(confidence * 100).toStringAsFixed(1)}%",
                                          style: const TextStyle(
                                            color: CupertinoColors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  recognizedObject,
                                  style: const TextStyle(
                                    color: Color(0xFFD72631),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    fontFamily: 'SF Pro Display',
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  scanResult,
                                  style: const TextStyle(
                                    color: CupertinoColors.label,
                                    fontSize: 13,
                                    fontFamily: 'SF Pro Display',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Historial de escaneos",
                    style: TextStyle(
                      color: CupertinoColors.label,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'SF Pro Display',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: List.generate(scanHistory.length, (i) {
                      final h = scanHistory[i];
                      final bool isSelected = selectedHistory == i;
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFD72631).withAlpha(28)
                              : CupertinoColors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: CupertinoColors.systemGrey.withAlpha(18),
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: CupertinoButton(
                          padding: const EdgeInsets.all(0),
                          borderRadius: BorderRadius.circular(16),
                          onPressed: () => setState(() => selectedHistory = i),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 9,
                                ),
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: h["color"].withAlpha(50),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  h["icon"],
                                  color: h["color"],
                                  size: 22,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 13,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        h["title"],
                                        style: TextStyle(
                                          color: h["color"],
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'SF Pro Display',
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        "${h["location"]}  •  ${h["date"]}",
                                        style: const TextStyle(
                                          color: CupertinoColors.systemGrey,
                                          fontFamily: 'SF Pro Display',
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 12.0),
                                child: Icon(
                                  CupertinoIcons.chevron_forward,
                                  color: Color(0xFFD72631),
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            AndinoBottomNavBar(
              currentIndex: 2,
              onTab: (i) {
                if (i == 2) return;
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

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(16),
      onPressed: onTap,
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 13,
              fontFamily: 'SF Pro Display',
            ),
          ),
        ],
      ),
    );
  }
}
