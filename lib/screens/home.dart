import "package:flutter/material.dart";
import "dart:async";
import "package:barcode_scan/barcode_scan.dart";
import "package:flutter/services.dart";

import "../widgets/mainCard.dart";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String result = "";
  bool showScan = false;

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
        showScan = true;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera access was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "Camera was not used to scan anything";
      });
    } catch (ex) {
      result = "Unknown error code: $ex";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor.withOpacity(.4),
            Theme.of(context).primaryColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MainCard(),
          SizedBox(
            height: 60,
          ),
          Container(
            child: Text(result),
          ),
          FloatingActionButton.extended(
            onPressed: _scanQR,
            elevation: 15,
            icon: Icon(Icons.camera_alt),
            label: Text(
              "Scan",
            ),
          )
        ],
      ),
    );
  }
}
