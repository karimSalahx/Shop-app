import 'package:flutter/material.dart';

class HomePageBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.blue,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          tooltip: 'Home',
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.category,
          ),
          tooltip: 'Category',
          label: 'Category',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
          ),
          tooltip: 'Favorites',
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
          ),
          tooltip: 'Settings',
          label: 'Settings',
        ),
      ],
    );
  }
}
