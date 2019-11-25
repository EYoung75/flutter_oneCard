import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:http/http.dart" as http;
import "package:google_maps_flutter/google_maps_flutter.dart";
import "dart:convert";
import "../utils/util.dart" as util;
import "package:geolocator/geolocator.dart";

class Places with ChangeNotifier {
  List<Place> _places = [
    // Place(
    //     name: "Place",
    //     address: "124 main street",
    //     location: LatLng(42, 42),
    //     placeId: "vf",
    //     icon: ""),
    // Place(
    //     name: "Place",
    //     address: "124 main street",
    //     location: LatLng(42, 42),
    //     placeId: "vf",
    //     icon: ""),
    // Place(
    //     name: "Place",
    //     address: "124 main street",
    //     location: LatLng(42, 42),
    //     placeId: "vf",
    //     icon: ""),
    // Place(
    //     name: "Place",
    //     address: "124 main street",
    //     location: LatLng(42, 42),
    //     placeId: "vf",
    //     icon: ""),
    // Place(
    //     name: "Place",
    //     address: "124 main street",
    //     location: LatLng(42, 42),
    //     placeId: "vf",
    //     icon: ""),
    // Place(
    //     name: "Place",
    //     address: "124 main street",
    //     location: LatLng(42, 42),
    //     placeId: "vf",
    //     icon: ""),
    // Place(
    //     name: "Place",
    //     address: "124 main street",
    //     location: LatLng(42, 42),
    //     placeId: "vf",
    //     icon: ""),
    // Place(
    //     name: "Place",
    //     address: "124 main street",
    //     location: LatLng(42, 42),
    //     placeId: "vf",
    //     icon: "")
  ];

  List<Place> get places {
    return [..._places];
  }

  Set<Marker> nearbyPlaces = {};

  Set<Marker> get nearbyMarkers {
    return nearbyPlaces;
  }

  Future<void> fetchNearby(Position position, String searchTerm) async {
    // String searchTerm
    Set<Marker> newNearby = {};
    final url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=${util.googleMap}&location=${position.latitude},${position.longitude}&rankby=distance&name=$searchTerm";

    final res = await http.get(url);
    final resData = await json.decode(res.body)["results"];
    print(resData);
    final List<Place> loadedPlaces = [];
    await resData.forEach(
      (place) => loadedPlaces.add(
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
      ),
    );
    _places = loadedPlaces;
    _places.forEach(
      (place) => newNearby.add(
        Marker(
          markerId: MarkerId(place.placeId),
          position: place.location,
          infoWindow: InfoWindow(title: place.name),
        ),
      ),
    );
    nearbyPlaces = newNearby;

    print(_places);
    notifyListeners();
  }
}

// class PlaceLocation {
//   final double latitude;
//   final double longitude;
//   final String address;

//   PlaceLocation(this.latitude, this.longitude, this.address);
// }

class Place {
  final String address;
  final String placeId;
  final LatLng location;
  final String name;
  final String icon;

  Place({this.address, this.placeId, this.location, this.name, this.icon});
}
