import "package:flutter/material.dart";

class Background extends StatelessWidget {
  Widget childContent;
  Background(this.childContent);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor.withOpacity(.7),
            Theme.of(context).primaryColor.withOpacity(.9),
            Theme.of(context).primaryColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: childContent,
    );
  }
}
