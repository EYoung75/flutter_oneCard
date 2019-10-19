import "package:flutter/material.dart";

import "../widgets/mainCard.dart";

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor.withOpacity(.6),
            Theme.of(context).primaryColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MainCard(),
          SizedBox(height: 25,),
          FloatingActionButton.extended(
            onPressed: () {},
            elevation: 15,
            icon: Icon(Icons.camera_alt),
            label: Text("Scan"),
          )
        ],
      ),
    );
  }
}
