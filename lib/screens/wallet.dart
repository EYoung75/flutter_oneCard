import "package:flutter/material.dart";
import 'package:one_card_revisited/providers/walletProvider.dart';
import "package:provider/provider.dart";
import "../widgets/emptyWallet.dart";

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
      child: Container(
        height: 350,
        margin: EdgeInsets.all(25),
        child: Column(
          children: <Widget>[
            Text(
              "Collections",
              style: Theme.of(context).textTheme.subtitle,
            ),
            SizedBox(
              height: 45,
            ),
            wallet.wallet.isEmpty
                ? EmptyWallet()
                : ListView.builder(
                    itemCount: wallet.wallet.length,
                    itemBuilder: (ctx, i) => Container(
                      height: 50,
                      width: 50,
                      child: Text("HEYYYYY"),
                    ),
                  )
          ],
        ),
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
