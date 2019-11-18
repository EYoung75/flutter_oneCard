import "package:flutter/material.dart";

import "dart:io";
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import "package:path_provider/path_provider.dart" as syspaths;

class CreateCardScreen extends StatefulWidget {
  @override
  _CreateCardScreenState createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  File _pickedImage;

  Future<void> _selectImage() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _pickedImage = imageFile;
    });
    //store file path in variable
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to OneCard"),
      ),
      body: Container(
        padding: EdgeInsets.all(50),
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
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text("Start by creating your first virtual business card"),
                Divider(),
                TextFormField(
                  decoration: InputDecoration(labelText: "Full Name:"),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Job Title"),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(25),
                  color: Colors.white,
                  child: _pickedImage != null
                      ? Image.file(
                          _pickedImage,
                          fit: BoxFit.cover,
                        )
                      : Text("Select a profile image"),
                ),
                FlatButton(
                  child: Text("Select image"),
                  onPressed: _selectImage,
                ),
                SizedBox(
                  height: 25,
                ),
                RaisedButton(
                  child: Text("Create"),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
