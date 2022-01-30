import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:yulli/themes/yulli_themes.dart';

class DottedButton extends StatelessWidget {
  Function callBack;
  DottedButton(this.callBack);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: DottedBorder(
        //customPath: (size) => customPath, // PathBuilder
        color: YulliColors.grey_dark,
        dashPattern: [3.5],
        strokeWidth: 0.5,
        borderType: BorderType.Circle,
        child: Container(
          //padding: EdgeInsets.all(1.0),
          decoration: BoxDecoration(),
          child: Icon(
            Icons.add,
            color: YulliColors.grey_dark,
            size: 18,
          ),
        ),
      ),
      onTap: () {
        callBack();
      },
    );
  }
}
