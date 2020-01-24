import "package:flutter/material.dart";
import "../providers/user.dart";

class CardTemplate extends StatelessWidget {
  final VirtualCard selectedCard;
  CardTemplate(this.selectedCard);
  @override
  Widget build(BuildContext context) {
    return Container(
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
                child: selectedCard.image
                // child: Image.network(
                //   selectedCard.image,
                //   fit: BoxFit.cover,
                // )

                // child: Image.network(
                //   "https://lh3.googleusercontent.com/YxnIsRXL_n-wP8DOB3_-3JiolhkGCzAGFQIJIRtzbWwZQNrdn-IsPoDveYYX23oWoKz3b5BPsXRBB22SN1RLKW5mxHUThBl0Ydtm5RHl9L-PZJilAIf4YaZzYcXaJt6mgrEeWvLahA=w2400",
                //   fit: BoxFit.cover,
                // ),
                ),
          ),
          Container(
            height: 85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              color: Color.fromRGBO(255, 255, 255, .9),
            ),
            width: double.infinity,
            // margin: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  selectedCard.name,
                  style: Theme.of(context).textTheme.subtitle,
                ),
                Text(
                  selectedCard.title,
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
