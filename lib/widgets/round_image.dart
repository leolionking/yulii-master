import 'package:flutter/material.dart';

class RoundImage extends StatelessWidget {
  String image;
  RoundImage(this.image);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        child: Container(
          height: 30,
          width: 30,
          child: Image.asset(image),
        ));
  }
}
