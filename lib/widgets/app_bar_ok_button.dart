import 'package:flutter/material.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/app_button.dart';

class AppBarOkButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AppBarOkButton({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppButton(
      color: AppColors.primary,
      shrinkwrap: true,
      hasBaseWidth: false,
      text: "OK",
      isFlat: true,
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.mdPadding,
      ),
      onPressed: onPressed,
    );
  }
}
