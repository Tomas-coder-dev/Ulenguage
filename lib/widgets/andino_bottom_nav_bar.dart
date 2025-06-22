import 'package:flutter/cupertino.dart';

// PALETA
const Color kRed = Color(0xFFEF233C);
const Color kNavBg = Color(0xFFF6F6F9);

class AndinoBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTab;
  const AndinoBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTabBar(
      backgroundColor: kNavBg,
      activeColor: kRed,
      inactiveColor: CupertinoColors.systemGrey,
      iconSize: 27,
      border: null,
      currentIndex: currentIndex,
      onTap: onTab,
      height: 62,
      items: [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.house_fill),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
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
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.map_fill),
          label: 'Explorar',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person_crop_circle),
          label: 'Perfil',
        ),
      ],
    );
  }
}
