import 'dart:io';

import "package:flutter/material.dart";
import 'package:flip_card/flip_card.dart';
import 'package:qr_flutter/qr_flutter.dart';
import "package:provider/provider.dart";
import "../providers/user.dart";

class MainCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userCard = Provider.of<User>(context).userCard;
    return FlipCard(
      direction: FlipDirection.HORIZONTAL,
      front: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 30,
              spreadRadius: 10,
              offset: Offset(5, 5),
            )
          ],
          borderRadius: BorderRadius.circular(10),
          color: Colors.white70,
        ),
        height: 450,
        width: 350,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            Container(
              height: 450,
              width: double.infinity,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: userCard.image
                  // child: Image.network(
                  //   userCard.image,
                  //   fit: BoxFit.cover,
                  // )

                  // child: Image.network(
                  //   "https://lh3.googleusercontent.com/YxnIsRXL_n-wP8DOB3_-3JiolhkGCzAGFQIJIRtzbWwZQNrdn-IsPoDveYYX23oWoKz3b5BPsXRBB22SN1RLKW5mxHUThBl0Ydtm5RHl9L-PZJilAIf4YaZzYcXaJt6mgrEeWvLahA=w2400",
                  //   fit: BoxFit.cover,
                  // ),
                  ),
            ),
            Container(
              height: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromRGBO(255, 255, 255, .8),
              ),
              width: double.infinity,
              margin: EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    userCard.name,
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  Text(
                    userCard.title,
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ],
              ),
            )
          ],
        ),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: <Widget>[
        // ClipRRect(
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(10),
        //   topRight: Radius.circular(10),
        // ),
        //       child: Image.network(
        //         "https://lh3.googleusercontent.com/YxnIsRXL_n-wP8DOB3_-3JiolhkGCzAGFQIJIRtzbWwZQNrdn-IsPoDveYYX23oWoKz3b5BPsXRBB22SN1RLKW5mxHUThBl0Ydtm5RHl9L-PZJilAIf4YaZzYcXaJt6mgrEeWvLahA=w2400",
        //         fit: BoxFit.cover,
        //       ),
        //     ),
        //     SizedBox(
        //       height: 25,
        //     ),
        //     Text(
        //       profile.name,
        //       style: TextStyle(fontSize: 30),
        //       textAlign: TextAlign.left,
        //     ),
        //     Text(
        //       profile.title,
        //       style: TextStyle(fontSize: 25),
        //     ),
        //   ],
        // ),
      ),
      back: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 30,
              spreadRadius: 10,
              offset: Offset(5, 5),
            )
          ],
          borderRadius: BorderRadius.circular(10),
          color: Colors.white70,
        ),
        height: 450,
        width: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: QrImage(
                    data: userCard.userId,
                    version: QrVersions.auto,
                    constrainErrorBounds: false,
                    backgroundColor: Colors.white,
                  ),
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
