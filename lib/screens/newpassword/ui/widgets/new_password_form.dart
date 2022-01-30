import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:yulli/common/utils/focus_node_utils.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/routing/app_router.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/app_button.dart';
import 'package:yulli/widgets/sign_input.dart';

class NewPasswordForm extends StatefulWidget {
  const NewPasswordForm({Key key}) : super(key: key);

  @override
  _NewPasswordFormState createState() => _NewPasswordFormState();
}

class _NewPasswordFormState extends State<NewPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _newPasswordController;
  TextEditingController _passwordConfirmationController;
  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _passwordConfirmationFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController()..addListener(() {});
    _passwordConfirmationController = TextEditingController()
      ..addListener(() {});
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _passwordConfirmationController.dispose();
    _newPasswordFocus.dispose();
    _passwordConfirmationFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context);
    return Form(
      key: _formKey,
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
              label: localizations.labels.newPassord,
              hint: localizations.hints.newPassord,
              iconData: FeatherIcons.lock,
              controller: _newPasswordController,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              focusNode: _newPasswordFocus,
              marginBottom: AppDimens.padding,
              onFieldSubmitted: (_) {
                FocusNodeUtils.changeFocus(
                  context,
                  _newPasswordFocus,
                  _passwordConfirmationFocus,
                );
              },
            ),
            SignInput(
              label: localizations.labels.passwordConfirmation,
              hint: localizations.hints.passwordConfirmation,
              iconData: FeatherIcons.lock,
              controller: _passwordConfirmationController,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              focusNode: _passwordConfirmationFocus,
              marginBottom: AppDimens.padding,
              onFieldSubmitted: (_) {
                FocusNodeUtils.changeFocus(
                  context,
                  _passwordConfirmationFocus,
                  null,
                );
              },
            ),
            SizedBox(
              height: AppDimens.smPadding,
            ),
            AppButton(
              onPressed: () =>
                  AppRouter().goToSignIn(context, clearStack: true),
              text: localizations.labels.createNewPassord,
            ),
            SizedBox(
              height: AppDimens.padding,
            ),
            AppButton(
              isFlat: true,
              onPressed: () => AppRouter().router.pop(context),
              text: localizations.labels.back,
            )
          ],
        ),
      ),
    );
  }
}
