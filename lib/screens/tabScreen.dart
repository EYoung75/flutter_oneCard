import "dart:async";
import 'dart:convert';
import "package:barcode_scan/barcode_scan.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:one_card_revisited/providers/user.dart';
import "../screens/home.dart";
import "../screens/network.dart";
import "../screens/wallet.dart";
import "package:provider/provider.dart";
import "../providers/auth.dart";

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _pages;

  int _selectedPageIndex = 1;

  String result = "";
  bool showScan = false;

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
        showScan = true;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera access was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "Camera was not used to scan anything";
      });
    } catch (ex) {
      result = "Unknown error code: $ex";
    }
    print(result.toString());
  }

  @override
  void initState() {
    super.initState();
    Provider.of<User>(context, listen: false).fetchUserProfile();
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
                      Padding(
                        padding: const EdgeInsets.only(left: 30, top: 15),
                        child: ListTile(
                          leading: Icon(Icons.settings),
                          title: Text(
                            "Settings",
                            style: TextStyle(fontSize: 18, fontFamily: "Dosis"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: ListTile(
                          leading: Icon(Icons.question_answer),
                          title: Text(
                            "Messenger",
                            style: TextStyle(fontSize: 18, fontFamily: "Dosis"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: ListTile(
                          leading: Icon(Icons.live_help),
                          title: Text(
                            "Help",
                            style: TextStyle(fontSize: 20, fontFamily: "Dosis"),
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
                              style:
                                  TextStyle(fontSize: 18, fontFamily: "Dosis"),
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
            onPressed: _scanQR,
          )
        ],
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
