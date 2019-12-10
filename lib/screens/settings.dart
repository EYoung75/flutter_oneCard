import "package:flutter/material.dart";
import "../widgets/mainCard.dart";
import "../widgets/editCard.dart";
import "package:provider/provider.dart";
import "../providers/user.dart";
import "../widgets/background.dart";

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: Background(
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            MainCard(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text("Edit"),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (ctx) => EditCard(),
                      ),
                    );
                  },
                ),
                RaisedButton(
                  child: Text("Delete"),
                  onPressed: () {
                    user.deleteUser();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
