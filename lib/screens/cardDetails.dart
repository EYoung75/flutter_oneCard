import "package:flutter/material.dart";
import "../providers/user.dart";
import "../widgets/cardTemplate.dart";

class CardDetails extends StatelessWidget {
  final VirtualCard selectedUser;

  CardDetails(this.selectedUser);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedUser.name),
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 100),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, .8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 40,
                    spreadRadius: 10,
                  )
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    30,
                  ),
                  bottomRight: Radius.circular(
                    30,
                  ),
                ),
              ),
              height: 250,
            ),
            Text(selectedUser.name),
            Text(selectedUser.title),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton.icon(
                  color: Colors.redAccent,
                  label: Text("Delete"),
                  onPressed: () {},
                  icon: Icon(Icons.delete),
                ),
                RaisedButton.icon(
                  icon: Icon(Icons.share),
                  onPressed: () {},
                  label: Text("Share"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
