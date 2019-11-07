import "package:flutter/material.dart";

import "../widgets/mainMap.dart";
import "../widgets/networkList.dart";

class Network extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: RaisedButton(
            //     color: Theme.of(context).accentColor,
            //     elevation: 20,
            //     child: Text(
            //       "Find",
            //       style: TextStyle(color: Colors.black, fontSize: 20),
            //     ),
            //     onPressed: () {},
            //   ),
            // ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(225, 225, 225, .9),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: .5),
              ),
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              height: 37,
              width: double.infinity,
              child: TextField(
                autocorrect: true,
                decoration: InputDecoration(
                  labelText: "Search:",
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Container(
              height: 30,
              child: RaisedButton(
                child: Text("Find"),
                onPressed: () {},
              ),
            ),
            Spacer(),
            NetWorkList()
          ],
        ),
      ),
    );
  }
}
