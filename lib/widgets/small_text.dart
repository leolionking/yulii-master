import 'package:flutter/material.dart';
import 'package:yulli/themes/yulli_themes.dart';

class SmallText extends StatelessWidget {
  String label;
  bool bold;
  SmallText(this.label, {bold = false}) : this.bold = bold;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: YulliColors.grey_dark,
        fontSize: 13,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
