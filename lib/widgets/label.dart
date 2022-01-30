import 'package:flutter/material.dart';
import 'package:yulli/themes/yulli_themes.dart';

class Label extends StatelessWidget {
  final int maxLines;
  final String label;

  const Label({
    Key key,
    @required this.label,
    this.maxLines = 1,
  })  : assert(label != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: YulliColors.black,
        fontWeight: FontWeight.bold,
        fontSize: 17,
      ),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
