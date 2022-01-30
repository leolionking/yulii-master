import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/common/utils/snackbar_utils.dart';
import 'package:yulli/exceptions/throttling_exception.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/routing/app_router.dart';
import 'package:yulli/screens/verifycode/viewmodels/verify_code_viewmodel.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/app_button.dart';
import 'package:yulli/widgets/yulli_logo.dart';

class VerifyCodeMainContent extends StatefulWidget {
  const VerifyCodeMainContent({Key key}) : super(key: key);

  @override
  _VerifyCodeMainContentState createState() => _VerifyCodeMainContentState();
}

class _VerifyCodeMainContentState extends State<VerifyCodeMainContent> {
  VerifyCodeViewModel _viewModel;
  StreamSubscription _submittingSubcription;
  ScaffoldFeatureController _scaffoldFeatureController;

  void _resendVerification() async {
    final localization = AppLocalization.of(context);
    try {
      await _viewModel.resendVerfification();
      SnackbarUtils.of(context).show(
        localization.notice.emailSent,
      );
    } on ThrottlingException {
      SnackbarUtils.of(context).show(
        localization.notice.waitInSeconds(
          seconds: _viewModel.throttleDiff.toString(),
        ),
      );
    } catch (e) {
      print(e);
      SnackbarUtils.of(context).showError(
        AppLocalization.of(context).errors.exceptions.networkConnectionFailed,
      );
    }
  }

  void _checkVerification() async {
    final localization = AppLocalization.of(context);
    try {
      if (await _viewModel.checkVerification()) {
        AppRouter().goToMain(context);
      } else {
        SnackbarUtils.of(context).show(
          localization.notice.emailNotVerified,
        );
      }
    } catch (e) {
      print(e);
      SnackbarUtils.of(context).showError(
        AppLocalization.of(context).errors.exceptions.networkConnectionFailed,
      );
    }
  }

  @override
  void didChangeDependencies() {
    _viewModel ??= Provider.of<VerifyCodeViewModel>(context);
    _submittingSubcription ??= _viewModel.submitting.listen((event) {
      if (event) {
        _scaffoldFeatureController = SnackbarUtils.of(context).show(
          AppLocalization.of(context).events.submitting,
          duration: Duration(minutes: 5),
        );
      } else {
        try {
          _scaffoldFeatureController?.close();
        } catch (e) {}
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _submittingSubcription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dimens = AppDimens.of(context);
    final localizations = AppLocalization.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
        Text(
          localizations.labels.clickOnVerificationLink,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: dimens.getSizeByScreenType(
            {
              DeviceScreenType.smallPhone: AppDimens.smPadding,
            },
            defaultValue: AppDimens.padding,
          ),
        ),
        SizedBox(
          height: AppDimens.smPadding,
        ),
        AppButton(
          onPressed: this._checkVerification,
          text: localizations.actions.check,
          loading: _viewModel.checking,
          disabled: _viewModel.resending,
        ),
        SizedBox(
          height: AppDimens.padding,
        ),
        AppButton(
          isFlat: true,
          loading: _viewModel.resending,
          disabled: _viewModel.checking,
          onPressed: this._resendVerification,
          text: localizations.actions.resendEmailVerification,
        )
      ],
    );
  }
}
