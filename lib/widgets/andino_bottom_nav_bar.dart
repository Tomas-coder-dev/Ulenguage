import 'package:flutter/cupertino.dart';

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
      backgroundColor: CupertinoColors.white,
      activeColor: const Color(0xFFD72631),
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
