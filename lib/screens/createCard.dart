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
  bool isLoading = false;

  Future<void> _selectImage() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    // final appDir = await syspaths.getApplicationDocumentsDirectory();
    // final fileName = path.basename(imageFile.path);
    // // final savedImage = await imageFile.copy("${appDir.path}/${fileName}");
    // final filePath = await path.absolute(appDir.toString(), fileName);
    // print("FILE PATH: $filePath");
    setState(() {
      _pickedImage = imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
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
      child: !isLoading
          ? Form(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Welcome to OneCard!",
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Start by creating your first virtual business card",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 25,
                    ),
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
                    _pickedImage != null
                        ? Container(
                            height: 250,
                            width: 200,
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(25),
                            color: Color.fromRGBO(255, 255, 255, .7),
                            child: Image.file(
                              _pickedImage,
                              fit: BoxFit.cover,
                            ))
                        : Container(),
                    FlatButton(
                      child: Text("Select image"),
                      onPressed: _selectImage,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    RaisedButton(
                      child: Text("Create"),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await user.createUserProfile(name, title, _pickedImage);
                      },
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
