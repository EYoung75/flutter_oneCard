import "package:flutter/material.dart";
import "../providers/user.dart";
import "../widgets/cardTemplate.dart";
import "../widgets/background.dart";

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
                    10,
                  ),
                  bottomRight: Radius.circular(
                    10,
                  ),
                ),
              ),
              height: 350,
              width: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: selectedUser.image,
              ),
            ),
            Text(selectedUser.name),
            Text(selectedUser.title),
            Spacer(),
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
            ),
            SizedBox(height: 100)
          ],
        ),
      ),
    );
  }
}
