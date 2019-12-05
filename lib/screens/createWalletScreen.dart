import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../providers/walletProvider.dart";

class CreateWallet extends StatefulWidget {
  @override
  _CreateWalletState createState() => _CreateWalletState();
}

class _CreateWalletState extends State<CreateWallet> {
  String walletName;
  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<WalletProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Wallet"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
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
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    walletName = value;
                  });
                },
                decoration: InputDecoration(labelText: "Name"),
              ),
              FlatButton(onPressed: () {
                wallet.createWallet(walletName);
              }, child: Text("Add"), color: Colors.blueGrey,)
            ],
          ),
        ),
      ),
    );
  }
}
