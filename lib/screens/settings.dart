import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import "package:provider/provider.dart";
import "../providers/user.dart";
import "../widgets/background.dart";
import 'package:image_cropper/image_cropper.dart';
import "dart:io";
import 'package:flutter_icons/flutter_icons.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String _name;
  String _title;
  dynamic _pickedImage;
  bool _updateImage = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userInfo = Provider.of<User>(context).userCard;
    _name = userInfo.name;
    _title = userInfo.title;
    _pickedImage = userInfo.image;
    _updateImage = false;
  }

  Future<void> _selectImage() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    File cropped = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        iosUiSettings: IOSUiSettings(
          hidesNavigationBar: false,
        ),
        aspectRatio: CropAspectRatio(ratioX: 12, ratioY: 16));
    // final appDir = await syspaths.getApplicationDocumentsDirectory();
    // final fileName = path.basename(imageFile.path);
    // // final savedImage = await imageFile.copy("${appDir.path}/${fileName}");
    // final filePath = await path.absolute(appDir.toString(), fileName);
    // print("FILE PATH: $filePath");
    setState(() {
      _pickedImage = cropped;
      _updateImage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: Background(
        user.loading == true
            ? Center(child: CircularProgressIndicator())
            // : SingleChildScrollView(
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: <Widget>[
            //         SizedBox(
            //           height: 25,
            //         ),
            //         Form(
            //           child: Container(
            //             decoration: BoxDecoration(
            //               boxShadow: [
            //                 BoxShadow(
            //                   color: Colors.black38,
            //                   blurRadius: 30,
            //                   spreadRadius: 10,
            //                   offset: Offset(5, 5),
            //                 )
            //               ],
            //               borderRadius: BorderRadius.circular(10),
            //               color: Colors.white70,
            //             ),
            //             height: 450,
            //             width: 350,
            //             child: Stack(
            //               alignment: Alignment.bottomCenter,
            //               children: <Widget>[
            //                 Container(
            //                   height: 450,
            //                   width: double.infinity,
            //                   child: ClipRRect(
            //                       borderRadius: BorderRadius.all(
            //                         Radius.circular(10),
            //                       ),
            // child: _pickedImage == null
            //     ? Image.network(
            //         "https://cdn3.iconfinder.com/data/icons/business-avatar-1/512/3_avatar-512.png",
            //         fit: BoxFit.cover,
            //       )
            //     : _updateImage == false
            //         ? _pickedImage
            //         : Image.file(
            //             _pickedImage,
            //             fit: BoxFit.cover,
            //           )
            // : Image.asset(
            //     "assets/images/blankprofile.png",
            //     fit: BoxFit.cover,
            //   ),
            //                       ),
            //                 ),
            //                 Container(
            //                   height: 85,
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.only(
            //                       bottomRight: Radius.circular(12),
            //                       bottomLeft: Radius.circular(12),
            //                     ),
            //                     color: Color.fromRGBO(255, 255, 255, .9),
            //                   ),
            //                   width: double.infinity,
            //                   // margin: EdgeInsets.all(25),
            //                   child: Column(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     children: <Widget>[
            //                       Container(
            //                         height: 35,
            // child: TextFormField(
            //   onChanged: (value) {
            //     setState(() {
            //       _name = value;
            //     });
            //   },
            //   textAlign: TextAlign.center,
            //   style:
            //       Theme.of(context).textTheme.subtitle,
            //   autocorrect: true,
            //   keyboardType: TextInputType.text,
            //   textCapitalization:
            //       TextCapitalization.words,
            //   decoration: InputDecoration(
            //     border: InputBorder.none,
            //     hintText: _name,
            //     hintStyle:
            //         Theme.of(context).textTheme.body2,
            //     labelStyle: TextStyle(
            //       color: Colors.black,
            //     ),
            //   ),
            //                         ),
            //                       ),
            //                       Container(
            //                         height: 35,
            // child: TextFormField(
            //   onChanged: (value) {
            //     setState(() {
            //       _title = value;
            //     });
            //   },
            //   textAlign: TextAlign.center,
            //   style:
            //       Theme.of(context).textTheme.subtitle,
            //   autocorrect: true,
            //   keyboardType: TextInputType.text,
            //   textCapitalization:
            //       TextCapitalization.words,
            //   decoration: InputDecoration(
            //     border: InputBorder.none,
            //     hintText: _title,
            //     hintStyle:
            //         Theme.of(context).textTheme.body2,
            //     labelStyle:
            //         TextStyle(color: Colors.black),
            //   ),
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            // FlatButton.icon(
            //   icon: Icon(
            //     Icons.wallpaper,
            //     color: Colors.white,
            //   ),
            //   label: Text(
            //     "Change picture",
            //     style: Theme.of(context).textTheme.body1,
            //   ),
            //   onPressed: _selectImage,
            // ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: <Widget>[
            //             RaisedButton(
            //               elevation: 6,
            //               child: Text("Save"),
            //               onPressed: () async {
            //                 await user.editProfile(
            //                     _name, _title, _pickedImage, _updateImage);
            //                 Scaffold.of(context).showSnackBar(
            //                   SnackBar(
            //                     backgroundColor: Colors.green,
            //                     content: Text(
            //                       "Your card has been updated!",
            //                       style: Theme.of(context).textTheme.body1,
            //                     ),
            //                     elevation: 5,
            //                     duration: Duration(seconds: 2),
            //                   ),
            //                 );
            //               },
            //             ),
            //             RaisedButton(
            //               elevation: 6,
            //               color: Theme.of(context).accentColor,
            //               child: Text("Delete"),
            //               onPressed: () {
            //                 user.deleteUser();
            //               },
            //             )
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
            : Container(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: SingleChildScrollView(
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 25,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    height: 200,
                                    child: _pickedImage == null
                                        ? Image.network(
                                            "https://cdn3.iconfinder.com/data/icons/business-avatar-1/512/3_avatar-512.png",
                                            fit: BoxFit.cover,
                                          )
                                        : _updateImage == false
                                            ? _pickedImage
                                            : Image.file(
                                                _pickedImage,
                                                fit: BoxFit.cover,
                                              ),
                                  ),
                                ),
                                FlatButton.icon(
                                  icon: Icon(
                                    Icons.wallpaper,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    "Change",
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                  onPressed: _selectImage,
                                ),
                              ],
                            ),
                            Container(
                              width: 200,
                              height: 150,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    onChanged: (value) {
                                      setState(() {
                                        _name = value;
                                      });
                                    },
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.body1,
                                    autocorrect: true,
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: _name,
                                      hintStyle:
                                          Theme.of(context).textTheme.body1,
                                    ),
                                  ),
                                  TextFormField(
                                    onChanged: (value) {
                                      setState(() {
                                        _title = value;
                                      });
                                    },
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.body1,
                                    autocorrect: true,
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: _title,
                                      hintStyle:
                                          Theme.of(context).textTheme.body1,
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        // ListTile(
                        //   leading: Icon(
                        //     MaterialCommunityIcons.web,
                        //     color: Colors.white,
                        //     size: 30,
                        //   ),
                        //   title: Text(
                        //     "evanjosephyoung.com",
                        //     style: TextStyle(fontSize: 22),
                        //   ),
                        // ),
                        // ListTile(
                        //   leading: Icon(
                        //     AntDesign.facebook_square,
                        //     color: Colors.white,
                        //     size: 30,
                        //   ),
                        //   title: Text(
                        //     "evan-young3064",
                        //     style: TextStyle(fontSize: 22),
                        //   ),
                        // ),
                        // ListTile(
                        //   leading: Icon(
                        //     AntDesign.linkedin_square,
                        //     color: Colors.white,
                        //     size: 30,
                        //   ),
                        //   title: Text(
                        //     "/evan-young4",
                        //     style: TextStyle(fontSize: 22),
                        //   ),
                        // ),
                        // ListTile(
                        //   leading: Icon(
                        //     AntDesign.github,
                        //     color: Colors.white,
                        //     size: 30,
                        //   ),
                        //   title: Text(
                        //     "EYoung75",
                        //     style: TextStyle(fontSize: 22),
                        //   ),
                        // ),
                        FlatButton.icon(
                          label: Text("Add platform"),
                          onPressed: () {},
                          icon: Icon(Icons.add),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
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
                              // Text(
                              //   "lorem impsum this is filler text. Oh god this is just text that im typing without thinking. I hope no one reads this, that would be awkward, but hey questo e italiano. parla l'italiano? Nessuno io capiscanno. Vorrei un persone che posso parlare en tutto ma, non e possible.",
                              //   style: TextStyle(
                              //     color: Colors.black,
                              //   ),
                              //   textAlign: TextAlign.center,
                              // ),
                              FlatButton.icon(icon: Icon(Icons.edit), label: Text("Add bio"), onPressed: () {},)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
