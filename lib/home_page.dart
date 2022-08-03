import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_icecream_ui/ice_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2; // index starts from 0
  Widget getWidgets(int index) {
    switch (index) {
      case 0:
        return const Center(child: Text("Settings"));
      case 1:
        return const Center(child: Text("Notifications"));
      case 2:
        return const IceCreamHomePage();
      case 3:
        return const Center(child: Text("Favorite"));
      case 4:
        return const Center(child: Text("Profile"));
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // curved navigation bar
      bottomNavigationBar: CurvedNavigationBar(
        color: const Color.fromARGB(255, 253, 186, 203),
        height: 62,
        buttonBackgroundColor: Colors.pink,
        backgroundColor: Colors.transparent,
        index: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          Icon(Icons.settings, color: Colors.white),
          Icon(Icons.notifications, color: Colors.white),
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.favorite, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
        ],
      ),
      body: getWidgets(_selectedIndex),
    );
  }
}
