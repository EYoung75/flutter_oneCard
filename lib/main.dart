import 'package:flutter/material.dart';

import "./screens/tabScreen.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'OneCard',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(47, 95, 114, 1),
        accentColor: Color.fromRGBO(255, 233, 214, 1),
        fontFamily: "Roboto",
      ),
      routes: {
        "/": (ctx) => TabScreen(),
      },
    );
  }
}
