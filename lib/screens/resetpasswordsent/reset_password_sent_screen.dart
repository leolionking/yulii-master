import 'package:flutter/material.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/routing/app_router.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/app_button.dart';
import 'package:yulli/widgets/primary_gradient_bg.dart';
import 'package:yulli/widgets/yulli_logo.dart';

class ResetPasswordSentScreen extends StatelessWidget {
  const ResetPasswordSentScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dimens = AppDimens.of(context);
    final localizations = AppLocalization.of(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          PrimaryGradientBg(),
          SizedBox.expand(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.padding,
                    ),
                    child: Text(
                      localizations.labels.passwordResetEmailSent,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: dimens.getSizeByScreenType(
                          {
                            DeviceScreenType.smallPhone: 14,
                          },
                          defaultValue: null,
                        ),
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: dimens.getSizeByScreenType(
                      {
                        DeviceScreenType.smallPhone: AppDimens.mdPadding,
                      },
                      defaultValue: AppDimens.lgPadding,
                    ),
                  ),
                  AppButton(
                    onPressed: () => AppRouter().router.pop(context),
                    text: localizations.labels.backToLogin,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
