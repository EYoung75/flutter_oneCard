import "package:flutter/material.dart";

import "dart:io";
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import "package:path_provider/path_provider.dart" as syspaths;
import "package:provider/provider.dart";
import "../providers/user.dart";

class CreateCardScreen extends StatefulWidget {
  @override
  _CreateCardScreenState createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  File _pickedImage;
  String name;
  String title;

  Future<void> _selectImage() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy("${appDir.path}/${fileName}");
     setState(() {
      _pickedImage = savedImage;
    });
    print(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
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
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: InputDecoration(labelText: "Full Name:"),
                ),
                TextFormField(
                  onChanged: (value) {
                    title = value;
                  },
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
                  onPressed: () {
                    user.createUserProfile(name, title, _pickedImage);
                    
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
