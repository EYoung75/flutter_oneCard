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
  Completer<GoogleMapController> _mapController = Completer();
  Position _currentPosition;
  TextEditingController _searchController = TextEditingController();
  final Geolocator geolocator = Geolocator();
  String _searchValue = "";

  @override
  void initState() {
    super.initState();
    setUserLocation();
  }

  void setUserLocation() async {
    await geolocator.getCurrentPosition().then((Position position) {
      setState(() {
        print(position);
        _currentPosition = position;
      });
    }).catchError(
      (e) => print(e),
    );
  }


  @override
  Widget build(BuildContext context) {
    return _currentPosition != null
        ? Center(
            child: Container(
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
                child: Stack(
                  children: <Widget>[
                    GoogleMap(
                      rotateGesturesEnabled: true,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(_currentPosition.latitude,
                            _currentPosition.longitude),
                        zoom: 14,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _mapController.complete(controller);
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black, width: .5),
                      ),
                      margin:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      height: 37,
                      width: double.infinity,
                      child: TextField(  
                        controller: _searchController,                   
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
                  ],
                ),
              ),
            ),
          )
        : Container(
            margin: EdgeInsets.only(top: 150),
            child: CircularProgressIndicator(),
          );
  }
}
