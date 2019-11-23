import "package:flutter/material.dart";
import "package:geolocator/geolocator.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "dart:async";
import "package:provider/provider.dart";
import "../providers/placesProvider.dart";
import "../widgets/networkList.dart";

class Network extends StatefulWidget {
  @override
  _NetworkState createState() => _NetworkState();
}

class _NetworkState extends State<Network> {
  String _searchValue;
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
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void handleSearch() {
    setState(() {
      _searchValue = _searchController.value.toString();
    });
  }

  void toggleSearching() {
    setState(() {
      searching = !searching;
      _searchValue = "";
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor.withOpacity(.6),
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
                      markers: {
                        Marker(
                          markerId: MarkerId(""),
                          position: LatLng(currentPosition.latitude,
                              currentPosition.longitude),
                          infoWindow: InfoWindow(title: "YOU ARE HERE"),
                        ),
                      },
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
                                  _searchValue = value;
                                });
                              },
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _searchValue == null || _searchValue == ""
                                    ? "Suggestions"
                                    : "Results for $_searchValue",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   height: 300,
                      //   width: double.infinity,
                      //   child: ListView.builder(
                      //     scrollDirection: Axis.horizontal,
                      //     itemCount: 6,
                      //     itemBuilder: (ctx, i) => Text(i.toString()),
                      //   ),
                      // )
                      Container(
                        height: 350,
                        width: double.infinity,
                        child: ListView.builder(
                          padding: EdgeInsets.only(left: 40),
                          itemCount: 12,
                          itemBuilder: (ctx, i) => Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 25, top: 40),
                                height: 200,
                                width: 200,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    "https://i.pinimg.com/474x/8f/86/16/8f8616d80380a6bfec0c54b00387de3c.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text("Place Name")
                            ],
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
