import "dart:async";
import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "../models/httpException.dart";

class Auth with ChangeNotifier {
  String _token;
  String _userId;
  DateTime _expiryDate;
  Timer _authTimer;
  String email;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get getEmail {
    return email;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenicate(String email, String password, String url) async {
    try {
      final res = await http.post(
        url,
        body: json.encode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );
      final resData = json.decode(res.body);
      print(resData);
       if(resData["error"] != null) {
        throw HttpException(resData["error"]["message"]);
      }
      _token = resData["idToken"];
      _userId = resData["localId"];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(resData["expiresIn"]),
        ),
      );
      email = email;
      notifyListeners();
      // final prefs = await SharedPreferences.getInstance();
      // final userData = json.encode(

      //   {
      //     "token": _token,
      //     "userId": _userId,
      //     "expiryDate": _expiryDate.toIso8601String()
      //   },
      // );
      // prefs.setString("userData", userData);
    } catch (err) {
      throw (err);
    }
  }

  Future<void> login(String email, String password) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=APIKEYHERE";

    return _authenicate(email, password, url);
  }

  Future<void> signUp(String email, String password) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=APIKEYHERE";

    await _authenicate(email, password, url);

    final createUserUrl = "https://onecard-a0072.firebaseio.com/users/$_userId.json?";
    final res = await http.put(
      createUserUrl,
      body: json.encode(
        {
          "userId": _userId,
          "email": email,
          "password": password,
        },
      ),
    );
    print(json.decode(res.body));
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
  }
}
