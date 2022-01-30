import 'package:flutter/material.dart';

final ThemeData YulliThemeData = new ThemeData(
  brightness: Brightness.dark,
  primarySwatch: MaterialColor(0xFF673AB7, YulliColors.yellow),
  primaryColor: YulliColors.blue[500],
  primaryColorBrightness: Brightness.light,
  accentColor: YulliColors.yellow[500],
  accentColorBrightness: Brightness.light,
  backgroundColor: Colors.grey[100],
  fontFamily: 'Raleway',
  textTheme: TextTheme(
    caption: TextStyle(fontSize: 15, fontFamily: 'Raleway'),
    headline: TextStyle(fontSize: 72.0, fontFamily: 'Raleway'),
    title: TextStyle(fontSize: 36.0, fontFamily: 'Raleway'),
    subtitle: TextStyle(fontSize: 30.0, fontFamily: 'Raleway'),
    body1: TextStyle(fontSize: 14.0, fontFamily: 'Raleway'),
  ),
);

class YulliColors {
  YulliColors._();

  static const Map<int, Color> blue = {
    50: Color.fromRGBO(233, 243, 251, 1),
    100: Color.fromRGBO(201, 225, 245, 1),
    200: Color.fromRGBO(165, 205, 238, 1),
    300: Color.fromRGBO(128, 185, 231, 1),
    400: Color.fromRGBO(101, 170, 226, 1),
    500: Color.fromRGBO(74, 155, 221, 1),
    600: Color.fromRGBO(67, 147, 217, 1),
    700: Color.fromRGBO(58, 137, 212, 1),
    800: Color.fromRGBO(50, 127, 207, 1),
    900: Color.fromRGBO(34, 109, 199, 1),
  };

  static const Map<int, Color> yellow = {
    50: Color.fromRGBO(255, 255, 255, 1),
    100: Color.fromRGBO(255, 255, 255, 1),
    200: Color.fromRGBO(254, 252, 246, 1),
    300: Color.fromRGBO(250, 225, 179, 1),
    400: Color.fromRGBO(249, 214, 150, 1),
    500: Color.fromRGBO(247, 203, 121, 1),
    600: Color.fromRGBO(245, 192, 92, 1),
    700: Color.fromRGBO(244, 181, 63, 1),
    800: Color.fromRGBO(242, 169, 34, 1),
    900: Color.fromRGBO(232, 156, 14, 1),
  };

  //static Color grey = Color(0xffB6CBDB);
  static Color grey = Color(0xffB3C9DA);
  static Color grey_dark = Color(0xff444444);
  static Color dark = Color(0xff4B5161);
  static Color black = Color(0xff181A48);
  static Color yellow_light = Color(0xffFFF1E0);
  static Color red = Color(0xffFF2D55);
  static Color light = Color(0xfffafafa);
}

class YulliVars {
  static final double horizpadding = 30.0;
}
