import 'package:flutter/material.dart';
import 'package:yulli/themes/yulli_themes.dart';

class DealIcon extends StatelessWidget {
  int dealId;

  DealIcon(this.dealId);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: dealId == 1
                ? YulliColors.grey
                : dealId == 2 ? YulliColors.grey : YulliColors.yellow[500],
            width: 4),
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: dealId == 1
          ? Container(
              padding: EdgeInsets.all(15),
            )
          : dealId == 2
              ? Container(
                  padding: EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.check,
                    color: YulliColors.grey,
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    width: 15,
                    height: 15,
                    child: Image.asset("assets/images/shape.png"),
                  ),
                ),
    );
  }
}
