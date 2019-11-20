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
        final decodedImage = "Users/evanyoung/Library/Developer/CoreSimulator/Devices/2D4CCE3F-9D2C-4829-AB04-5B749490E485/data/Containers/Data/Application/3DE04F57-0E21-4E40-AE98-880A3A6BA3B8/Documents/image_picker_62CC9469-6E5D-49F5-8101-F81B95706D49-38952-00002189EF090B45.jpg";
        VirtualCard fetchedCard = VirtualCard(
          resData["name"],
          File(decodedImage),
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
    final url =
        "https://onecard-a0072.firebaseio.com/users/$userId/card.json?auth=$authToken";
    final res = await http.put(
      url,
      body: json.encode({
        "name": newCard.name,
        "title": newCard.title,
        "userEmail": email,
        "image": newCard.image
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
