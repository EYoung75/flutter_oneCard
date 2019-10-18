import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OneCard',
      theme: ThemeData(
          primarySwatch: Colors.indigo, accentColor: Colors.deepOrange),
      routes: {
        "/" : (ctx) => Home()
      },
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OneCard"),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
