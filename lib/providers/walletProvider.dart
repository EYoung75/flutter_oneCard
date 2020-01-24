import "dart:async";
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
  List<dynamic> wallet;
  bool loading = true;
  List filteredUsers;

  Future scanQR() async {
    loading = true;
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
    loading = false;
    notifyListeners();
    print(_result.toString());
  }

  Future<void> addUser() async {
    final userOne =
        "https://onecard-a0072.firebaseio.com/users/$userId/wallet/${scannedCard.userId}.json?auth=$authToken";
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

    _result = "";
    scannedCard = null;
    notifyListeners();
    print(
      json.decode(res.body),
    );
  }

  Future<void> fetchUser() async {
    loading = true;
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
    loading = false;
    notifyListeners();
  }

  Future<void> cancel() async {
    scannedCard = null;
    _result = "";
    notifyListeners();
  }

  Future<void> fetchWallet() async {
    try {
      final url =
          'https://onecard-a0072.firebaseio.com/users/$userId/wallet.json?auth=$authToken';
      final res = await http.get(url);
      final resData = json.decode(res.body);
      List newWallet = [];
      if (resData != null) {
        await resData.forEach((key, value) async {
          VirtualCard userCard = VirtualCard(
            resData[key]["userId"],
            resData[key]["name"],
            Image.network(
              resData[key]["image"],
              fit: BoxFit.cover,
            ),
            resData[key]["title"],
          );
          newWallet.add(userCard);
        });
        wallet = newWallet;
      } else {
        wallet = null;
      }
    } catch (err) {
      wallet = null;
      throw (err);
    }
    print("FINAL WALLET ${wallet}");
    notifyListeners();
  }

  Future userSearch(searchTerm) async {
    String url =
        "https://onecard-a0072.firebaseio.com/users.json?&auth=$authToken";
    final res = await http.get(url);

  }

  Future<void> deleteUser(String id) async {
    final url = 'https://onecard-a0072.firebaseio.com/users/$userId/wallet/$id.json?auth=$authToken';
    await http.delete(url);
    notifyListeners();
  }
}
