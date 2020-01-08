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
  File pickedImage;
  String apiKey;
  bool loading = false;

  User(this.email, this.userId, this.authToken, this.apiKey);

  Future<void> fetchUserProfile() async {
    // if(loading == false) {
    //   loading = true;
    //   notifyListeners();
    // }
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
          resData["userId"],
          resData["name"],
          Image.network(fetchedImage, fit: BoxFit.cover),
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
    // loading = false;
    notifyListeners();
  }

  Future<void> deleteUser() async {
    final dbUrl =
        "https://onecard-a0072.firebaseio.com/users/$userId.json?auth=$authToken";
    StorageReference imageReference =
        FirebaseStorage.instance.ref().child("$userId/${userCard.image}");
    await imageReference.delete().then((_) {
      http.delete(dbUrl).then((_) {
        final authUrl =
            "https://identitytoolkit.googleapis.com/v1/accounts:delete?key=$apiKey";

        http.delete(authUrl);
      });
    });

    notifyListeners();
  }

  Future<void> createUserProfile(
      String name, String title, dynamic image) async {
    if (loading == false) {
      loading = true;
      notifyListeners();
    }
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
      final VirtualCard newCard = VirtualCard(
        userId,
        name,
        Image.network(storedImage, fit: BoxFit.cover),
        title,
        email,
      );

      final url =
          "https://onecard-a0072.firebaseio.com/users/$userId/card.json?auth=$authToken";
      final res = await http.put(
        url,
        body: json.encode({
          "userId": userId,
          "name": newCard.name,
          "title": newCard.title,
          "image": "$userId/$fileName"
        }),
      );
      userCard = newCard;
      print("USER CARD: $userCard");
      print(res.body);
    }
    loading = false;
    notifyListeners();
  }

  Future<void> editProfile(
      String name, String title, dynamic image, bool updateImage) async {
    if (loading == false) {
      loading = true;
      notifyListeners();
    }
    if (updateImage == true) {
      bool imageUploaded = false;
      String fileName = path.basename(image.path);
      print("TWO");
      StorageReference imageReference =
          FirebaseStorage.instance.ref().child("$userId/$fileName");
      StorageUploadTask uploadTask = imageReference.putFile(image);
      await uploadTask.onComplete.then((_) {
        imageUploaded = true;
      });
      if (imageUploaded == true) {
        final storedImage = await imageReference.getDownloadURL();
        final VirtualCard newCard = VirtualCard(
          userId,
          name,
          Image.network(storedImage, fit: BoxFit.cover),
          title,
          email,
        );

        final url =
            "https://onecard-a0072.firebaseio.com/users/$userId/card.json?auth=$authToken";
        final res = await http.put(
          url,
          body: json.encode({
            "userId": userId,
            "name": newCard.name,
            "title": newCard.title,
            "image": "$userId/$fileName"
          }),
        );
        userCard = newCard;
        print("USER CARD: $userCard");
        print(res.body);
      }
    } else {
      final VirtualCard newCard = VirtualCard(
        userId,
        name,
        image,
        title,
        email,
      );

      final url =
          "https://onecard-a0072.firebaseio.com/users/$userId/card.json?auth=$authToken";
      final res = await http.patch(
        url,
        body: json.encode({
          "userId": userId,
          "name": newCard.name,
          "title": newCard.title,
        }),
      );
      userCard = newCard;
    }
    loading = false;
    notifyListeners();
  }
}

class VirtualCard {
  String userId;
  String name;
  dynamic image;
  String title;
  String email;

  VirtualCard([
    this.userId,
    this.name,
    this.image,
    this.title,
    this.email,
  ]);
}
