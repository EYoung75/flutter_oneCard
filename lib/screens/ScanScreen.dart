import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../providers/walletProvider.dart";
import "../widgets/background.dart";

class ScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<WalletProvider>(context);
    final scannedCard = Provider.of<WalletProvider>(context).scannedCard;
    return Background(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 30,
                  spreadRadius: 10,
                  offset: Offset(5, 5),
                )
              ],
              borderRadius: BorderRadius.circular(10),
              color: Colors.white70,
            ),
            height: 400,
            width: 300,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: <Widget>[
                Container(
                  height: 450,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: Image.network(
                      scannedCard.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Color.fromRGBO(255, 255, 255, .8),
                  ),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        scannedCard.name,
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                      Text(
                        scannedCard.title,
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton.icon(
                color: Colors.green[500],
                textColor: Colors.white,
                icon: Icon(Icons.add),
                onPressed: () {
                  wallet.addUser();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                        "Added to your wallet!",
                        style: Theme.of(context).textTheme.body1,
                      ),
                      elevation: 5,
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                label: Text("Add"),
              ),
              RaisedButton.icon(
                color: Colors.grey,
                icon: Icon(Icons.delete),
                onPressed: () {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        "User not added to your wallet",
                        style: Theme.of(context).textTheme.body1,
                      ),
                      elevation: 5,
                      duration: Duration(seconds: 1),
                    ),
                  );
                  wallet.cancel();
                },
                label: Text("Delete"),
              )
            ],
          )
        ],
      ),
    );
  }
}
