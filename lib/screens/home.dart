import "package:flutter/material.dart";
import "../widgets/mainCard.dart";
import "package:provider/provider.dart";
import "../providers/user.dart";
import "./createCard.dart";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<User>(context);
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
      child: userInfo.userCard != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MainCard(),
                SizedBox(
                  height: 60,
                ),
              ],
            )
          : CreateCardScreen(),
    );
  }
}
