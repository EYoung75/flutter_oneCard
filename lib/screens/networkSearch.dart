import "package:flutter/material.dart";
import "package:geolocator/geolocator.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "dart:async";
import "package:provider/provider.dart";
import "../providers/placesProvider.dart";
import "../widgets/networkList.dart";
import "./placeDetails.dart";

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
  bool searching = true;

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

  void toggleSearching() {
    setState(() {
      searching = !searching;
      searchValue = "";
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final placeData = Provider.of<Places>(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor.withOpacity(.3),
              Theme.of(context).primaryColor.withOpacity(.7),
              Theme.of(context).primaryColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: currentPosition == null
            ? CircularProgressIndicator()
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
                        target: LatLng(currentPosition.latitude,
                            currentPosition.longitude),
                        zoom: 17,
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Container(
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
                                onPressed: () async {
                                  await placeData.fetchNearby(
                                      currentPosition, searchValue);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                placeData.places.length <= 0 ||
                                        placeData.places == null ||
                                        searchValue == null
                                    ? "Suggestions:"
                                    : "Results for $searchValue",
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.body1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      placeData.places.length <= 0
                          ? Container()
                          : Container(
                              height: 350,
                              width: double.infinity,
                              child: ListView.builder(
                                padding: EdgeInsets.only(left: 100),
                                itemCount: placeData.places.length,
                                itemBuilder: (ctx, i) => InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (ctx) => PlaceDetails(
                                          placeData.places[i],
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
                                            borderRadius:
                                                BorderRadius.circular(12),
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
                                            borderRadius:
                                                BorderRadius.circular(12),
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
                                            placeData.places[i].name,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                            overflow: TextOverflow.fade,
                                            softWrap: true,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        // Container(
                                        //   height: 30,
                                        //   decoration: BoxDecoration(
                                        //     color: Colors.white,
                                        //     borderRadius: BorderRadius.only(
                                        //       topLeft: Radius.circular(12),
                                        //       topRight: Radius.circular(12),
                                        //     ),
                                        //   ),
                                        //   alignment: Alignment.topCenter,
                                        // child: Text(
                                        //   "Place Name",
                                        //   style: TextStyle(
                                        //     color: Colors.black,
                                        //     fontSize: 20,
                                        //   ),
                                        // ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}

// Column(
//           children: <Widget>[
//             Container(
//               padding: EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.black38, blurRadius: 20, spreadRadius: 7)
//                 ],
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(
//                     20,
//                   ),
//                   bottomRight: Radius.circular(
//                     20,
//                   ),
//                 ),
//                 color: Color.fromRGBO(255, 255, 255, .8),
//               ),
//               margin: EdgeInsets.symmetric(horizontal: 10),
//               child: Text(
//                 "Check into a place to start connecting",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 25,
//             ),
//             searching
//                 ? Column(
//                     children: <Widget>[
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Color.fromRGBO(225, 225, 225, .9),
//                           borderRadius: BorderRadius.circular(5),
//                           border: Border.all(color: Colors.black, width: .5),
//                         ),
//                         margin:
//                             EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//                         height: 40,
//                         width: double.infinity,
//                         child: TextField(
//                           controller: _searchController,
//                           autocorrect: true,
//                           decoration: InputDecoration(
//                             hintText: "Enter a place:",
//                             icon: Icon(
//                               Icons.location_on,
//                               color: Colors.red,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: RaisedButton(
//                           color: Theme.of(context).accentColor,
//                           elevation: 5,
//                           child: Text(
//                             "Search",
//                             style: TextStyle(color: Colors.black, fontSize: 16),
//                           ),
//                           onPressed: () async {
//                             await Provider.of<Places>(context, listen: false)
//                                 .fetchNearby(
//                                     _searchController.text, currentPosition);
//                             toggleSearching();
//                           },
//                         ),
//                       ),
//                     ],
//                   )
//                 : Container(
//                     child: RaisedButton(
//                       child: Text("Search Again"),
//                       onPressed: toggleSearching,
//                     ),
//                   ),
//             Spacer(),
//             NetWorkList()
//           ],
//         ),
