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
          padding: EdgeInsets.only(top: 25, left: 25, right: 25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
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
                            style: Theme.of(context).textTheme.title,
                          ),
                          Text(
                            selectedUser.title,
                            style: TextStyle(fontSize: 28),
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
                    "evanjosephyoung.com",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    AntDesign.facebook_square,
                    color: Colors.white,
                    size: 30,
                  ),
                  title: Text(
                    "evan-young3064",
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
                    "/evan-young4",
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
                    "EYoung75",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  margin: EdgeInsets.only(top: 30),
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
                        "lorem impsum this is filler text. Oh god this is just text that im typing without thinking. I hope no one reads this, that would be awkward, but hey questo e italiano. parla l'italiano? Nessuno io capiscanno. Vorrei un persone che posso parlare en tutto ma, non e possible.",
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
