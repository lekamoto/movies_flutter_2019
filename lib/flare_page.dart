
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class FlarePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<FlarePage> {
  @override
  Widget build(BuildContext context) {
    return favorite();
  }

  FlareActor heart() {

    // Like / Dislike
    return new FlareActor("assets/animations/heart.flr",
      alignment: Alignment.center,
      fit: BoxFit.contain,
      animation: "Dislike");
  }

  Widget favorite() {
    //Favorite / Unfavorite
    return new FlareActor("assets/animations/favorite.flr",
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: "Favorite");
  }
}
