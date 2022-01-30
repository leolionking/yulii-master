import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  String label;
  Color color;
  double width;
  bool isOutline;
  Function callBack;

  ButtonWidget(this.label, this.color, this.width, this.callBack,
      {bool isOutline = false})
      : isOutline = isOutline;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: ButtonTheme(
        minWidth: width,
        height: 50.0,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(50.0),
            side: BorderSide(color: color)),
        child: RaisedButton(
          elevation: 0.0,
          color: !isOutline ? color : Colors.transparent,
          onPressed: () {
            callBack();
          },
          child: Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
