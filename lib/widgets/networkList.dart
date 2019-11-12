import "package:flutter/material.dart";
import "../providers/placesProvider.dart";
import "package:provider/provider.dart";
import "../screens/placeDetails.dart";

class NetWorkList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final placeList = Provider.of<Places>(context).places;
    return placeList.length <= 0
        ? Container()
        : Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, .8),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, blurRadius: 40, spreadRadius: 10)
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  30,
                ),
                topRight: Radius.circular(
                  30,
                ),
              ),
            ),
            height: 250,
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
                        leading: Image.network(placeList[i].icon, fit: BoxFit.contain, height: 35,),
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
