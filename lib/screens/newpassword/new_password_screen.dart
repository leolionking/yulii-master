import 'package:flutter/material.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/primary_gradient_bg.dart';
import 'package:yulli/widgets/yulli_logo.dart';
import 'package:yulli/screens/newpassword/ui/widgets/new_password_form.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dimens = AppDimens.of(context);
    final localizations = AppLocalization.of(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          PrimaryGradientBg(),
          LayoutBuilder(
            builder: (_, constraints) {
              return Container(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxWidth,
                  maxWidth: constraints.maxWidth,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.padding,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      YulliLogo(),
                      SizedBox(
                        height: dimens.getSizeByScreenType(
                          {
                            DeviceScreenType.smallPhone: AppDimens.mdPadding,
                          },
                          defaultValue: AppDimens.lgPadding,
                        ),
                      ),
                      NewPasswordForm(),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
