import "package:flutter/material.dart";

class ScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            height: 450,
            width: 350,
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
                    child: Image.network(
                      "https://lh3.googleusercontent.com/YxnIsRXL_n-wP8DOB3_-3JiolhkGCzAGFQIJIRtzbWwZQNrdn-IsPoDveYYX23oWoKz3b5BPsXRBB22SN1RLKW5mxHUThBl0Ydtm5RHl9L-PZJilAIf4YaZzYcXaJt6mgrEeWvLahA=w2400",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(255, 255, 255, .8),
                  ),
                  width: double.infinity,
                  margin: EdgeInsets.all(25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Evan Young",
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                      Text(
                        "Software Engineer",
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton.icon(
                icon: Icon(Icons.add),
                onPressed: () {},
                label: Text("Add"),
              ),
              RaisedButton.icon(
                icon: Icon(Icons.delete),
                onPressed: () {},
                label: Text("Delete"),
              )
            ],
          )
        ],
      ),
    );
  }
}
