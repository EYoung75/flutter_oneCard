import "package:flutter/material.dart";
import 'package:one_card_revisited/providers/walletProvider.dart';
import "package:provider/provider.dart";
import "../widgets/emptyWallet.dart";
import "../widgets/walletTile.dart";
import "../screens/cardDetails.dart";
import "../widgets/background.dart";

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    Provider.of<WalletProvider>(context, listen: false).fetchWallet().then((_) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<WalletProvider>(context);
    return Background(
      _loading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
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
                  height: 10,
                ),
                wallet.wallet == null
                    ? Text(
                        "Start scanning cards to add to your wallet!",
                        textAlign: TextAlign.center,
                      )
                    : Expanded(
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
                              margin: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 2),
                              child: Card(
                                elevation: 5,
                                color: Color.fromRGBO(255, 255, 255, .8),
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(wallet.wallet[i].image,
                                        fit: BoxFit.cover),
                                  ),
                                  title: Text(wallet.wallet[i].name,
                                      style: TextStyle(fontSize: 25)),
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
