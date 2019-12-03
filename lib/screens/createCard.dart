import "package:flutter/material.dart";

import "dart:io";
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import "package:path_provider/path_provider.dart" as syspaths;
import "package:provider/provider.dart";
import "../providers/user.dart";
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
    File cropped = await ImageCropper.cropImage(sourcePath: imageFile.path);
    // final appDir = await syspaths.getApplicationDocumentsDirectory();
    // final fileName = path.basename(imageFile.path);
    // // final savedImage = await imageFile.copy("${appDir.path}/${fileName}");
    // final filePath = await path.absolute(appDir.toString(), fileName);
    // print("FILE PATH: $filePath");
    setState(() {
      _pickedImage = cropped;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(sourcePath: _pickedImage.path);
    setState(() {
      _pickedImage = cropped;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   Scaffold.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(
  //         "Start by creating your first virtual business card above",
  //         style: TextStyle(fontSize: 18),
  //         textAlign: TextAlign.center,
  //       ),
  //       duration: Duration(seconds: 5),
  //       action: SnackBarAction(
  //         label: "Got it!",
  //         textColor: Colors.green,
  //         onPressed: () {
  //           Scaffold.of(context).removeCurrentSnackBar();
  //         },
  //       ),
  //     ),
  //   );
  // }

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
      child: Form(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(
                "Welcome to OneCard!",
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: 25,
              ),
              Divider(),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                decoration: InputDecoration(labelText: "Full Name:"),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
                decoration: InputDecoration(labelText: "Job Title"),
              ),
              // _pickedImage != null
              //     ? Container(
              //         height: 250,
              //         width: 200,
              //         alignment: Alignment.center,
              //         margin: EdgeInsets.all(25),
              //         color: Color.fromRGBO(255, 255, 255, .7),
              //         child: Image.file(
              //           _pickedImage,
              //           fit: BoxFit.cover,
              //         ))
              //     : Container(),
              FlatButton(
                child: Text("Select image"),
                onPressed: _selectImage,
              ),
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
                  alignment: Alignment.bottomLeft,
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
                                  fit: BoxFit.cover)
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
                        color: Color.fromRGBO(255, 255, 255, .7),
                      ),
                      width: double.infinity,
                      // margin: EdgeInsets.all(25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            name,
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                          Text(
                            title,
                            style: Theme.of(context).textTheme.subtitle,
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
              RaisedButton(
                child: Text("Create"),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await user.createUserProfile(name, title, _pickedImage);
                },
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
