import "package:flutter/material.dart";
import 'package:one_card_revisited/widgets/mainMap.dart';
import "../providers/placesProvider.dart";
import "package:provider/provider.dart";
import "../providers/placesProvider.dart";
import "dart:io";

class PlaceDetails extends StatelessWidget {
  Place selectedPlace;
  PlaceDetails(this.selectedPlace);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.group),
        label: Text("Check In"),
        onPressed: () async {
          await Provider.of<Places>(context).checkIn(selectedPlace.placeId);
          Navigator.of(context).pop();
        },
      ),
      appBar: AppBar(
        elevation: 10,
        title: Text(selectedPlace.name, style: Theme.of(context).textTheme.title,),
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
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 40,
                    spreadRadius: 10,
                  )
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    30,
                  ),
                  bottomRight: Radius.circular(
                    30,
                  ),
                ),
              ),
              height: 300,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    25,
                  ),
                  bottomRight: Radius.circular(
                    25,
                  ),
                ),
                child: Image.network(
                  "https://www.hospitalitydesign.com/wp-content/uploads/CrossroadsLobby.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Container(
            //   height: 350,
            //   child: MainMap(selectedPlace),
            // ),
            Text(
              selectedPlace.name,
              style: TextStyle(fontSize: 28),
            ),
            Text(
              selectedPlace.address,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
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
