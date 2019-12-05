import "package:flutter/material.dart";
import "../screens/createWalletScreen.dart";

class EmptyWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "Start scanning cards to add to your wallet!",
            textAlign: TextAlign.center,
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text("Create wallet"),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: false,
                  builder: (ctx) => CreateWallet(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
