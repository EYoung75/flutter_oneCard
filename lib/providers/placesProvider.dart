import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:http/http.dart" as http;
import "package:google_maps_flutter/google_maps_flutter.dart";
import "dart:convert";
import "../utils/util.dart" as util;
import "package:geolocator/geolocator.dart";

class Places with ChangeNotifier {
  String userId;
  String authToken;

  Places(this.userId, this.authToken);

  String checkedIn;

  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  List<Place> places;

  // List<Place> get places {
  //   return [..._places];
  // }

  Set<Marker> nearbyPlaces = {};

  Set<Marker> get nearbyMarkers {
    return nearbyPlaces;
  }

  Future<void> clearSearch() async {
    places =  null;
    notifyListeners();
  }

  Future<void> checkIn(String placeId) async {
    try {
      final url =
          "https://onecard-a0072.firebaseio.com/users/$userId.json?auth=$authToken";
      final res = await http.patch(
        url,
        body: json.encode(
          {
            "location": placeId,
          },
        ),
      );
      checkedIn = placeId;
      print(json.decode(res.body));
    } catch (err) {
      throw (err);
    }
    notifyListeners();
  }

  Future<void> fetchNearby(String searchValue, Position position) async {
    try {
      final url =
          "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=${util.googleMap}&location=${position.latitude},${position.longitude}&rankby=distance&keyword=$searchValue";
      final res = await http.get(url);
      final resData = await json.decode(res.body);
      final List<Place> loadedPlaces = [];
      print("PLACES RES DATA: $resData");
      if(resData["results"] == []) {
        places = [];
      }
      await resData["results"].forEach((place) {
        loadedPlaces.add(
          Place(
            name: place["name"],
            placeId: place["id"].toString(),
            address: place["vicinity"],
            location: LatLng(
              place["geometry"]["location"]["lat"],
              place["geometry"]["location"]["lng"],
            ),
            icon: place["icon"],
          ),
        );
      });
      places = loadedPlaces;
    } catch (err) {
      throw (err);
    }
    notifyListeners();
  }

  Future<void> fetchPlaceDetails() async {
    final url =
        "https://maps.googleapis.com/maps/api/place/details/json?key=${util.googleMap}&place_id=$checkedIn";
    final res = await http.get(url);
  }

  Future<void> checkout() async {
    try {
      final url =
          "https://onecard-a0072.firebaseio.com/users/$userId/location.json?auth=$authToken";
      final res = await http.patch(
        url,
        body: json.encode(
          {"location": null},
        ),
      );
      checkedIn = null;
    } catch (err) {
      throw (err);
    }
    notifyListeners();
  }
}

class Place {
  final String address;
  final String placeId;
  final LatLng location;
  final String name;
  final String icon;

  Place({this.address, this.placeId, this.location, this.name, this.icon});
}
