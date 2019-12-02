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

  String _result = "";
  bool showScan = false;
  // bool _qrError = false;
  VirtualCard scannedCard;

  // bool get qrContent {
  //   return _qrError;
  // }

  Future scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      _result = qrResult;
      showScan = true;
      fetchUser();
      // _qrError = false;
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        _result = "Camera access was denied";
      } else {
        _result = "Unknown Error $ex";
      }
      // _qrError = true;
    } on FormatException {
      _result = "Camera was not used to scan anything";
      // _qrError = true;
    } catch (ex) {
      _result = "Unknown error code: $ex";
      // _qrError = true;
    }
    notifyListeners();
    print(_result.toString());
  }

  Future<void> addUser() async {
    final url =
        "https://onecard-a0072.firebaseio.com/users/$userId/wallet/${scannedCard.userId}.json?auth=$authToken";
    final res = await http.put(
      url,
      body: json.encode(
        {
          "userId": scannedCard.userId,
          "name": scannedCard.name,
          "title": scannedCard.title,
          "image": scannedCard.image
        },
      ),
    );
    scannedCard = null;
    notifyListeners();
    print(
      json.decode(res.body),
    );
  }

  Future<void> fetchUser() async {
    final url =
        "https://onecard-a0072.firebaseio.com/users/$_result/card.json?auth=$authToken";
    final res = await http.get(url);
    final resData = await json.decode(res.body);
    final userImage = FirebaseStorage.instance.ref().child(resData["image"]);
    final fetchedImage = await userImage.getDownloadURL();
    scannedCard = VirtualCard(
      resData["userId"],
      resData["name"],
      fetchedImage,
      resData["title"],
    );
    notifyListeners();
  }

  Future<void> cancel() async {
    scannedCard = null;
    _result = "";
    notifyListeners();
  }

  Future<void> fetchCollections() async {
    final url = "https://onecard-a0072.firebaseio.com/users/$userId/wallet";
    final res = await http.get(url);
  }

  Future<void> deleteUser() async {
    final url = "";
    final res = await http.delete(url);
    _result = "";
    showScan = false;
    // _qrError = false;
    notifyListeners();
  }
}
