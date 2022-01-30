import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';

class AppTextStyles {
  final BuildContext context;
  final AppDimens dimens;
  TextStyle _signInputLabelTextStyle;
  TextStyle _signInputHintTextStyle;

  static const TextStyle defaultTextStyle = const TextStyle(
    color: AppColors.defaultTextColor,
    fontSize: AppDimens.defaultTextSize,
  );

  static const TextStyle defaultButtonTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: AppDimens.defaultTextSize,
    fontWeight: FontWeight.w600,
  );

  AppTextStyles._init(this.context) : dimens = AppDimens.of(context);

  factory AppTextStyles.of(BuildContext context) =>
      AppTextStyles._init(context);

  TextStyle get signInputLabelTextStyle {
    return defaultTextStyle.copyWith(
      fontSize: AppDimens.signInputTextSize,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle get signInputTextStyle {
    return defaultTextStyle.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      height: 1.25,
      fontSize: dimens.getSizeByScreenType(
        {
          DeviceScreenType.smallPhone: 14,
        },
        defaultValue: null,
      ),
    );
  }

  TextStyle get signInputHintTextStyle {
    return defaultTextStyle.copyWith(
      color: Colors.white.withOpacity(.6),
      fontWeight: FontWeight.w600,
      height: 1.25,
      fontSize: dimens.getSizeByScreenType(
        {
          DeviceScreenType.smallPhone: 14,
        },
        defaultValue: null,
      ),
    );
  }

  TextStyle get notificationItem => defaultTextStyle.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      );

  TextStyle get chatListItemUserName => defaultTextStyle.copyWith(
        color: AppColors.defaultTextColor,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      );

  TextStyle get chatListItemExtract => defaultTextStyle.copyWith(
        color: AppColors.dividerColorOpaque,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
}
