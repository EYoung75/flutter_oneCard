import 'dart:io';

import "dart:async";
import "package:http/http.dart" as http;
import "package:flutter/material.dart";
import "dart:convert";

class User with ChangeNotifier {
  String email;
  String userId;
  String authToken;
  Card userCard;

  User(this.email, this.userId, this.authToken);

  Future<void> fetchUserProfile() async {
    final url =
        "https://onecard-a0072.firebaseio.com/users/$userId/card.json?auth=$authToken";
    final res = await http.get(url);
    final resData = await json.decode(res.body);
  }

  Future<void> createUserProfile(String name, String title, File image) async {
    final Card newCard = Card(name, title, image.toString(), email);
    final url =
        "https://onecard-a0072.firebaseio.com/users/$userId/card.json?auth=$authToken";
    final res = await http.put(
      url,
      body: json.encode(
        {
          "name": newCard.name,
          "title": newCard.title,
          "email": newCard.email,
          "image": newCard.image
        }
      ),
    );
    userCard = newCard;
    print("USER CARD: $userCard");
    print(res.body);
    notifyListeners();
  }
}

class Card {
  String name;
  String image;
  String title;
  String email;

  Card(this.name, this.image, this.title, this.email);
}
