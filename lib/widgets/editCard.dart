import 'dart:io';

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../providers/user.dart";

class EditCard extends StatefulWidget {
  @override
  _EditCardState createState() => _EditCardState();
}

class _EditCardState extends State<EditCard> {
  File _pickedImage;

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<User>(context, listen: false).userCard;
    return Scaffold(
      body: Container(
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
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(left: 45, right: 45, top: 75),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: userInfo.name,
                decoration: InputDecoration(labelText: "Full Name:"),
              ),
              TextFormField(
                initialValue: userInfo.title,
                decoration: InputDecoration(labelText: "Job Title:"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
