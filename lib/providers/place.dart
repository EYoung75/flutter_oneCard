import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  String address;
  String placeId;
  LatLng location;
  String name;
  Map categories;
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
