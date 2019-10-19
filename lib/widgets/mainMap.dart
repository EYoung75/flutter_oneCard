import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class MainMap extends StatefulWidget {
  @override
  State<MainMap> createState() => MainMapState();
}

class MainMapState extends State<MainMap> {
  Completer<GoogleMapController> _controller = Completer();
  Position _currentPosition;
  final Geolocator geolocator = Geolocator();

  @override
  void initState() {
    super.initState();
    geolocator.getCurrentPosition().then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError(
      (e) => print(e),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black38, blurRadius: 40, spreadRadius: 10)
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
          child: Stack(
            children: <Widget>[
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(37.42796133580664, -122.085749655962),
                  zoom: 14.4746,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black, width: .5),
                ),
                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                height: 35,
                width: double.infinity,
                child: TextField(
                  autocorrect: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    labelText: "Search:",
                    hasFloatingPlaceholder: false,
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              Container(
                child: Text(
                    "${_currentPosition.latitude} + ${_currentPosition.longitude}"),
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}
