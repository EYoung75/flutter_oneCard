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

  Future<void> createUserProfile(String name) async {
    final url =
        "https://onecard-a0072.firebaseio.com/users/$userId/card.json?auth=$authToken";
    final res = await http.put(
      url,
      body: json.encode(
        {
          "userId": userId,
          "name": userCard.name,
          "title": userCard.title,
          "email": email,
          "image": userCard.image,
        },
      ),
    );
    print(res.body);
  }
}

class Card {
  String name;
  File image;
  String title;
  String email;
}
