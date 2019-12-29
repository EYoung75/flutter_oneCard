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
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  Container(
                    margin: EdgeInsets.only(left: 25),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Collection:",
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Color.fromRGBO(255, 255, 255, .5),
                    indent: 50,
                  ),
                  wallet.wallet == null
                      ? Text(
                          "Start scanning cards to add to your wallet!",
                          textAlign: TextAlign.center,
                        )
                      : Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white12,
                                blurRadius: 20,
                                spreadRadius: 20,
                                offset: Offset(0, 0),
                              )
                            ],
                          ),
                          height: 550,
                          padding: EdgeInsets.symmetric(vertical: 50),
                          child: ListView.builder(
                            padding: EdgeInsets.only(left: 75),
                            scrollDirection: Axis.horizontal,
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
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: 250,
                                child: Column( 
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(
                                        wallet.wallet[i].name,
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      subtitle: Text(
                                        "      ${wallet.wallet[i].title}",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 350,
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                        child: wallet.wallet[i].image,
                                      ),
                                    )
                                  ],
                                ),
                                margin: EdgeInsets.all(10),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}