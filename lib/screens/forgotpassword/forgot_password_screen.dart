import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/screens/forgotpassword/ui/widgets/forgot_password_form.dart';
import 'package:yulli/screens/forgotpassword/viewmodels/forgot_password_form_viewmodel.dart';
import 'package:yulli/services/auth_service.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/primary_gradient_bg.dart';
import 'package:yulli/widgets/yulli_logo.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dimens = AppDimens.of(context);
    final localizations = AppLocalization.of(context);

    return ChangeNotifierProvider<ForgotPasswordFormViewModel>(
      create: (_) => ForgotPasswordFormViewModel(
        AppLocalization.of(context),
        Provider.of<AuthService>(context, listen: false),
      ),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            PrimaryGradientBg(),
            // AppBar(
            //   title: Text(localizations.labels.retrievePassword),
            //   elevation: 0,
            //   backgroundColor: Colors.transparent,
            //   iconTheme: IconThemeData(
            //     color: Colors.white,
            //   ),
            // ),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimens.padding,
                          ),
                          child: Text(
                            localizations.labels.sendPasswordReset,
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
                        ForgotPasswordForm(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
