import 'dart:async';

import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/common/utils/focus_node_utils.dart';
import 'package:yulli/common/utils/snackbar_utils.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/routing/app_router.dart';
import 'package:yulli/screens/signup/viewmodels/signup_form_viewmodel.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/app_button.dart';
import 'package:yulli/widgets/sign_input.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SignUpFormViewModel _viewModel;
  TextEditingController _lastnameController;
  TextEditingController _firstnameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  StreamSubscription _hasUnexpectedExceptionSubscription;
  StreamSubscription _unexpectedExceptionSubscription;
  StreamSubscription _isSubmittingSubscription;
  ScaffoldFeatureController _isSubmittingController;

  final FocusNode _lastnameFocus = FocusNode();
  final FocusNode _firstnameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  void _onSubmit() async {
    if (await _viewModel.validate()) {
      AppRouter().goToVerifyCode(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _lastnameController = TextEditingController()
      ..addListener(() {
        _viewModel?.setLastName(_lastnameController.text.trim());
      });
    _firstnameController = TextEditingController()
      ..addListener(() {
        _viewModel?.setFirstName(_firstnameController.text.trim());
      });
    _emailController = TextEditingController()
      ..addListener(() {
        _viewModel?.setEmail(_emailController.text.trim());
      });
    _passwordController = TextEditingController()
      ..addListener(() {
        _viewModel?.setPassword(_passwordController.text);
      });
  }

  @override
  void didChangeDependencies() {
    _viewModel ??= Provider.of<SignUpFormViewModel>(context)
      ..init(_formKey)
      ..validateAllInputs(notify: false);

    _hasUnexpectedExceptionSubscription ??=
        _viewModel.hasUnexpectedException.listen((event) {
      SnackbarUtils.of(context).showError(
        AppLocalization.of(context).errors.exceptions.unexpected,
      );
    });

    _unexpectedExceptionSubscription ??=
        _viewModel.unexpectedExceptionStream.listen((event) {
      SnackbarUtils.of(context).showError(
        event.message ??
            AppLocalization.of(context).errors.exceptions.unexpected,
      );
    });

    _isSubmittingSubscription ??= _viewModel.submittingStream.listen((event) {
      if (event) {
        _isSubmittingController = SnackbarUtils.of(context).show(
          AppLocalization.of(context).events.submitting,
          duration: Duration(minutes: 5),
        );
      } else {
        try {
          _isSubmittingController?.close();
        } catch (_) {}
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _lastnameController?.dispose();
    _firstnameController?.dispose();
    _emailController?.dispose();
    _passwordController?.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _lastnameFocus.dispose();
    _firstnameFocus.dispose();
    _hasUnexpectedExceptionSubscription?.cancel();
    _isSubmittingSubscription?.cancel();
    _unexpectedExceptionSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context);
    return Form(
      key: _formKey,
      autovalidate: _viewModel.autoValidate,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.of(context).getSizeByScreenType(
            {
              DeviceScreenType.smallPhone: AppDimens.mdPadding,
              DeviceScreenType.mediumPhone:
                  AppDimens.of(context).isAtLeastMediumVariant3
                      ? AppDimens.xlPadding
                      : AppDimens.lgPadding,
            },
            defaultValue: AppDimens.xlPadding,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SignInput(
              label: localizations.labels.lastname,
              hint: localizations.hints.lastname,
              iconData: FeatherIcons.user,
              controller: _lastnameController,
              enabled: !_viewModel.submitting,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              focusNode: _lastnameFocus,
              validator: (_) => _viewModel.lastnameError,
              marginBottom: AppDimens.of(context).getSizeByScreenType(
                {
                  DeviceScreenType.smallPhone: AppDimens.smPadding,
                  DeviceScreenType.mediumPhone:
                      AppDimens.of(context).screenSize.height > 667
                          ? AppDimens.padding
                          : AppDimens.smPadding,
                },
                defaultValue: AppDimens.padding,
              ),
              onFieldSubmitted: (_) {
                FocusNodeUtils.changeFocus(
                    context, _lastnameFocus, _firstnameFocus);
              },
            ),
            SignInput(
              label: localizations.labels.firstname,
              hint: localizations.hints.firstname,
              iconData: FeatherIcons.user,
              enabled: !_viewModel.submitting,
              controller: _firstnameController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              focusNode: _firstnameFocus,
              validator: (_) => _viewModel.firstnameError,
              marginBottom: AppDimens.of(context).getSizeByScreenType(
                {
                  DeviceScreenType.smallPhone: AppDimens.smPadding,
                  DeviceScreenType.mediumPhone:
                      AppDimens.of(context).screenSize.height > 667
                          ? AppDimens.padding
                          : AppDimens.smPadding,
                },
                defaultValue: AppDimens.padding,
              ),
              onFieldSubmitted: (_) {
                FocusNodeUtils.changeFocus(
                    context, _firstnameFocus, _emailFocus);
              },
            ),
            SignInput(
              label: localizations.labels.email,
              hint: localizations.labels.email,
              iconData: FeatherIcons.mail,
              controller: _emailController,
              enabled: !_viewModel.submitting,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              focusNode: _emailFocus,
              validator: (_) => _viewModel.emailError,
              marginBottom: AppDimens.of(context).getSizeByScreenType(
                {
                  DeviceScreenType.smallPhone: AppDimens.smPadding,
                  DeviceScreenType.mediumPhone:
                      AppDimens.of(context).screenSize.height > 667
                          ? AppDimens.padding
                          : AppDimens.smPadding,
                },
                defaultValue: AppDimens.padding,
              ),
              onFieldSubmitted: (_) {
                FocusNodeUtils.changeFocus(
                    context, _emailFocus, _passwordFocus);
              },
            ),
            SignInput(
              label: localizations.labels.password,
              hint: localizations.hints.password,
              obscured: true,
              obscurable: true,
              enabled: !_viewModel.submitting,
              iconData: FeatherIcons.lock,
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              focusNode: _passwordFocus,
              validator: (_) => _viewModel.passwordError,
              marginBottom: AppDimens.of(context).getSizeByScreenType(
                {
                  DeviceScreenType.smallPhone: AppDimens.smPadding,
                  DeviceScreenType.mediumPhone: AppDimens.smPadding,
                },
                defaultValue: AppDimens.padding,
              ),
              onFieldSubmitted: (_) {
                FocusNodeUtils.changeFocus(context, _passwordFocus, null);
                this._onSubmit();
              },
            ),
            SizedBox(
              height: AppDimens.of(context).getSizeByScreenType(
                {
                  DeviceScreenType.smallPhone: AppDimens.smPadding,
                  DeviceScreenType.mediumPhone:
                      AppDimens.of(context).screenSize.height > 667
                          ? AppDimens.mdPadding
                          : AppDimens.padding,
                },
                defaultValue: AppDimens.lgPadding,
              ),
            ),
            AppButton(
              onPressed: this._onSubmit,
              loading: _viewModel.submitting,
              text: localizations.labels.toSignUp,
            ),
            SizedBox(
              height: AppDimens.smPadding,
            ),
            AppButton(
              onPressed: () => Navigator.of(context).pop(),
              text: localizations.labels.alreadyHaveAccount,
              disabled: _viewModel.submitting,
              isFlat: true,
            ),
            SizedBox(
              height: AppDimens.mdPadding,
            ),
          ],
        ),
      ),
    );
  }
}
