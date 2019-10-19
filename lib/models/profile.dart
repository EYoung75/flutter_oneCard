import "package:flutter/foundation.dart";

class Profile {
  String name;
  String title;
  String imageUrl;

  Profile({
    @required this.name,
    @required this.title,
    this.imageUrl,
  });
}
