import "package:flutter/material.dart";
import 'package:one_card_revisited/providers/walletProvider.dart';
import "package:provider/provider.dart";
import "../screens/cardDetails.dart";
import "../widgets/background.dart";

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  dynamic currentWallet;
  bool _loading = true;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<WalletProvider>(context, listen: false).fetchWallet().then((_) {
      setState(() {
        _loading = false;
        currentWallet =
            Provider.of<WalletProvider>(context, listen: false).wallet;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
                      onChanged: (value) {
                        setState(() {
                          currentWallet = currentWallet
                              .where((i) => i.name.contains(value))
                              .toList();
                        });
                      },
                      controller: searchController,
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
                      "Collection:    ${wallet.wallet.length == 0 ? ' ' : wallet.wallet.length.toString()}",
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
                          // decoration: BoxDecoration(
                          //   boxShadow: [
                          //     BoxShadow(
                          //       color: Colors.white12,
                          //       blurRadius: 5,
                          //       spreadRadius: 5,
                          //       offset: Offset(0, 0),
                          //     )
                          //   ],
                          // ),
                          height: 550,
                          padding: EdgeInsets.symmetric(vertical: 50),
                          child: ListView.builder(
                            padding: EdgeInsets.only(left: 75),
                            scrollDirection: Axis.horizontal,
                            itemCount: currentWallet.length,
                            itemBuilder: (ctx, i) => InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    fullscreenDialog: false,
                                    builder: (ctx) => CardDetails(
                                      currentWallet[i],
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
                                        currentWallet[i].name,
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      subtitle: Text(
                                        "      ${currentWallet[i].title}",
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
                                        child: currentWallet[i].image,
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
