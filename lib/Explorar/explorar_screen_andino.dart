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

class ExplorarScreen extends StatefulWidget {
  const ExplorarScreen({super.key});
  @override
  State<ExplorarScreen> createState() => _ExplorarScreenState();
}

class _ExplorarScreenState extends State<ExplorarScreen> {
  int selectedCategory = 0; // 0: Todos, 1: Clásicos, 2: Naturaleza, etc.
  final List<String> categorias = [
    'Todos',
    'Clásicos',
    'Naturaleza',
    'Modernos',
  ];

  final List<Map<String, dynamic>> lugares = [
    {
      "nombre": "Machu Picchu",
      "ubicacion": "Cusco, Perú",
      "img":
          "https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=500&q=80",
      "rating": 4.9,
      "esFavorito": true,
      "categoria": "Clásicos",
      "visitado": true,
    },
    {
      "nombre": "Centro Histórico de Cusco",
      "ubicacion": "Cusco, Perú",
      "img":
          "https://images.unsplash.com/photo-1502082553048-f009c37129b9?auto=format&fit=crop&w=500&q=80",
      "rating": 4.8,
      "esFavorito": false,
      "categoria": "Clásicos",
      "visitado": false,
    },
    {
      "nombre": "Ollantaytambo",
      "ubicacion": "Valle Sagrado, Cusco",
      "img":
          "https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=500&q=80",
      "rating": 4.6,
      "esFavorito": true,
      "categoria": "Naturaleza",
      "visitado": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Explorar'),
        backgroundColor: CupertinoColors.white,
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            // Abrir modal de filtros adicionales
          },
          child: const Icon(CupertinoIcons.slider_horizontal_3, color: kYellow),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(18),
                children: [
                  SizedBox(
                    height: 38,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categorias.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, i) => CupertinoButton(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 7,
                        ),
                        color: selectedCategory == i
                            ? kBrandRed
                            : CupertinoColors.white,
                        borderRadius: BorderRadius.circular(22),
                        onPressed: () {
                          setState(() => selectedCategory = i);
                        },
                        child: Text(
                          categorias[i],
                          style: TextStyle(
                            color: selectedCategory == i
                                ? CupertinoColors.white
                                : kTextPrimary,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Column(
                    children: lugares
                        .where(
                          (lugar) =>
                              selectedCategory == 0 ||
                              categorias[selectedCategory] ==
                                  lugar["categoria"],
                        )
                        .map(
                          (lugar) => _LugarCard(
                            nombre: lugar["nombre"],
                            ubicacion: lugar["ubicacion"],
                            img: lugar["img"],
                            rating: lugar["rating"],
                            esFavorito: lugar["esFavorito"],
                            visitado: lugar["visitado"],
                            onFavoritoTap: () {
                              setState(() {
                                lugar["esFavorito"] = !lugar["esFavorito"];
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Rutas Recomendadas",
                    style: TextStyle(
                      color: kTextPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'SF Pro Display',
                    ),
                  ),
                  const SizedBox(height: 10),
                  _RutaRecomendadaCard(
                    titulo: "Camino Inca Clásico",
                    lugaresIncluidos: [
                      "Machu Picchu",
                      "Wiñay Wayna",
                      "Paso Warmiwañusqa",
                    ],
                    dificultad: "Difícil",
                  ),
                  const SizedBox(height: 7),
                  _RutaRecomendadaCard(
                    titulo: "Ruta del Valle Sagrado",
                    lugaresIncluidos: ["Ollantaytambo", "Pisac", "Chinchero"],
                    dificultad: "Moderado",
                  ),
                ],
              ),
            ),
            _AndinoBottomNavBar(
              currentIndex: 3,
              onTab: (i) {
                // Implementa navegación entre tabs
                final routes = [
                  '/inicio',
                  '/traducir',
                  '/camara',
                  '/explorar',
                  '/perfil',
                ];
                if (i == 3) return;
                Navigator.of(context).pushReplacementNamed(routes[i]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LugarCard extends StatelessWidget {
  final String nombre;
  final String ubicacion;
  final String img;
  final double rating;
  final bool esFavorito;
  final bool visitado;
  final VoidCallback onFavoritoTap;

  const _LugarCard({
    required this.nombre,
    required this.ubicacion,
    required this.img,
    required this.rating,
    required this.esFavorito,
    required this.visitado,
    required this.onFavoritoTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegar a detalle del lugar
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          color: kCard,
          borderRadius: BorderRadius.circular(18),
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
            // Imagen real del lugar
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
              ),
              child: Image.network(
                img,
                width: 90,
                height: 92,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 90,
                  height: 92,
                  color: kBrandRed.withAlpha(33),
                  child: const Icon(
                    CupertinoIcons.photo,
                    color: kBrandRed,
                    size: 32,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 13,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          nombre,
                          style: const TextStyle(
                            color: kTextPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'SF Pro Display',
                          ),
                        ),
                        const SizedBox(width: 6),
                        if (visitado)
                          const Icon(
                            CupertinoIcons.check_mark_circled_solid,
                            color: kSuccess,
                            size: 17,
                          ),
                        if (esFavorito)
                          const Icon(
                            CupertinoIcons.heart_fill,
                            color: kBrandRed,
                            size: 17,
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ubicacion,
                      style: const TextStyle(
                        color: kTextSecondary,
                        fontFamily: 'SF Pro Display',
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          CupertinoIcons.star_fill,
                          color: kYellow,
                          size: 16,
                        ),
                        Text(
                          rating.toString(),
                          style: const TextStyle(
                            color: kTextPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: onFavoritoTap,
                          child: Icon(
                            esFavorito
                                ? CupertinoIcons.heart_fill
                                : CupertinoIcons.heart,
                            color: kBrandRed,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RutaRecomendadaCard extends StatelessWidget {
  final String titulo;
  final List<String> lugaresIncluidos;
  final String dificultad;

  const _RutaRecomendadaCard({
    required this.titulo,
    required this.lugaresIncluidos,
    required this.dificultad,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kBrandRed.withAlpha(18),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              color: kBrandRed,
              fontWeight: FontWeight.bold,
              fontSize: 15,
              fontFamily: 'SF Pro Display',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Incluye: ${lugaresIncluidos.join(', ')}",
            style: const TextStyle(
              color: kTextSecondary,
              fontSize: 12,
              fontFamily: 'SF Pro Display',
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(CupertinoIcons.placemark, color: kBrandRed, size: 16),
              const SizedBox(width: 4),
              Text(
                "Dificultad: $dificultad",
                style: const TextStyle(
                  color: kBrandRed,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
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
