import "package:flutter/material.dart";
import "dart:math";

import "../providers/auth.dart";
import "package:provider/provider.dart";

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = "auth";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor.withOpacity(.3),
              Theme.of(context).primaryColor.withOpacity(.7),
              Theme.of(context).primaryColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: <Widget>[
           
          ],
        ),
      ),
    );
  }
}
