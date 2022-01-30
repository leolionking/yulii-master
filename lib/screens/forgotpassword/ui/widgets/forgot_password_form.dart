import 'dart:async';

import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/common/utils/focus_node_utils.dart';
import 'package:yulli/common/utils/snackbar_utils.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/routing/app_router.dart';
import 'package:yulli/screens/forgotpassword/viewmodels/forgot_password_form_viewmodel.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/app_button.dart';
import 'package:yulli/widgets/sign_input.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key key}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController;
  final FocusNode _emailFocus = FocusNode();
  ForgotPasswordFormViewModel _viewModel;
  StreamSubscription _unexpectedExceptionSubscription;
  StreamSubscription _isSubmittingSubscription;
  ScaffoldFeatureController _isSubmittingController;

  void _onSubmit() async {
    if (await _viewModel.validate()) {
      AppRouter().goToResetPasswordSent(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController()
      ..addListener(() {
        _viewModel.setEmail(_emailController.text.trim());
      });
  }

  @override
  void didChangeDependencies() {
    _viewModel ??= Provider.of<ForgotPasswordFormViewModel>(context)
      ..init(_formKey)
      ..validateAllInputs(notify: false);

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
    _emailController.dispose();
    _emailFocus.dispose();
    _isSubmittingSubscription?.cancel();
    _unexpectedExceptionSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context);
    final dimens = AppDimens.of(context);

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
              hint: localizations.hints.email,
              iconData: FeatherIcons.mail,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              enabled: !_viewModel.submitting,
              focusNode: _emailFocus,
              marginBottom: AppDimens.padding,
              validator: (_) => _viewModel.emailError,
              onFieldSubmitted: (_) {
                FocusNodeUtils.changeFocus(
                  context,
                  _emailFocus,
                  null,
                );
                this._onSubmit();
              },
            ),
            SizedBox(
              height: dimens.getSizeByScreenType(
                {
                  DeviceScreenType.smallPhone: 0,
                },
                defaultValue: AppDimens.smPadding,
              ),
            ),
            AppButton(
              onPressed: this._onSubmit,
              text: localizations.labels.retrievePassword,
              loading: _viewModel.submitting,
            ),
            SizedBox(
              height: AppDimens.padding,
            ),
            AppButton(
              isFlat: true,
              onPressed: () => AppRouter().router.pop(context),
              text: localizations.labels.back,
              disabled: _viewModel.submitting,
            )
          ],
        ),
      ),
    );
  }
}
