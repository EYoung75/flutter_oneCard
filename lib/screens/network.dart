import "package:flutter/material.dart";

import "../widgets/mainMap.dart";
import "../widgets/networkList.dart";

class Network extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          MainMap(),
          RaisedButton(
            child: Text("hmu"),
            onPressed: () {},
          ),
          Container(
            margin: EdgeInsets.only(left: 40),
            alignment: Alignment.centerLeft,
            child: Text(
              "Nearby:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
          NetWorkList()
        ],
      ),
    );
  }
}
