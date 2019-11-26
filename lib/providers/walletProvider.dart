import 'dart:async';

import 'package:flutter/material.dart';
import "./user.dart";
import "package:http/http.dart" as http;

class WalletProvider extends ChangeNotifier {
  List<VirtualCard> addedUsers = [];

  Future<void> addUser(String userId) async {
    final url = "";
    final res = await http.put(
      url,
    );
  }

  Future<void> deleteUser(String userId) async {
    final url = "";
    final res = await http.delete(
      url,
    );
  }
}
