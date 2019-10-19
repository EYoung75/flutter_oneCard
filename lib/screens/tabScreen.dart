import "package:flutter/material.dart";

import "../screens/home.dart";
import "../screens/network.dart";
import "../screens/wallet.dart";

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _pages;

  int _selectedPageIndex = 1;

  @override
  void initState() {
    super.initState();
    _pages = [
      {"page": Wallet(), "title": "Wallet"},
      {"page": Home(), "title": "OneCard"},
      {"page": Network(), "title": "Network"}
    ];
  }

  void _setPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]["title"]),
      ),
      body: _pages[_selectedPageIndex]["page"],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _setPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            title: Text("Wallet"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text("Network"),
          ),
        ],
      ),
    );
  }
}
