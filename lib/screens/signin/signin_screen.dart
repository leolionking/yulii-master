import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/constants/asset_images.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/routing/app_router.dart';
import 'package:yulli/screens/signin/ui/widgets/signin_form.dart';
import 'package:yulli/screens/signin/viewmodels/signin_form_viewmodel.dart';
import 'package:yulli/services/auth_service.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/app_button.dart';
import 'package:yulli/widgets/yulli_logo.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dimens = AppDimens.of(context);
    final localizations = AppLocalization.of(context);

    return ChangeNotifierProvider<SignInFormViewModel>(
      create: (_) => SignInFormViewModel(
        AppLocalization.of(context),
        Provider.of<AuthService>(context, listen: false),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.8, 1.0],
                  colors: [
                    AppColors.primary,
                    Colors.white,
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: AppDimens.xlPadding,
                ),
                child: FractionallySizedBox(
                  widthFactor: .8,
                  child: Image.asset(
                    AssetImages.signInBG1,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: AppDimens.lgPadding,
                ),
                child: FractionallySizedBox(
                  widthFactor: .5,
                  child: Image.asset(
                    AssetImages.signInBG2,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.7, 1.0],
                  colors: [
                    AppColors.primary.withOpacity(.6),
                    Colors.white.withOpacity(.3),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom,
                  top: AppDimens.smPadding,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.9),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      localizations.labels.dontHaveAnAccount,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.defaultTextColor,
                            fontSize: AppDimens.of(context).getSizeByScreenType(
                              {
                                DeviceScreenType.smallPhone: 13,
                              },
                              defaultValue: 15,
                            ),
                          ),
                    ),
                    Selector<SignInFormViewModel, bool>(
                      builder: (_, submitting, __) => AppButton(
                        isFlat: true,
                        onPressed: () => AppRouter().goToSignUp(context),
                        text: localizations.labels.signUp,
                        shrinkwrap: true,
                        disabled: submitting,
                        hasBaseWidth: false,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDimens.smPadding,
                        ),
                        color: AppColors.secondary,
                      ),
                      selector: (_, viewModel) => viewModel.submitting,
                    ),
                  ],
                ),
              ),
            ),
            LayoutBuilder(
              builder: (_, constraints) {
                return SafeArea(
                  child: Container(
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: dimens.getSizeByScreenType(
                              {
                                DeviceScreenType.smallPhone: AppDimens.padding,
                                DeviceScreenType.mediumPhone:
                                    AppDimens.of(context)
                                            .isAtLeastMediumVariant3
                                        ? AppDimens.xxlPadding
                                        : AppDimens.of(context)
                                                .isAtLeastMediumVariant2
                                            ? AppDimens.xlPadding
                                            : AppDimens.xlPadding,
                              },
                              defaultValue: AppDimens.xxlPadding,
                            ),
                          ),
                          YulliLogo(),
                          SizedBox(
                            height: dimens.getSizeByScreenType(
                              {
                                DeviceScreenType.smallPhone:
                                    AppDimens.mdPadding,
                              },
                              defaultValue: AppDimens.lgPadding,
                            ),
                          ),
                          SignInForm(),
                        ],
                      ),
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
