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
      drawer: Drawer(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withOpacity(.8),
                Theme.of(context).primaryColor.withOpacity(.3),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    "OneCard",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text(
                      "Settings",
                      style: TextStyle(fontSize: 18, fontFamily: "Dosis"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    leading: Icon(Icons.question_answer),
                    title: Text(
                      "Messenger",
                      style: TextStyle(fontSize: 18, fontFamily: "Dosis"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    leading: Icon(Icons.live_help),
                    title: Text(
                      "Help",
                      style: TextStyle(fontSize: 20, fontFamily: "Dosis"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 20,
        title: Text(_pages[_selectedPageIndex]["title"]),
      ),
      body: _pages[_selectedPageIndex]["page"],
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        backgroundColor: Theme.of(context).primaryColor,
        selectedIconTheme: IconThemeData(size: 30),
        unselectedIconTheme: IconThemeData(size: 20),
        unselectedItemColor: Colors.white70,
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
