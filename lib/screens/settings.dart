import "package:flutter/material.dart";
import "../widgets/mainCard.dart";
import "package:provider/provider.dart";
import "../providers/user.dart";
import "../widgets/background.dart";

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
            Form(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 30,
                      spreadRadius: 10,
                      offset: Offset(5, 5),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white70,
                ),
                height: 450,
                width: 350,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      height: 450,
                      width: double.infinity,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          child: user.userCard.image != null
                              ? user.userCard.image
                              : Image.network(
                                  "https://cdn3.iconfinder.com/data/icons/business-avatar-1/512/3_avatar-512.png",
                                  fit: BoxFit.cover,
                                )
                          // : Image.asset(
                          //     "assets/images/blankprofile.png",
                          //     fit: BoxFit.cover,
                          //   ),
                          ),
                    ),
                    Container(
                      height: 85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                        color: Color.fromRGBO(255, 255, 255, .9),
                      ),
                      width: double.infinity,
                      // margin: EdgeInsets.all(25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 35,
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {});
                              },
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.subtitle,
                              autocorrect: true,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: user.userCard.name,
                                hintStyle: Theme.of(context).textTheme.body2,
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 35,
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {});
                              },
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.subtitle,
                              autocorrect: true,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: user.userCard.title,
                                hintStyle: Theme.of(context).textTheme.body2,
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            FlatButton.icon(
              icon: Icon(Icons.wallpaper, color: Colors.white,),
              label: Text("Change picture", style: Theme.of(context).textTheme.body1,),
              onPressed: () {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text("Save"),
                  onPressed: () {},
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
