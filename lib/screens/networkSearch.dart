import "package:flutter/material.dart";
import "package:geolocator/geolocator.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "dart:async";
import "package:provider/provider.dart";
import "../providers/placesProvider.dart";
import "../widgets/networkList.dart";
import "./placeDetails.dart";
import "../widgets/background.dart";

class NetworkSearch extends StatefulWidget {
  @override
  _NetworkSearchState createState() => _NetworkSearchState();
}

class _NetworkSearchState extends State<NetworkSearch> {
  String searchValue;
  Completer<GoogleMapController> _mapController = Completer();
  TextEditingController _searchController = TextEditingController();
  final geolocator = Geolocator();
  Position currentPosition;
  bool _loading = false;

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
  void initState() {
    super.initState();
    setUserLocation();
    // .then((_) {
    //   Provider.of<Places>(context).fetchNearby(currentPosition);
    // });
  }

  @override
  void dispose() {
    _searchController.dispose();
    Provider.of<Places>(context).clearSearch();
    setState(() {
      searchValue = "";
    });
    super.dispose();
  }

  void handleSearch() {
    setState(() {
      searchValue = _searchController.value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final placeData = Provider.of<Places>(context);
    return Scaffold(
      body: Background(
        currentPosition == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: <Widget>[
                  Container(
                    height: 250,
                    width: double.infinity,
                    child: GoogleMap(
                      markers: placeData.nearbyMarkers,
                      compassEnabled: true,
                      rotateGesturesEnabled: true,
                      scrollGesturesEnabled: true,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          currentPosition.latitude,
                          currentPosition.longitude,
                        ),
                        zoom: 17,
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      placeData.places == null && _loading == false
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 60),
                              child: Column(
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      "Search",
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.white),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _searchController,
                                    onChanged: (value) {
                                      setState(() {
                                        searchValue = value;
                                      });
                                    },
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    alignment: Alignment.centerRight,
                                    child: RaisedButton.icon(
                                      icon: Icon(Icons.search),
                                      label: Text("Find"),
                                      onPressed: () {
                                        setState(() {
                                          _loading = true;
                                        });
                                        placeData
                                            .fetchNearby(
                                                searchValue, currentPosition)
                                            .then((_) {
                                          setState(() {
                                            _loading = false;
                                          });
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  // Below lines to be added when running product demo with intial nearby place details fetch request
                                  // Container(
                                  //   alignment: Alignment.centerLeft,
                                  //   child: Text(
                                  //     "Suggestions:",
                                  //     textAlign: TextAlign.left,
                                  //     style: Theme.of(context).textTheme.body1,
                                  //   ),
                                  // ),
                                ],
                              ),
                            )
                          : _loading == true
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : PlaceList(searchValue)
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}

class PlaceList extends StatelessWidget {
  String searchValue;
  PlaceList(this.searchValue);
  @override
  Widget build(BuildContext context) {
    final placeList = Provider.of<Places>(context);
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: RaisedButton.icon(
            icon: Icon(Icons.refresh),
            label: Text("Search Again"),
            onPressed: () {
              placeList.clearSearch();
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 25, top: 25, bottom: 20),
          decoration: BoxDecoration(),
          alignment: Alignment.bottomLeft,
          child: Text(
            "Results for '$searchValue':",
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        ),
        placeList.places.length == 0
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(255, 69, 69, .8),
                ),
                child: Text(
                  "No places were found matching that search term. Please try a different term.",
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: Theme.of(context).textTheme.body2,
                ),
              )
            : Container(
                height: 500,
                width: double.infinity,
                child: ListView.builder(
                  padding: EdgeInsets.only(left: 100, right: 20),
                  itemCount: placeList.places.length,
                  itemBuilder: (ctx, i) => InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (ctx) => PlaceDetails(
                            placeList.places[i],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 30, top: 20),
                      height: 250,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 175,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                  offset: Offset(5, 10),
                                )
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                "https://i.pinimg.com/474x/f3/86/67/f386670133229dbe5c7c2dc8128837ed.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 150,
                            child: Text(
                              placeList.places[i].name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              overflow: TextOverflow.fade,
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  scrollDirection: Axis.horizontal,
                ),
              ),
      ],
    );
  }
}
