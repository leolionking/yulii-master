import 'package:flutter/material.dart';

class ClickableTextWidget extends StatelessWidget {
  final String label;
  final Function callBack;
  final TextStyle style;
  final bool isCenter;
  const ClickableTextWidget(
    this.label,
    this.style,
    this.callBack, {
    isCenter = true,
  }) : this.isCenter = isCenter;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        callBack();
      },
      child: new Text(
        label,
        style: style,
        textAlign: isCenter ? TextAlign.center : TextAlign.start,
      ),
    );
  }
}
