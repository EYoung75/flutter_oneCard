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
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
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
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(225, 225, 225, .9),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: .5),
              ),
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              height: 40,
              width: double.infinity,
              child: TextField(
                controller: _searchController,
                autocorrect: true,
                decoration: InputDecoration(
                  hintText: "Find:",
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
            Spacer(),
            NetWorkList()
          ],
        ),
      ),
    );
  }
}
