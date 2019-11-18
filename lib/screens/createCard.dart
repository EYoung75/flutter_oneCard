import "package:flutter/material.dart";

class CreateCardScreen extends StatefulWidget {
  @override
  _CreateCardScreenState createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to OneCard"),
      ),
      body: Container(
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField()
            ],
          ),
        ),
      ),
    );
  }
}
