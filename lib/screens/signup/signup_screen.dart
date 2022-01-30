import 'dart:async';

import 'package:flutter_html/style.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html/dom.dart' as dom;

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:yulli/abstracts/form_viewmodel.dart';
import 'package:yulli/constants/asset_images.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/screens/signup/ui/themes/signup_screen_text_styles.dart';
import 'package:yulli/screens/signup/ui/widgets/signup_form.dart';
import 'package:yulli/screens/signup/viewmodels/signup_form_viewmodel.dart';
import 'package:yulli/services/auth_service.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/primary_gradient_bg.dart';
import 'package:yulli/widgets/yulli_logo.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final ScrollController _controller = ScrollController();
  StreamSubscription _streamSubscription;
  final keyboardVisibilityController = KeyboardVisibilityController();

  bool _isKeyboardVisible = false;

  bool get isScrollable =>
      _isKeyboardVisible ||
      !AppDimens.of(context).atLeast(DeviceScreenType.mediumPhone);

  void _scrollToTop() {
    _controller.animateTo(
      0,
      duration: Duration(milliseconds: 400),
      curve: Curves.linear,
    );
  }

  void _onKeyboardVisibilityListener(bool isVisible) {
    print("is visible $isVisible");

    if (!isVisible &&
        AppDimens.of(context).atLeast(DeviceScreenType.mediumPhone)) {
      _scrollToTop();
    }

    setState(() {
      _isKeyboardVisible = isVisible;
    });
    print("is scrollable $isScrollable");
  }

  @override
  void initState() {
    super.initState();
    _streamSubscription = keyboardVisibilityController.onChange
        .distinct()
        .listen(this._onKeyboardVisibilityListener);
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dimens = AppDimens.of(context);
    final localizations = AppLocalization.of(context);

    return ChangeNotifierProvider<SignUpFormViewModel>(
      create: (_) => SignUpFormViewModel(
        AppLocalization.of(context),
        Provider.of<AuthService>(context, listen: false),
      ),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            PrimaryGradientBg(),
            Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: .5,
                child: Image.asset(
                  AssetImages.treeBG,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            SizedBox.expand(
              child: LayoutBuilder(
                builder: (_, constraints) {
                  return Selector<SignUpFormViewModel, FormValidationState>(
                    selector: (_, signUpFormViewModel) =>
                        signUpFormViewModel.validationState,
                    builder: (context, formValidationState, child) {
                      final scrollBlocked =
                          !isScrollable && formValidationState.isIdleOrValid;

                      if (scrollBlocked) {
                        Future.microtask(() => this._scrollToTop());
                      }

                      return SingleChildScrollView(
                        controller: _controller,
                        physics: scrollBlocked
                            ? NeverScrollableScrollPhysics()
                            : null,
                        child: child,
                      );
                    },
                    child: SafeArea(
                      child: Container(
                        alignment: !AppDimens.of(context)
                                .atLeast(DeviceScreenType.mediumPhone)
                            ? Alignment.center
                            : null,
                        constraints: BoxConstraints(
                          minWidth: constraints.maxWidth,
                          minHeight: constraints.maxHeight,
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
                                    DeviceScreenType.smallPhone:
                                        AppDimens.mdPadding,
                                    DeviceScreenType.mediumPhone:
                                        AppDimens.of(context)
                                                .isAtLeastMediumVariant3
                                            ? AppDimens.xxlPadding
                                            : AppDimens.of(context)
                                                    .isAtLeastMediumVariant2
                                                ? AppDimens.lgPadding
                                                : AppDimens.xsPadding,
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
                                    DeviceScreenType.mediumPhone:
                                        AppDimens.of(context)
                                                    .screenSize
                                                    .height >
                                                667
                                            ? AppDimens.lgPadding
                                            : AppDimens.mdPadding,
                                  },
                                  defaultValue: AppDimens.xlPadding,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: dimens.getSizeByScreenType(
                                    {
                                      DeviceScreenType.smallPhone:
                                          AppDimens.smPadding,
                                    },
                                    defaultValue: AppDimens.lgPadding,
                                  ),
                                ),
                                child: Html(
                                  data: localizations.richtext.signUpCaption(
                                    tagOneOpen: "<span>",
                                    tagOneClose: "</span>",
                                    tagTwoOpen: "<span>",
                                    tagTwoClose: "</span>",
                                  ),
                                  style: {
                                    "html": Style(
                                      color: SignUpScreenThemes.of(context)
                                          .captionTextStyle
                                          .color,
                                      fontWeight: SignUpScreenThemes.of(context)
                                          .captionTextStyle
                                          .fontWeight,
                                      fontSize: FontSize(
                                          SignUpScreenThemes.of(context)
                                              .captionTextStyle
                                              .fontSize),
                                      textAlign: TextAlign.center,
                                    ),
                                    "span": Style.fromTextStyle(
                                        SignUpScreenThemes.of(context)
                                            .captionTextStyle
                                            .copyWith(
                                              color: AppColors.secondary,
                                            ))
                                  },
                                ),
                              ),
                              SizedBox(
                                height: dimens.getSizeByScreenType(
                                  {
                                    DeviceScreenType.smallPhone:
                                        AppDimens.padding,
                                    DeviceScreenType.mediumPhone:
                                        AppDimens.of(context)
                                                    .screenSize
                                                    .height >
                                                667
                                            ? AppDimens.lgPadding
                                            : AppDimens.mdPadding,
                                  },
                                  defaultValue: AppDimens.mdPadding,
                                ),
                              ),
                              SignUpForm(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
