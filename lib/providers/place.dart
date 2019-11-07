import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:http/http.dart" as http;

class Place with ChangeNotifier{
  String address;
  String placeId;
  LatLng location;
  String name;
  List categories;
  int distance;

  Place({
    this.address,
    this.placeId,
    this.location,
    this.name,
    this.categories,
    this.distance,
  });

}
