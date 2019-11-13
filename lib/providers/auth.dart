import "dart:async";
import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class Auth with ChangeNotifier {
  String _token;
  String _userId;
  DateTime _expiryDate;
  Timer _authTimer;

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
      _token = resData["idToken"];
      _userId = resData["localId"];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(resData["expiresIn"]),
        ),
      );
      notifyListeners();
      // final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          "token": _token,
          "userId": _userId,
          "expiryDate": _expiryDate.toIso8601String()
        },
      );
      // prefs.setString("userData", userData);
    } catch (err) {
      throw (err);
    }
  }

  Future<void> login(String email, String password) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[API_KEY]";

    return _authenicate(email, password, url);
  }

  Future<void> signUp(String email, String password) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]";

    return _authenicate(email, password, url);
  }
}
