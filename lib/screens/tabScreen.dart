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
      {"page": Network(), "title": "Network"},
      {"page": Home(), "title": "OneCard"},
      {"page": Wallet(), "title": "Wallet"},
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
        elevation: 15,
        title: Text(_pages[_selectedPageIndex]["title"]),
      ),
      body: _pages[_selectedPageIndex]["page"],
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomNavigationBar(
        
        elevation: 20,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white54,
        selectedItemColor: Colors.white,
        onTap: _setPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.near_me),
            title: Text("Network"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            title: Text("Wallet"),
          ),
        ],
      ),
    );
  }
}
