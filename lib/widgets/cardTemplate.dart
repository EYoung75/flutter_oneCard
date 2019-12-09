import "package:flutter/material.dart";

class CardTemplate extends StatelessWidget {
  String name;
  String title;
  dynamic image;
  String userId;

  CardTemplate(
    this.name,
    this.title,
    this.image,
    this.userId,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 100),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 30,
            spreadRadius: 10,
            offset: Offset(5, 5),
          )
        ],
        borderRadius: BorderRadius.circular(10),
        color: Colors.white70,
      ),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
            height: 450,
            width: double.infinity,
            child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                child: Text("")
                ),
          ),
          Container(
            height: 85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              color: Color.fromRGBO(255, 255, 255, .7),
            ),
            width: double.infinity,
            // margin: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  name,
                  style: Theme.of(context).textTheme.subtitle,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
