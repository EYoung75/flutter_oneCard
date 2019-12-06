import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../providers/walletProvider.dart";

class WalletList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<WalletProvider>(context);
    return Container(
      height: 350,
      child: ListView.builder(
        itemCount: wallet.wallet.length,
        itemBuilder: (ctx, i) {
          ListTile(
            leading: CircleAvatar(child: wallet.wallet[i]),
          );
        },
      ),
    );
  }
}
