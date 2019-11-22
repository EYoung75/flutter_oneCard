import 'dart:io';

import "dart:async";
import "package:http/http.dart" as http;
import "package:flutter/material.dart";
import "dart:convert";
import "package:path/path.dart" as path;
import "package:path_provider/path_provider.dart" as syspaths;
import "package:firebase_core/firebase_core.dart";
import "package:firebase_storage/firebase_storage.dart";

class User with ChangeNotifier {
  String email;
  String userId;
  String authToken;
  VirtualCard userCard;
  bool triedFetch = false;

  User(this.email, this.userId, this.authToken);

  Future<void> fetchUserProfile() async {
    final url =
        "https://onecard-a0072.firebaseio.com/users/$userId/card.json?auth=$authToken";

    try {
      final res = await http.get(url);
      final resData = await json.decode(res.body);
      print("RESDATA $resData");
      if (resData != null) {
        final userImage =
            FirebaseStorage.instance.ref().child(resData["image"]);
        final fetchedImage = await userImage.getDownloadURL();
        VirtualCard fetchedCard = VirtualCard(
          resData["name"],
          Image.network(fetchedImage),
          resData["title"],
          resData["email"],
        );
        userCard = fetchedCard;
      } else {
        userCard = null;
      }
    } catch (err) {
      userCard = null;
      throw (err);
    }
    triedFetch = true;
    notifyListeners();
  }

  Future<void> createUserProfile(
      String name, String title, dynamic image) async {
    bool imageUploaded = false;
    String fileName = path.basename(image.path);
    StorageReference imageReference =
        FirebaseStorage.instance.ref().child("$userId/$fileName");
    StorageUploadTask uploadTask = imageReference.putFile(image);
    await uploadTask.onComplete.then((_) {
      imageUploaded = true;
    });
    if (imageUploaded == true) {
      final storedImage = await imageReference.getDownloadURL();
      final VirtualCard newCard =
          VirtualCard(name, Image.network(storedImage), title, email);

      final url =
          "https://onecard-a0072.firebaseio.com/users/$userId/card.json?auth=$authToken";
      final res = await http.put(
        url,
        body: json.encode({
          "name": newCard.name,
          "title": newCard.title,
          "userEmail": email,
          "image": "$userId/$fileName"
        }),
      );
      userCard = newCard;
      print("USER CARD: $userCard");
      print(res.body);
    }
    notifyListeners();
  }
}

class VirtualCard {
  String name;
  dynamic image;
  String title;
  String email;

  VirtualCard([this.name, this.image, this.title, this.email]);
}
