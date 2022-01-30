import 'package:flutter/material.dart';
import 'package:yulli/themes/app_button_themes.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_text_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Montserrat',
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    accentColor: AppColors.secondary,
    scaffoldBackgroundColor: Colors.white,
    buttonColor: AppColors.secondary,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
    ),
    textTheme: TextTheme(
      body1: AppTextStyles.defaultTextStyle,
      button: AppTextStyles.defaultButtonTextStyle,
      title: TextStyle(
        color: Colors.white,
      ),
    ),
    primaryTextTheme: TextTheme(
      title: TextStyle(
        color: Colors.white,
      ),
    ),
    buttonTheme: AppButtonThemes.lightDefaultButton,
  );
}
