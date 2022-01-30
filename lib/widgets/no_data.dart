import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';

class NoData extends StatelessWidget {
  final String text;
  final double size;
  final double separationHeight;
  final TextStyle textStyle;
  final double iconSize;

  const NoData({
    Key key,
    this.text,
    this.size,
    this.separationHeight,
    this.textStyle,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: size ?? 100,
            height: size ?? 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.secondary,
            ),
            child: Icon(
              FeatherIcons.alertCircle,
              color: Colors.white,
              size: iconSize ?? 44,
            ),
          ),
          SizedBox(
            height: separationHeight ?? AppDimens.mdPadding,
          ),
          Text(
            text ?? localization.notices.noDataFound,
            style: textStyle ?? Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
