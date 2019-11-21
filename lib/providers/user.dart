import 'dart:io';

import "dart:async";
import "package:http/http.dart" as http;
import "package:flutter/material.dart";
import "dart:convert";
import "package:path/path.dart" as path;
import "package:path_provider/path_provider.dart" as syspaths;

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
        // File: '/var/mobile/Containers/Data/Application/E1FA5D92-2596-4771-8F96-8A3D4BC9BA1E/Documents/image_picker_5986AD07-DB1D-402E-B38D-DB664018D671-12417-0000062E3EBD54E4.jpg'
        // '/var/mobile/Containers/Data/Application/E1FA5D92-2596-4771-8F96-8A3D4BC9BA1E/Documents/image_picker_5986AD07-DB1D-402E-B38D-DB664018D671-12417-0000062E3EBD54E4.jpg'
        // final decodedImage = File("/Users/evanyoung/Library/Developer/CoreSimulator/Devices/2D4CCE3F-9D2C-4829-AB04-5B749490E485/data/Containers/Data/Application/F6902B1A-7595-4EDD-B1CA-AFA45DF6FA80/Documents/image_picker_C61C6938-5848-4EA6-A928-0FF4CE9096BD-3470-00000149EAFCF45E.jpg");
        // final imagePathRaw = await resData["image"].replaceRange(0, 7, "");
        // final newpath = imagePathRaw.toString().replaceRange(imagePathRaw.length - 1, imagePathRaw.length, "");
        final newpath = resData["image"].toString().substring(7, resData["image"].length - 1);
        VirtualCard fetchedCard = VirtualCard(
          resData["name"],
          File(newpath),
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

  Future<void> createUserProfile(String name, String title, File image) async {
    final VirtualCard newCard = VirtualCard(name, image, title, email);
    // File: '/var/mobile/Containers/Data/Application/E1FA5D92-2596-4771-8F96-8A3D4BC9BA1E/Documents/image_picker_5986AD07-DB1D-402E-B38D-DB664018D671-12417-0000062E3EBD54E4.jpg'
    // '/var/mobile/Containers/Data/Application/E1FA5D92-2596-4771-8F96-8A3D4BC9BA1E/Documents/image_picker_5986AD07-DB1D-402E-B38D-DB664018D671-12417-0000062E3EBD54E4.jpg'

    final url =
        "https://onecard-a0072.firebaseio.com/users/$userId/card.json?auth=$authToken";
    final res = await http.put(
      url,
      body: json.encode({
        "name": newCard.name,
        "title": newCard.title,
        "userEmail": email,
        "image": image.toString()
      }),
    );
    userCard = newCard;
    print("USER CARD: $userCard");
    print(res.body);
    notifyListeners();
  }
}

class VirtualCard {
  String name;
  File image;
  String title;
  String email;

  VirtualCard([this.name, this.image, this.title, this.email]);
}
