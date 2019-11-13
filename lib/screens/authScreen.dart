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
          children: <Widget>[AuthCard()],
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
    // _controller = AnimationController(
    //   duration: Duration(
    //     milliseconds: 300,
    //   ),
    // );
    // _slideAnimation = Tween<Offset>(
    //   begin: Offset(0, -1.5),
    //   end: Offset(0, 0),
    // ).animate(
    //   CurvedAnimation(parent: _controller, curve: Curves.linear),
    // );
    // _opacityAnim = Tween(begin: 0.0, end: 1.0).animate(
    //   CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    // );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("An error occurred"),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text("Okay"),
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
        // await Provider.of<Auth>(context, listen: false)
        //     .login(_authData["email"], _authData["password"]);
      } else {
        // await Provider.of<Auth>(context, listen: false)
            // .signUp(_authData["email"], _authData["password"]);
      }
    } 
     catch (err) {
      var errorMessage = "Unable to authenticate";
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, .8),
        borderRadius: BorderRadius.circular(7)
      ),
      padding: EdgeInsets.symmetric(horizontal: 50),
      margin: EdgeInsets.all(40),
      height: 300,
      width: double.infinity,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Sign In"),
            TextFormField(
              decoration: InputDecoration(labelText: 'E-Mail'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              controller: _passwordController,
            ),
            SizedBox(
              height: 25,
            ),
            RaisedButton(
              child: Text("Submit"),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
