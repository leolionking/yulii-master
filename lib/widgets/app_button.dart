import 'package:flutter/material.dart';
import 'package:yulli/themes/app_button_themes.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isFlat;
  final Color color;
  final bool shrinkwrap;
  final bool hasBaseWidth;
  final EdgeInsets padding;
  final bool loading;
  final bool disabled;

  const AppButton({
    Key key,
    @required this.text,
    this.onPressed,
    this.isFlat = false,
    this.color,
    this.shrinkwrap = false,
    this.hasBaseWidth = true,
    this.padding,
    this.loading = false,
    this.disabled = false,
  })  : assert(loading != null),
        assert(disabled != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final dimens = AppDimens.of(context);
    final textWidget = Text(
      text,
      style: Theme.of(context).textTheme.button.copyWith(
            color: isFlat ? color ?? Colors.white : null,
            fontSize: dimens.getSizeByScreenType(
              {
                DeviceScreenType.smallPhone: 14,
              },
              defaultValue: null,
            ),
          ),
    );
    return ButtonTheme(
      textTheme: AppButtonThemes.lightDefaultButton.textTheme,
      shape: AppButtonThemes.lightDefaultButton.shape,
      layoutBehavior: AppButtonThemes.lightDefaultButton.layoutBehavior,
      padding: AppButtonThemes.lightDefaultButton.padding,
      height: dimens.getSizeByScreenType(
        {
          DeviceScreenType.smallPhone: AppDimens.buttonMinHeightSM,
        },
        defaultValue: AppDimens.buttonMinHeight,
      ),
      minWidth: hasBaseWidth ? AppButtonThemes.lightDefaultButton.minWidth : 0,
      child: isFlat
          ? FlatButton(
              onPressed: !disabled && !loading ? onPressed : null,
              child: textWidget,
              materialTapTargetSize: shrinkwrap
                  ? MaterialTapTargetSize.shrinkWrap
                  : MaterialTapTargetSize.padded,
              padding: padding ?? EdgeInsets.zero,
              textColor: AppColors.secondary,
            )
          : RaisedButton(
              elevation: 1,
              onPressed: !disabled && !loading ? onPressed : null,
              child: textWidget,
              padding: padding,
              materialTapTargetSize: shrinkwrap
                  ? MaterialTapTargetSize.shrinkWrap
                  : MaterialTapTargetSize.padded,
              color: color ?? AppColors.secondary,
            ),
    );
  }
}
