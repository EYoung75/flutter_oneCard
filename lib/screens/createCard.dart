import "package:flutter/material.dart";
import "dart:io";
import 'package:image_picker/image_picker.dart';
import "package:provider/provider.dart";
import "../providers/user.dart";
import "../widgets/background.dart";
import 'package:image_cropper/image_cropper.dart';

class CreateCardScreen extends StatefulWidget {
  @override
  _CreateCardScreenState createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  File _pickedImage;
  String name = "";
  String title = "";
  bool isLoading = false;

  Future<void> _selectImage() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    File cropped = await ImageCropper.cropImage(sourcePath: imageFile.path, iosUiSettings: IOSUiSettings(hidesNavigationBar: false, ));
    setState(() {
      _pickedImage = cropped;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    return Background(
      user.loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Welcome to OneCard!",
                      style: TextStyle(fontSize: 26),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Create a virtual card below to get started",
                      style: Theme.of(context).textTheme.body2,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Divider(),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
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
                                child: _pickedImage != null
                                    ? Image.file(
                                        _pickedImage,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        "https://cdn3.iconfinder.com/data/icons/business-avatar-1/512/3_avatar-512.png",
                                        fit: BoxFit.cover,
                                      )
                                ),
                          ),
                          Container(
                            height: 85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                              color: Color.fromRGBO(255, 255, 255, .7),
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
                                      setState(() {
                                        name = value;
                                      });
                                    },
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.subtitle,
                                    autocorrect: true,
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Full Name:",
                                      hintStyle:
                                          Theme.of(context).textTheme.body2,
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
                                      setState(() {
                                        title = value;
                                      });
                                    },
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.subtitle,
                                    autocorrect: true,
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Job Title:",
                                      hintStyle:
                                          Theme.of(context).textTheme.body2,
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    FlatButton(
                      child: Text(_pickedImage == null
                          ? "Select image"
                          : "Select different image"),
                      onPressed: _selectImage,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        elevation: 5,
                        child: Text(
                          "Create",
                          style: TextStyle(fontSize: 24),
                        ),
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await user.createUserProfile(
                              name, title, _pickedImage);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
