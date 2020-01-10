import "package:flutter/material.dart";
import "package:one_card_revisited/providers/user.dart";
import "../screens/home.dart";
import "../screens/network.dart";
import "../screens/wallet.dart";
import "package:provider/provider.dart";
import "../providers/auth.dart";
import "../providers/walletProvider.dart";
import "./ScanScreen.dart";
import "./searchScreen.dart";

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
    Provider.of<User>(context, listen: false).fetchUserProfile();
    _pages = [
      // {"page": Network(), "title": "Network"},
      {"page": SearchScreen(), "title": "Search"},
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
    final wallet = Provider.of<WalletProvider>(context);
    return Scaffold(
      drawer: Drawer(
        elevation: 7,
        semanticLabel: "App Drawer",
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
            padding: const EdgeInsets.all(35.0),
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
                Divider(
                  color: Colors.white,
                  thickness: 1.5,
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed("/settings");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, top: 15),
                    child: ListTile(
                      leading: Icon(Icons.settings),
                      title: Text(
                        "Settings",
                        style: Theme.of(context).textTheme.body2,
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 30),
                //   child: ListTile(
                //     leading: Icon(Icons.question_answer),
                //     title: Text(
                //       "Messenger",
                //       style: Theme.of(context).textTheme.body2,
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: ListTile(
                    leading: Icon(Icons.live_help),
                    title: Text(
                      "Help",
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ),  
                ), 
                InkWell(
                  onTap: () {
                    Provider.of<Auth>(context).logout();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text(
                        "Logout",
                        style: Theme.of(context).textTheme.body2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.camera),
            onPressed: () {
              wallet.scanQR();
            },
          )
        ],
        elevation: 10,
        title: Text(
          _pages[_selectedPageIndex]["title"],
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: wallet.scannedCard == null
          ? _pages[_selectedPageIndex]["page"]
          : ScanScreen(),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        backgroundColor: Theme.of(context).primaryColor,
        selectedIconTheme: IconThemeData(size: 30),
        unselectedIconTheme: IconThemeData(size: 22),
        unselectedItemColor: Colors.white70,
        selectedItemColor: Colors.white,
        onTap: _setPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text(
              "Search",
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.portrait),
            title: Text(
              "Home",
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            title: Text(
              "Wallet",
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ],
      ),
    );
  }
}
