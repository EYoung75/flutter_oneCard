import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../providers/placesProvider.dart";

class CheckedIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        children: <Widget>[
          FloatingActionButton.extended(
            icon: Icon(Icons.exit_to_app),
            label: Text("Check Out"),
            onPressed: () {
              Provider.of<Places>(context).checkout();
            },
          ),
        ],
      ),
    );
  }
}
