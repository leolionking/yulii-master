import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/screens/verifycode/ui/widgets/verify_code_main_content.dart';
import 'package:yulli/screens/verifycode/viewmodels/verify_code_viewmodel.dart';
import 'package:yulli/services/auth_service.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/app_button.dart';
import 'package:yulli/widgets/primary_gradient_bg.dart';
import 'package:yulli/widgets/yulli_logo.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({Key key}) : super(key: key);

  @override
  _VerifyCodeScreenState createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  @override
  Widget build(BuildContext context) {
    final dimens = AppDimens.of(context);

    return ChangeNotifierProvider<VerifyCodeViewModel>(
      create: (_) => VerifyCodeViewModel(
        Provider.of<AuthService>(context, listen: false),
        Provider.of<DbService>(context, listen: false),
      ),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            PrimaryGradientBg(),
            // AppBar(
            //   title: Text(localizations.labels.verifyCode),
            //   elevation: 0,
            //   backgroundColor: Colors.transparent,
            //   iconTheme: IconThemeData(
            //     color: Colors.white,
            //   ),
            // ),
            Consumer<VerifyCodeViewModel>(
              builder: (_, _viewModel, __) {
                return LayoutBuilder(
                  builder: (_, constraints) {
                    return Container(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                        minWidth: constraints.maxWidth,
                        maxWidth: constraints.maxWidth,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: dimens.getSizeByScreenType({
                            DeviceScreenType.smallPhone: AppDimens.mdPadding,
                          }, defaultValue: AppDimens.xlPadding),
                        ),
                        child: VerifyCodeMainContent(),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
