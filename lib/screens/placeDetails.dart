import "package:flutter/material.dart";
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
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 300,
                color: Colors.white,
              ),
              SizedBox(height: 25),
              Text(selectedPlace.name)
            ],
          ),
        ),
      ),
    );
  }
}
