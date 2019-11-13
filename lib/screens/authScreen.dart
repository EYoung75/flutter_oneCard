import "package:flutter/material.dart";
import "dart:math";

import "../providers/auth.dart";
import "package:provider/provider.dart";

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = "auth";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 50,
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
  AnimationController _controller;
  Animation<double> _opacityAnim;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
  }



  Future<void> _submit() async {
    if(!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if(_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false).login(_authData["email"], _authData["password"]);
      } else {
        await Provider.of<Auth>(context, listen: false).signUp(_authData["email"], _authData["password"]);
      }
    } catch(err) {
      throw(err);
    }

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
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, .8),
          borderRadius: BorderRadius.circular(7)),
      padding: EdgeInsets.symmetric(horizontal: 50),
      margin: EdgeInsets.all(40),
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
            _authMode == AuthMode.Signup ? TextFormField(
              enabled:  _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: "Confirm Password:"),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                          }
                        : null,
                  ) : Container(),
            SizedBox(
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
    );
  }
}
