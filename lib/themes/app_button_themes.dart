import 'package:flutter/material.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';

class AppButtonThemes {
  static final ButtonThemeData lightDefaultButton = ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    buttonColor: AppColors.secondary,
    layoutBehavior: ButtonBarLayoutBehavior.padded,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(22),
    ),
    height: AppDimens.buttonMinHeight,
    padding: EdgeInsets.symmetric(
      horizontal: AppDimens.padding,
    ),
  );
}
