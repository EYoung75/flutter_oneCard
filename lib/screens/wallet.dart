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
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Collections:",
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      height: 600,
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (ctx, i) => WalletTile(),
                      ),
                    ),
                  ],
                ),
    );
  }
}

// Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               height: 200,
//               width: 250,
//               child: Column(
//                 children: <Widget>[
//                   ListTile(
//                     title: Text(
//                       "Work",
//                       style: Theme.of(context).textTheme.body2,
//                     ),
//                     trailing: Icon(Icons.arrow_forward_ios),
//                   ),
//                   Divider(
//                     thickness: 2,
//                   ),
//                   Expanded(
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(10),
//                         bottomRight: Radius.circular(10),
//                       ),
//                       child: Image.network(
//                         "https://images.pexels.com/photos/796602/pexels-photo-796602.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
//                         fit: BoxFit.fitWidth,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
