import "package:flutter/material.dart";
import "../providers/placesProvider.dart";
import "package:provider/provider.dart";
import "../screens/placeDetails.dart";

class NetWorkList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final placeList = Provider.of<Places>(context).places;
    return placeList.length <= 0
        ? Container(
            height: 350,
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            margin: EdgeInsets.all(50),
            padding: EdgeInsets.all(10),
            child: Text(
              "Search for a place above to check in and see who's around",
              textAlign: TextAlign.center,
            ),
          )
        : Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, .8),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, blurRadius: 40, spreadRadius: 10)
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  20,
                ),
                topRight: Radius.circular(
                  20,
                ),
              ),
            ),
            height: 450,
            child: ListView.builder(
              itemCount: placeList.length,
              itemBuilder: (ctx, i) => InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (ctx) => PlaceDetails(placeList[i]),
                    ),
                  );
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      child: ListTile(
                        leading: Image.network(
                          placeList[i].icon,
                          fit: BoxFit.contain,
                          height: 35,
                        ),
                        // leading: CircleAvatar(
                        //   backgroundColor: Theme.of(context).accentColor,
                        //   backgroundImage: NetworkImage(placeList[i].icon),
                        // ),
                        title: Text(placeList[i].name),
                        subtitle: Text(placeList[i].address),
                        trailing: Icon(Icons.arrow_right),
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
