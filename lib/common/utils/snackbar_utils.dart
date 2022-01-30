import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yulli/themes/app_colors.dart';

class SnackbarUtils {
  final BuildContext context;

  SnackbarUtils(this.context);

  factory SnackbarUtils.of(BuildContext context) => SnackbarUtils(context);

  ScaffoldFeatureController showError(
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    Scaffold.of(context).hideCurrentSnackBar();
    return Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: Colors.white,
              ),
        ),
        backgroundColor: AppColors.errorColor,
        duration: duration,
      ),
    );
  }

  ScaffoldFeatureController show(
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    Scaffold.of(context).hideCurrentSnackBar();
    return Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        duration: duration,
      ),
    );
  }
}
