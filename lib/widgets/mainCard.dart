import "package:flutter/material.dart";
import 'package:flip_card/flip_card.dart';
import 'package:qr_flutter/qr_flutter.dart';

import "../models/profile.dart";

class MainCard extends StatelessWidget {
  final Profile profile = Profile(
    name: "Evan",
    title: "Dude",
  );

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
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.network(
                "https://previews.123rf.com/images/pandavector/pandavector1709/pandavector170907388/86380886-person-single-icon-in-outline-style-person-vector-symbol-stock-illustration-web-.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Text(profile.name),
            Text(profile.title)
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
            Padding(
              padding: const EdgeInsets.all(25),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: QrImage(
                  data: "1234567890",
                  version: QrVersions.auto,
                  constrainErrorBounds: false,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
