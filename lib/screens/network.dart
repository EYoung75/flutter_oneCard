import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../providers/user.dart";
import "./networkCheckedIn.dart";
import "./networkSearch.dart";

class Network extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
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
        child: user.isloading == true
            ? CircularProgressIndicator()
            : Container(
                child: user.checkedIn == null ? NetworkSearch() : CheckedIn(),
              ),
      ),
    );
  }
}
