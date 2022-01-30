import 'package:dotted_border/dotted_border.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:yulli/themes/app_colors.dart';

class MyDottedButton extends StatelessWidget {
  final VoidCallback onTap;

  const MyDottedButton({
    Key key,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: DottedBorder(
            color: AppColors.dottedBorderColor,
            borderType: BorderType.Circle,
            dashPattern: [3.5],
            strokeCap: StrokeCap.butt,
            strokeWidth: 1,
            child: Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              child: Icon(
                Icons.add,
                color: AppColors.dottedBorderColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
