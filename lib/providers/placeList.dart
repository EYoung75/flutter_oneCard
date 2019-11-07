import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:http/http.dart" as http;
import "dart:convert";
import "../utils/util.dart" as util;

import './place.dart';

class PlaceList with ChangeNotifier {
  List<Map> nearbyList;

  PlaceList(this.nearbyList);

  Future searchNearby(LatLng currentLocation, String searchTerm) async {
    final url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=coffee&key=${util.googleMap}&location=${currentLocation.latitude},${currentLocation.longitude}&rankby=distance";
    final res = await http.get(url);
    final resData = await json.decode(res.body);
    print(resData);
  }
}
