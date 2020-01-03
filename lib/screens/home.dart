import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../providers/user.dart";
import "../widgets/mainCard.dart";
import "./createCard.dart";
import "../widgets/background.dart";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<User>(context);
    return Background( 
      userInfo.triedFetch == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : userInfo.userCard != null
              ? MainCard() 
              : userInfo.loading == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : CreateCardScreen(),
    );
  }
}
