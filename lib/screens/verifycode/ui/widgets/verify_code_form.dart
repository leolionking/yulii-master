import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:yulli/common/utils/focus_node_utils.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/routing/app_router.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/app_button.dart';
import 'package:yulli/widgets/sign_input.dart';

class VerifyCodeForm extends StatefulWidget {
  const VerifyCodeForm({Key key}) : super(key: key);

  @override
  _VerifyCodeFormState createState() => _VerifyCodeFormState();
}

class _VerifyCodeFormState extends State<VerifyCodeForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _codeController;
  final FocusNode _codeFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController()..addListener(() {});
  }

  @override
  void dispose() {
    _codeFocus.dispose();
    _codeController.dispose();
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
              label: localizations.labels.code,
              hint: localizations.hints.code,
              iconData: FeatherIcons.lock,
              controller: _codeController,
              // keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              focusNode: _codeFocus,
              marginBottom: AppDimens.padding,
              onFieldSubmitted: (_) {
                FocusNodeUtils.changeFocus(
                  context,
                  _codeFocus,
                  null,
                );
              },
            ),
            SizedBox(
              height: AppDimens.smPadding,
            ),
            AppButton(
              onPressed: () => AppRouter().goToNewPassword(context),
              text: localizations.labels.verifyCode,
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
