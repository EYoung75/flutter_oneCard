import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import "../providers/placesProvider.dart";

class MainMap extends StatefulWidget {
  Place selectedPlace;

  MainMap(this.selectedPlace);
  @override
  State<MainMap> createState() => MainMapState();
}

class MainMapState extends State<MainMap> {
  Completer<GoogleMapController> _mapController = Completer();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, blurRadius: 40, spreadRadius: 10)
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
              child: GoogleMap(
                markers: {
                  Marker(
                    markerId: MarkerId(""),
                    position: LatLng(widget.selectedPlace.location.latitude,
                        widget.selectedPlace.location.longitude),
                    infoWindow: InfoWindow(title: widget.selectedPlace.name),
                  ),
                },
                compassEnabled: true,
                rotateGesturesEnabled: false,
                scrollGesturesEnabled: false,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.selectedPlace.location.latitude,
                      widget.selectedPlace.location.longitude),
                  zoom: 17,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _mapController.complete(controller);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
