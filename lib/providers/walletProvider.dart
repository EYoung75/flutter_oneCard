import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import "package:barcode_scan/barcode_scan.dart";
import "package:flutter/services.dart";
import 'package:flutter/material.dart';
import "./user.dart";
import "package:http/http.dart" as http;
import "dart:convert";

class WalletProvider extends ChangeNotifier {
  String userId;
  String authToken;
  WalletProvider(this.userId, this.authToken);

  List<VirtualCard> addedUsers = [];

  String result = "";
  bool showScan = false;

  Future scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();

      result = qrResult;
      showScan = true;
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        result = "Camera access was denied";
      } else {
        result = "Unknown Error $ex";
      }
    } on FormatException {
      result = "Camera was not used to scan anything";
    } catch (ex) {
      result = "Unknown error code: $ex";
    }
    notifyListeners();
    print(result.toString());
  }

  Future<void> addUser(String newUser) async {
    final url =
        "https://onecard-a0072.firebaseio.com/users/$userId/wallet/$newUser";
    final res = await http.put(
      url,
    );
  }

  Future<VirtualCard> fetchUser(String id) async {
    final url =
        "https://onecard-a0072.firebaseio.com/users/$id/card.json?auth=$authToken";
    final res = await http.get(url);
    final resData = await json.decode(res.body);
    final userImage = FirebaseStorage.instance.ref().child(resData["image"]);
    final fetchedImage = await userImage.getDownloadURL();
    return VirtualCard(
      resData["userId"],
      resData["name"],
      fetchedImage,
      resData["title"],
    );
  }

  Future<void> fetchCollections() async {
    final url = "https://onecard-a0072.firebaseio.com/users/$userId/wallet";
    final res = await http.get(url);
  }

  Future<void> deleteUser(String userId) async {
    final url = "";
    final res = await http.delete(
      url,
    );
  }
}
