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

  String _result = "";
  bool showScan = false;
  VirtualCard scannedCard;
  dynamic wallet;

  Future scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      _result = qrResult;
      showScan = true;
      fetchUser();
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        _result = "Camera access was denied";
      } else {
        _result = "Unknown Error $ex";
      }
    } on FormatException {
      _result = "Camera was not used to scan anything";
    } catch (ex) {
      _result = "Unknown error code: $ex";
    }
    notifyListeners();
    print(_result.toString());
  }

  Future<void> addUser() async {
    final userOne =
        "https://onecard-a0072.firebaseio.com/users/$userId/wallets/${scannedCard.userId}.json?auth=$authToken";
    final res = await http.put(
      userOne,
      body: json.encode(
        {
          "userId": scannedCard.userId,
          "name": scannedCard.name,
          "title": scannedCard.title,
          "image": scannedCard.image
        },
      ),
    );
    // final userTwo =
    //     "https://onecard-a0072.firebaseio.com/users/$userId/card.json?auth=$authToken";
    // final resTwo = await http.get(userTwo).then(
    //   (res) {
    //     http.put(
    //       "https://onecard-a0072.firebaseio.com/users/${scannedCard.userId}/wallets/$userId.json?auth=$authToken",
    //       body: res,
    //     );
    //   },
    // );
    // final resTwo = await http.put(
    //   userTwo,
    //   body: json.encode(
    //     {
    //       "userId": scannedCard.userId,
    //       "name": scannedCard.name,
    //       "title": scannedCard.title,
    //       "image": scannedCard.image
    //     },
    //   ),
    // );
    _result = "";
    scannedCard = null;
    notifyListeners();
    print(
      json.decode(res.body),
    );
    // print(
    //   json.decode(resTwo.body),
    // );
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
    final url =
        "https://onecard-a0072.firebaseio.com/users/$userId/wallets.json?auth=$authToken";

    final res = await http.get(url);
    final resData = await json.decode(res.body);
    wallet = resData;
    print("WALLET:  ${json.decode(res.body)}");
    notifyListeners();
  }

  Future<void> deleteUser() async {
    final url = "";
    final res = await http.delete(url);
    _result = "";
    showScan = false;
    notifyListeners();
  }
}
