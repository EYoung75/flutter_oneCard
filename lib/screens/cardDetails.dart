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
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
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
                          style: Theme.of(context).textTheme.title,
                        ),
                        Text(selectedUser.title,
                            style: TextStyle(fontSize: 28)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              ListTile(
                leading: Icon(
                  MaterialCommunityIcons.web,
                  color: Colors.white,
                ),
                title: Text("evanjosephyoung.com"),
              ),
              ListTile(
                leading: Icon(
                  AntDesign.facebook_square,
                  color: Colors.white,
                ),
                title: Text("evan-young3564"),
              ),
              ListTile(
                leading: Icon(
                  AntDesign.linkedin_square,
                  color: Colors.white,
                ),
                title: Text("/evan-young4"),
              ),
              ListTile(
                leading: Icon(
                  AntDesign.github,
                  color: Colors.white,
                ),
                title: Text("EYoung75"),
              ),

              SizedBox(
                height: 250,
              )
              // CardTemplate(selectedUser),
              // RaisedButton.icon(
              //   icon: Icon(Icons.delete),
              //   onPressed: () async {
              //     await Provider.of<WalletProvider>(context)
              //         .deleteUser(selectedUser.userId)
              //         .then((_) {
              //       Navigator.of(context).pop();
              //     });
              //   },
              //   color: Colors.grey,
              //   label: Text("Delete"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
