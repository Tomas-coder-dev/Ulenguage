import 'package:flutter/cupertino.dart';
import '../widgets/andino_bottom_nav_bar.dart';

class TraducirScreen extends StatefulWidget {
  const TraducirScreen({super.key});
  @override
  State<TraducirScreen> createState() => _TraducirScreenState();
}

class _TraducirScreenState extends State<TraducirScreen> {
  final TextEditingController inputController = TextEditingController();
  String? translatedText;
  bool isLoading = false;
  int selectedCategory = 0;

  final List<String> categorias = ['Turismo', 'Emergencia', 'Gastronomía'];

  final List<Map<String, String>> frasesUtiles = [
    {
      "es": "¿Dónde está la plaza?",
      "qe": "Maypin plaza?",
      "en": "Where is the square?",
    },
    {"es": "¿Cuánto cuesta?", "qe": "Hayk'aq chay?", "en": "How much is it?"},
    {"es": "¡Ayuda!", "qe": "Yanapay!", "en": "Help!"},
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Traducir'),
        backgroundColor: CupertinoColors.white,
        trailing: Icon(CupertinoIcons.time, color: Color(0xFFD72631)),
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
                        label: "Subir Imagen",
                        color: CupertinoColors.systemPurple,
                        onTap: () {},
                      ),
                      _ActionButton(
                        icon: CupertinoIcons.mic,
                        label: "Voz",
                        color: CupertinoColors.systemGreen,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: CupertinoColors.systemGrey.withAlpha(20),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        CupertinoTextField(
                          controller: inputController,
                          placeholder: "Escribe el texto a traducir...",
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey6,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'SF Pro Display',
                          ),
                          suffix: inputController.text.isNotEmpty
                              ? CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  onPressed: () {
                                    inputController.clear();
                                    setState(() => translatedText = null);
                                  },
                                  child: const Icon(
                                    CupertinoIcons.clear_circled,
                                    size: 22,
                                    color: CupertinoColors.systemGrey,
                                  ),
                                )
                              : null,
                          onChanged: (_) => setState(() {}),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            CupertinoButton.filled(
                              borderRadius: BorderRadius.circular(12),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 10,
                              ),
                              onPressed: isLoading
                                  ? null
                                  : () async {
                                      setState(() => isLoading = true);
                                      await Future.delayed(
                                        const Duration(milliseconds: 750),
                                      );
                                      setState(() {
                                        translatedText =
                                            "Traducción simulada de: “${inputController.text}”";
                                        isLoading = false;
                                      });
                                    },
                              child: Row(
                                children: const [
                                  Icon(
                                    CupertinoIcons.arrow_right_arrow_left,
                                    size: 18,
                                    color: CupertinoColors.white,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    "Traducir",
                                    style: TextStyle(
                                      fontFamily: 'SF Pro Display',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 14),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              onPressed: () {},
                              child: const Icon(
                                CupertinoIcons.speaker_2_fill,
                                color: Color(0xFFD72631),
                              ),
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              onPressed: () {},
                              child: const Icon(
                                CupertinoIcons.heart,
                                color: Color(0xFFD72631),
                              ),
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              onPressed: () {},
                              child: const Icon(
                                CupertinoIcons.textformat_size,
                                color: Color(0xFFD72631),
                              ),
                            ),
                            if (isLoading)
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: CupertinoActivityIndicator(
                                  color: Color(0xFFD72631),
                                ),
                              ),
                          ],
                        ),
                        if (translatedText != null)
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFE066).withAlpha(40),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.checkmark_seal_fill,
                                  color: CupertinoColors.systemGreen,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    translatedText!,
                                    style: const TextStyle(
                                      color: CupertinoColors.label,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      fontFamily: 'SF Pro Display',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Categorías",
                    style: TextStyle(
                      color: CupertinoColors.label,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'SF Pro Display',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(categorias.length, (i) {
                      return CupertinoButton(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 7,
                        ),
                        color: selectedCategory == i
                            ? const Color(0xFFD72631)
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
                                : CupertinoColors.black,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    "Frases Útiles",
                    style: TextStyle(
                      color: CupertinoColors.label,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'SF Pro Display',
                    ),
                  ),
                  const SizedBox(height: 7),
                  Column(
                    children: frasesUtiles.map((frase) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD72631).withAlpha(23),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                CupertinoIcons.quote_bubble_fill,
                                color: Color(0xFFD72631),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      frase["qe"]!,
                                      style: const TextStyle(
                                        color: Color(0xFFD72631),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'SF Pro Display',
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      "${frase["es"]}  •  ${frase["en"]}",
                                      style: const TextStyle(
                                        color: CupertinoColors.systemGrey,
                                        fontFamily: 'SF Pro Display',
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                onPressed: () {},
                                child: const Icon(
                                  CupertinoIcons.speaker_2,
                                  color: Color(0xFFD72631),
                                ),
                              ),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                onPressed: () {},
                                child: const Icon(
                                  CupertinoIcons.heart,
                                  color: Color(0xFFD72631),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            AndinoBottomNavBar(
              currentIndex: 1,
              onTab: (i) {
                if (i == 1) return;
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
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      color: color.withAlpha(30),
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
