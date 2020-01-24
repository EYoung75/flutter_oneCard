import "package:flutter/material.dart";
import "../providers/user.dart";
import "../widgets/background.dart";
import "../widgets/cardTemplate.dart";
import "../providers/walletProvider.dart";
import "package:provider/provider.dart";

class CardDetails extends StatelessWidget {
  final VirtualCard selectedUser;

  CardDetails(this.selectedUser);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(selectedUser.name, style: Theme.of(context).textTheme.title),
      ),
      body: Background(
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CardTemplate(selectedUser),
            RaisedButton.icon(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await Provider.of<WalletProvider>(context)
                    .deleteUser(selectedUser.userId)
                    .then((_) {
                  Navigator.of(context).pop();
                });
              },
              color: Colors.grey,
              label: Text("Delete"),
            ),
          ],
        ),
      ),
    );
  }
}
