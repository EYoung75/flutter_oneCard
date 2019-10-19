import "package:flutter/material.dart";
import 'package:flip_card/flip_card.dart';

class MainCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlipCard(
      direction: FlipDirection.HORIZONTAL,
      front: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white70,
        ),
        height: 375,
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.network(
                "https://previews.123rf.com/images/pandavector/pandavector1709/pandavector170907388/86380886-person-single-icon-in-outline-style-person-vector-symbol-stock-illustration-web-.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
      back: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white70,
        ),
        height: 375,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Back'),
          ],
        ),
      ),
    );
    ;
  }
}
