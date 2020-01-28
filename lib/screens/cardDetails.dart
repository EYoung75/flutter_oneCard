import "package:flutter/material.dart";
import "../providers/user.dart";
import "../widgets/background.dart";
import "../widgets/cardTemplate.dart";
import "../providers/walletProvider.dart";
import "package:provider/provider.dart";
import 'package:flutter_icons/flutter_icons.dart';

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
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        height: 200,
                        child: selectedUser.image,
                      ),
                    ),
                    Container(
                      height: 150,
                      child: Column(
                        children: <Widget>[
                          Text(
                            selectedUser.name,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.body1,
                          ),
                          Text(
                            selectedUser.title,
                            style: TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                ListTile(
                  leading: Icon(
                    MaterialCommunityIcons.web,
                    color: Colors.white,
                    size: 30,
                  ),
                  title: Text(
                    "jimbucktoo.com",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.alternate_email,
                    color: Colors.white,
                    size: 30,
                  ),
                  title: Text(
                    "j.liang3@gmail.com",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    AntDesign.linkedin_square,
                    color: Colors.white,
                    size: 30,
                  ),
                  title: Text(
                    "jimmy-liang",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    AntDesign.github,
                    color: Colors.white,
                    size: 30,
                  ),
                  title: Text(
                    "jimbucktoo",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  margin: EdgeInsets.only(top: 30, bottom: 30),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(7),
                    ),
                    color: Color.fromRGBO(255, 255, 255, .8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Bio",
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      Text(
                        "Full Stack Software Developer capable of developing elegant applications in multiple front-end frameworks and both relational and non-relational databases.",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
