import 'package:flutter/material.dart';
import 'package:yulli/themes/app_dimens.dart';

class SignUpScreenThemes {
  final BuildContext context;
  static const Color captionTextColor = const Color(0xFFE3E3E3);

  SignUpScreenThemes._init(this.context);

  factory SignUpScreenThemes.of(BuildContext context) =>
      SignUpScreenThemes._init(context);

  TextStyle get captionTextStyle {
    final dimens = AppDimens.of(context);

    return Theme.of(context).textTheme.body1.copyWith(
          color: captionTextColor,
          fontWeight: FontWeight.w600,
          height: 1.25,
          fontSize: dimens.getSizeByScreenType(
            {
              DeviceScreenType.smallPhone: 15,
            },
            defaultValue: null,
          ),
        );
  }
}
