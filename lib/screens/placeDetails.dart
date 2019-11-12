import "package:flutter/material.dart";
import 'package:one_card_revisited/widgets/mainMap.dart';
import "../providers/placesProvider.dart";

class PlaceDetails extends StatelessWidget {
  Place selectedPlace;
  PlaceDetails(this.selectedPlace);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text(selectedPlace.name),
      ),
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
            Container(
              height: 350,
              child: MainMap(selectedPlace),
            ),
            Text(selectedPlace.name),
            Text(selectedPlace.address),
            SizedBox(
              height: 20,
            ),
            RaisedButton.icon(
              icon: Icon(Icons.group),
              label: Text("Check In"),
              onPressed: () {
                // Navigator.of(context).popAndPushNamed("/checked_in");
              },
            ),
            // Spacer(),
            // Text("Currently here:"),
            // Container(
            //   color: Color.fromRGBO(255, 255, 255, .8),
            //   width: double.infinity,
            //   height: 250,
            //   child: ListView.builder(
            //     itemCount: 15,
            //     itemBuilder: (ctx, i) => ListTile(
            //       title: Text("Person"),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
