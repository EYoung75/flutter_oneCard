import "package:flutter/material.dart";

class Wallet extends StatelessWidget {
  final List<Map<String, String>> cardList = [
    {"title": "Person 1", "imageUrl": ""},
    {"title": "Person 2", "imageUrl": ""},
    {"title": "Person 3", "imageUrl": ""},
    {"title": "Person 4", "imageUrl": ""},
    {"title": "Person 5", "imageUrl": ""},
    {"title": "Person 6", "imageUrl": ""},
    {"title": "Person 7", "imageUrl": ""},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
       
    );
  }
}
