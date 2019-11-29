import "package:flutter/material.dart";
// import 'package:badges/badges.dart';

class Wallet extends StatelessWidget {
  final List<Map<String, String>> cardList = [
    {"title": "Person 1", "imageUrl": ""},
    {"title": "Person 2", "imageUrl": ""},
    {"title": "Person 3", "imageUrl": ""},
    {"title": "Person 4", "imageUrl": ""},
    {"title": "Person 5", "imageUrl": ""},
    {"title": "Person 6", "imageUrl": ""},
    {"title": "Person 7", "imageUrl": ""},
  ];

  @override
  Widget build(BuildContext context) {
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
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 200,
              width: 250,
              child: Column(
                children: <Widget>[
                  ListTile(
                    // leading: Badge(
                    //   elevation: 7,
                    //   padding: EdgeInsets.all(4),
                    //   child: Icon(
                    //     Icons.group,
                    //     size: 40,
                    //   ),
                    //   badgeColor: Theme.of(context).primaryColor,
                    //   badgeContent: Text(
                    //     "28",
                    //     style: TextStyle(fontSize: 20),
                    //   ),
                    // ),
                    title: Text(
                      "Work",
                      style: Theme.of(context).textTheme.body2,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      child: Image.network(
                        "https://images.pexels.com/photos/796602/pexels-photo-796602.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
