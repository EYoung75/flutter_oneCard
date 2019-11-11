import "package:flutter/material.dart";
import "../providers/placesProvider.dart";
import "package:provider/provider.dart";

class NetWorkList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final placeList = Provider.of<Places>(context).places;
    return placeList.length <= 0
        ? Container()
        : Container(
            height: 250,
            color: Colors.white,
            child: ListView.builder(
              itemCount: placeList.length,
              itemBuilder: (ctx, i) => ListTile(
                leading: Text(placeList[i].name),
              ),
            ),
          );
  }
}
