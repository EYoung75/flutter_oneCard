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
          primarySwatch: Colors.indigo, accentColor: Colors.deepOrange),
      routes: {
        "/": (ctx) => TabScreen(),
      },
    );
  }
}


