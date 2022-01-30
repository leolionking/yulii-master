import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String data;
  final TextStyle style;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int maxLines;
  final int minLines;

  const MyText(
    this.data, {
    Key key,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.minLines,
  })  : assert(data != null),
        assert(minLines == null || minLines >= 1),
        assert(maxLines == null || minLines == null || maxLines >= minLines),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data + ('\n' * ((minLines ?? 1) - 1)),
      style: style,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
