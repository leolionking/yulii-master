import 'dart:async';

import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/common/utils/focus_node_utils.dart';
import 'package:yulli/common/utils/snackbar_utils.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/routing/app_router.dart';
import 'package:yulli/screens/signin/viewmodels/signin_form_viewmodel.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/app_button.dart';
import 'package:yulli/widgets/sign_input.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SignInFormViewModel _viewModel;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  StreamSubscription _unexpectedExceptionSubscription;
  StreamSubscription _isSubmittingSubscription;
  ScaffoldFeatureController _isSubmittingController;

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  void _onSubmit() async {
    if (await _viewModel.validate()) {
      final dbService = Provider.of<DbService>(context, listen: false);

      if (await dbService.hasUser(isVerified: true)) {
        return AppRouter().goToMain(context);
      }
      AppRouter().goToVerifyCode(context);
    }
  }

  @override
  void initState() {
    super.initState();
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
    _viewModel ??= Provider.of<SignInFormViewModel>(context)
      ..init(_formKey)
      ..validateAllInputs(notify: false);

    _unexpectedExceptionSubscription ??=
        _viewModel.unexpectedExceptionStream.listen((event) {
      print('exception  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
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
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _unexpectedExceptionSubscription?.cancel();
    _isSubmittingSubscription?.cancel();
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
              label: localizations.labels.email,
              hint: localizations.labels.email,
              iconData: FeatherIcons.mail,
              enabled: !_viewModel.submitting,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              focusNode: _emailFocus,
              marginBottom: AppDimens.padding,
              validator: (_) => _viewModel.emailError,
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
              marginBottom: AppDimens.padding,
              validator: (_) => _viewModel.passwordError,
              onFieldSubmitted: (_) {
                FocusNodeUtils.changeFocus(context, _passwordFocus, null);
                this._onSubmit();
              },
            ),
            SizedBox(
              height: AppDimens.padding,
            ),
            AppButton(
              onPressed: this._onSubmit,
              loading: _viewModel.submitting,
              text: localizations.labels.toSignIn,
            ),
            SizedBox(
              height: AppDimens.smPadding,
            ),
            AppButton(
              onPressed: () => AppRouter().goToForgotPassword(context),
              text: localizations.labels.forgottenPassword,
              disabled: _viewModel.submitting,
              isFlat: true,
            ),
          ],
        ),
      ),
    );
  }
}
