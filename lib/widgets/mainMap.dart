import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import "package:provider/provider.dart";
import "../providers/placesProvider.dart";

class MainMap extends StatefulWidget {
  @override
  State<MainMap> createState() => MainMapState();
}

class MainMapState extends State<MainMap> {
  String _searchValue = "";
  Completer<GoogleMapController> _mapController = Completer();
  TextEditingController _searchController = TextEditingController();
  final geolocator = Geolocator();
  Position currentPosition;

  Future<void> setUserLocation() async {
    await geolocator.getCurrentPosition().then((Position position) {
      setState(() {
        print(position);
        currentPosition = position;
      });
    }).catchError(
      (e) => print(e),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    final place = Provider.of<Places>(context);

    return currentPosition != null
        ? Center(
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          blurRadius: 40,
                          spreadRadius: 10)
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
                          compassEnabled: true,
                          markers: place.nearbyPlaces,
                          // markers: {
                          //   Marker(
                          //     markerId: MarkerId(""),
                          //     position: LatLng(currentPosition.latitude,
                          //         currentPosition.longitude),
                          //     infoWindow: InfoWindow(title: "Your position"),
                          //   ),
                          // },
                          rotateGesturesEnabled: true,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(currentPosition.latitude,
                                currentPosition.longitude),
                            zoom: 16,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            _mapController.complete(controller);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
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
                    controller: _searchController,
                    autocorrect: true,
                    decoration: InputDecoration(
                      hintText: "Search:",
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    elevation: 20,
                    child: Text(
                      "Find",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    onPressed: () {
                      Provider.of<Places>(context, listen: false)
                          .fetchNearby(_searchController.text, currentPosition);
                    },
                  ),
                ),
              ],
            ),
          )
        : Container(
            margin: EdgeInsets.only(top: 150),
            child: CircularProgressIndicator(),
          );
  }
}
