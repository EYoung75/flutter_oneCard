import "package:flutter/material.dart";
import 'package:one_card_revisited/providers/walletProvider.dart';
import "package:provider/provider.dart";
import "../widgets/emptyWallet.dart";
import "../widgets/walletTile.dart";
import "../screens/cardDetails.dart";

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  void initState() {
    super.initState();
    Provider.of<WalletProvider>(context, listen: false).fetchWallet();
  }

  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<WalletProvider>(context);
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
          Container(
            height: 40,
            margin: EdgeInsets.only(
              top: 25,
              bottom: 25,
              right: 40,
              left: 20,
            ),
            child: TextFormField(
              decoration: InputDecoration(
                icon: Icon(
                  Icons.search,
                ),
                hasFloatingPlaceholder: false,
                labelText: "Search",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            "Collection:",
            style: Theme.of(context).textTheme.subtitle,
          ),
          SizedBox(
            height: 25,
          ),
          wallet.wallet == null
              ? Text(
                  "Start scanning cards to add to your wallet!",
                  textAlign: TextAlign.center,
                )
              : Container(
                  height: 350,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: wallet.wallet.length,
                    itemBuilder: (ctx, i) => InkWell(
                      onTap: () {
                         Navigator.of(context).push(
                                      MaterialPageRoute(
                                        fullscreenDialog: false,
                                        builder: (ctx) => CardDetails(
                                         wallet.wallet[i],
                                        ),
                                      ),
                                    );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Card(
                          color: Color.fromRGBO(255, 255, 255, .8),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 40,
                              child: Image.network(
                                  wallet.wallet[i].image,
                                  fit: BoxFit.cover),
                            ),
                            title: Text(wallet.wallet[i].name),
                            subtitle: Text(wallet.wallet[i].title),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
