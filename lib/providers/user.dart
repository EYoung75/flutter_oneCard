import 'dart:io';

import "dart:async";
import "package:http/http.dart" as http;
import "package:flutter/material.dart";
import "dart:convert";

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
        VirtualCard fetchedCard = VirtualCard(resData["name"], resData["image"],
            resData["title"], resData["email"]);
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
      String name, String title, String image) async {
    final VirtualCard newCard = VirtualCard(name, image, title, email);
    final url =
        "https://onecard-a0072.firebaseio.com/users/$userId/card.json?auth=$authToken";
    final res = await http.put(
      url,
      body: json.encode({
        "name": newCard.name,
        "title": newCard.title,
        "email": email,
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
  String image;
  String title;
  String email;

  VirtualCard([this.name, this.image, this.title, this.email]);
}
