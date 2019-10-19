import "package:flutter/material.dart";

class NetWorkList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white38,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        height: 175,
        child: ListView(
          padding: EdgeInsets.all(15),
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(.7),
                child: Icon(Icons.person_outline),
              ),
              title: Text("Whats upppp"),
            ),
            Divider(
              color: Colors.black,
            ),
           ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(.7),
                child: Icon(Icons.person_outline),
              ),
              title: Text("Whats upppp"),
            ),
            Divider(
              color: Colors.black,
            ),ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(.7),
                child: Icon(Icons.person_outline),
              ),
              title: Text("Whats upppp"),
            ),
            Divider(
              color: Colors.black,
            ),ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(.7),
                child: Icon(Icons.person_outline),
              ),
              title: Text("Whats upppp"),
            ),
            Divider(
              color: Colors.black,
            ),ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(.7),
                child: Icon(Icons.person_outline),
              ),
              title: Text("Whats upppp"),
            ),
            Divider(
              color: Colors.black,
            ),ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(.7),
                child: Icon(Icons.person_outline),
              ),
              title: Text("Whats upppp"),
            ),
            Divider(
              color: Colors.black,
            ),ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(.7),
                child: Icon(Icons.person_outline),
              ),
              title: Text("Whats upppp"),
            ),
            Divider(
              color: Colors.black,
            ),ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(.7),
                child: Icon(Icons.person_outline),
              ),
              title: Text("Whats upppp"),
            ),
            Divider(
              color: Colors.black,
            ),ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(.7),
                child: Icon(Icons.person_outline),
              ),
              title: Text("Whats upppp"),
            ),
            Divider(
              color: Colors.black,
            ),ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(.7),
                child: Icon(Icons.person_outline),
              ),
              title: Text("Whats upppp"),
            ),
            Divider(
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
