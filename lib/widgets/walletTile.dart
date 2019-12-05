import "package:flutter/material.dart";
import "../screens/openWalletScreen.dart";

class WalletTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(     
            builder: (ctx) => WalletOpen(),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        child: Card(
          color: Colors.blue,
          elevation: 7,
          child: Container(
            alignment: Alignment.center,
            height: 200,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.work),
                  ),
                  title: Text("Work", style: Theme.of(context).textTheme.body1),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                        color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
