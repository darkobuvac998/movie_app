import 'package:flutter/material.dart';

import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';
import 'home_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _currentIndex = 0;
  List<Widget> _screens = [];
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _screens = [
        HomeScreen(
          onProfileBadgeTap: () => _onIconTap(3),
        ),
        const SearchScreen(),
        HomeScreen(
          onProfileBadgeTap: () => _onIconTap(3),
        ),
        const ProfileScreen(),
      ];
      _isInit = false;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _onIconTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 10,
        unselectedFontSize: 10,
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          opacity: 1,
          size: 25,
        ),
        selectedLabelStyle: const TextStyle(
          color: Colors.white,
        ),
        unselectedIconTheme: const IconThemeData(
          color: Colors.grey,
          opacity: 1,
          size: 20,
        ),
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        elevation: 10,
        currentIndex: _currentIndex,
        onTap: _onIconTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home_outlined,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(
              Icons.search_rounded,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Favorite',
            icon: Icon(
              Icons.favorite_border,
            ),
          ),
          BottomNavigationBarItem(
            label: 'More',
            icon: Icon(
              Icons.menu_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
