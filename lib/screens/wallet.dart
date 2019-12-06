import "package:flutter/material.dart";
import 'package:one_card_revisited/providers/walletProvider.dart';
import "package:provider/provider.dart";
import "../widgets/emptyWallet.dart";
import "../widgets/walletTile.dart";

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  void initState() {
    Provider.of<WalletProvider>(context, listen: false).fetchCollections();
    super.initState();
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
      child: wallet.loading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : wallet.wallet != null
              ? EmptyWallet()
              : Column(
                  children: <Widget>[
                    Container(
                      height: 40,
                      margin: EdgeInsets.only(
                          top: 25, bottom: 25, right: 40, left: 20),
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
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      height: 500,
                      child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (ctx, i) => InkWell(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Card(
                              elevation: 7,
                              color: Colors.blueGrey,
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 30,
                                  child: Image.network(""),
                                ),
                                title: Text(
                                  "Evan Young",
                                  style: Theme.of(context).textTheme.body1,
                                ),
                                subtitle: Text("Software Engineer"),
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
