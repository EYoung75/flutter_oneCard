import "../models/profile.dart";
import "dart:async";
import "package:http/http.dart" as http;
import "package:flutter/material.dart";
import "dart:convert";

class User {
  final String authToken;
  final String userId;
  // final profile = Profile();

  User(
    this.authToken,
    this.userId,
  );

  Future<void> fetchUserProfile() async {
    final url =
        "https://onecard-a0072.firebaseio.com/users/$userId/card.json?auth=$authToken";
    final res = await http.get(url);
    final resData = await json.decode(res.body);
  }

  Future<void> createUserProfile(Profile profile) async {
    final url =
        "https://onecard-a0072.firebaseio.com/users/$userId/card.json?auth=$authToken";
    final res = await http.put(
      url,
      body: json.encode(
        {""},
      ),
    );
    print(res.body);
  }
}
