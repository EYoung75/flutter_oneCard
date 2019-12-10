import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../providers/placesProvider.dart";
import "./networkCheckedIn.dart";
import "./networkSearch.dart";
import "../widgets/background.dart";

class Network extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final placeData = Provider.of<Places>(context);
    return Scaffold(
      body: Background(
        placeData.checkedIn == null ? NetworkSearch() : CheckedIn(),
      ),
    );
  }
}
