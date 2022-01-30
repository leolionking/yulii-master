import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  String text;
  Color linecolor;
  Color textColor;
  bool isBold;

  MyTitle(
    this.text,
    this.linecolor,
    this.textColor, {
    isBold = true,
  }) : this.isBold = isBold;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(text,
            style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: textColor,
                fontSize: 18)),
        Container(
          width: 20,
          padding: EdgeInsets.only(top: 3),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: linecolor, // Text colour here
            width: 3, // Underline width
          ))),
        )
      ],
    );
  }
}
