import "package:flutter/material.dart";

class EmptyWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("Start scanning cards to add to your wallet!", textAlign: TextAlign.center,),
    );
  }
}
