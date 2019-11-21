import 'dart:io';

import "package:flutter/material.dart";
import "dart:math";

import "../providers/auth.dart";
import "package:provider/provider.dart";
import "../models/httpException.dart";

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = "/auth";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor.withOpacity(.3),
              Theme.of(context).primaryColor.withOpacity(.7),
              Theme.of(context).primaryColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.only(top: 45),
          children: <Widget>[
            Text(
              "OneCard",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "RockSalt",
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
            AuthCard(),
          ],
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    "email": "",
    "password": "",
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Oops..."),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Okay",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false)
            .login(_authData["email"], _authData["password"]);
      } else {
        await Provider.of<Auth>(context, listen: false)
            .signUp(_authData["email"], _authData["password"]);
      }
    } on HttpException catch (err) {
      var errorMessage = "Authentication failed";
      if (err.toString().contains("EMAIL_EXISTS")) {
        errorMessage = "This email address already exists";
      } else if (err.toString().contains("INVALID_EMAIL")) {
        errorMessage = "Invalid email";
      } else if (err.toString().contains("WEAK_PASSWORD")) {
        errorMessage = "Password too weak";
      } else if (err.toString().contains("INVALID_PASSWORD")) {
        errorMessage = "Invalid Password";
      } else if (err.toString().contains("EMAIL_NOT_FOUND")) {
        errorMessage = "An account with this email could not be found.";
      }
      print("MESSAGE $errorMessage");
      _showErrorDialog(errorMessage);
    } catch (err) {}

    setState(() {
      _isLoading = false;
    });

    print(_authData);
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, .8),
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: Colors.blueGrey, width: 2),
        ),
        padding: EdgeInsets.symmetric(horizontal: 50),
        margin: EdgeInsets.symmetric(horizontal: 50),
        height: 350,
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_authMode == AuthMode.Login ? "Sign In" : "Sign Up"),
              TextFormField(
                decoration: InputDecoration(labelText: 'E-Mail:'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) {
                  _authData["email"] = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password:'),
                obscureText: true,
                controller: _passwordController,
                onSaved: (value) {
                  _authData["password"] = value;
                },
              ),
              _authMode == AuthMode.Signup
                  ? TextFormField(
                      enabled: _authMode == AuthMode.Signup,
                      decoration:
                          InputDecoration(labelText: "Confirm Password:"),
                      obscureText: true,
                      validator: _authMode == AuthMode.Signup
                          ? (value) {
                              if (value != _passwordController.text) {
                                return 'Passwords do not match!';
                              }
                            }
                          : null,
                    )
                  : Container(),
              _isLoading
                  ? CircularProgressIndicator(
                      backgroundColor: Colors.blueGrey,
                    )
                  : SizedBox(
                      height: 25,
                    ),
              RaisedButton(
                child: Text("Submit"),
                onPressed: _submit,
              ),
              FlatButton(
                child: Text(
                    _authMode == AuthMode.Signup ? " OR login" : "OR sign-up"),
                onPressed: _switchAuthMode,
              )
            ],
          ),
        ),
      ),
    );
  }
}
