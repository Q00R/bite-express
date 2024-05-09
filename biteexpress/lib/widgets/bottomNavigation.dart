import 'package:flutter/material.dart';
import '../pages/home.dart';
import '../pages/search.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onIndexChanged;

  BottomNavigation({required this.selectedIndex, required this.onIndexChanged});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      selectedItemColor: const Color.fromARGB(255, 255, 115, 1),
      unselectedItemColor: const Color(0xff757575),
      type: BottomNavigationBarType.fixed,
      onTap: onIndexChanged,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          activeIcon: Icon(Icons.search_outlined),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          activeIcon: Icon(Icons.shopping_cart_outlined),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          activeIcon: Icon(Icons.menu),
          label: 'More',
        ),
      ],
    );
  }
}
