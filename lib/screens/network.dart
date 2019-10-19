import "package:flutter/material.dart";

import "../widgets/mainMap.dart";

class Network extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        MainMap(),
      ],
    );
  }
}
