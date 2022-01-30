import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yulli/themes/app_text_styles.dart';

extension BuildContextExtension on BuildContext {
  bool get isIOS => Theme.of(this).platform == TargetPlatform.iOS;
  bool get isAndroid => Theme.of(this).platform == TargetPlatform.android;
  void pop<T>([T result]) => Navigator.of(this).pop<T>(result);

  double get pixelRatio => window.devicePixelRatio;
  double get statusBarHeight => window.padding.top / this.pixelRatio;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  double percentageOfScreenHeight(double value) => value / this.screenHeight;

  AppTextStyles get textStyles => AppTextStyles.of(this);

  void showBottomSheet(Widget bottomSheet) {
    assert(bottomSheet != null);
    showModalBottomSheet(
      context: this,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
      ),
      builder: (_) => bottomSheet,
    );
  }
}
