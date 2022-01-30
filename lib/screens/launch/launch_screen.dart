import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yulli/common/viewmodels/app_language_viewmodel.dart';
import 'package:yulli/common/viewmodels/notifications_viewmodel.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/routing/app_router.dart';
import 'package:yulli/services/app_data.dart';
import 'package:yulli/services/auth_service.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/services/local_notifications_service.dart';
import 'package:yulli/services/notification_service.dart';
import 'package:yulli/themes/app_dimens.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key key}) : super(key: key);

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ScreenUtil.init(
        context,
        width: DEVICE_DRAFT_WIDTH,
        height: DEVICE_DRAFT_HEIGHT,
      );

      try {
        final dbService = Provider.of<DbService>(context, listen: false);
        final authService = Provider.of<AuthService>(context, listen: false);

        await Future.wait([
          Provider.of<AppLanguageViewModel>(context, listen: false).init(),
          dbService.launchInit(),
        ]);

        final firebaseUser = await authService.getAuthUser();
        var currentUser = await dbService.getCurrentUser();

        if (currentUser != null &&
            currentUser.isValid &&
            firebaseUser != null) {
          if (currentUser.isEmailVerified != firebaseUser.emailVerified) {
            currentUser = currentUser.copyWith(
              isEmailVerified: firebaseUser.emailVerified,
            );
            await dbService.saveUserInPreferences(currentUser);
          }
          if (currentUser.isEmailVerified) {
            return AppRouter().goToMain(context);
          }
          return AppRouter().goToVerifyCode(context);
        }

        // await dbService.clear(reloadAppInstanceId: true);

        if (await dbService.hasAlreadySeenOnboarding()) {
          return AppRouter().goToSignIn(context, clearStack: true);
        }

        AppRouter().goToOnboarding(context);
      } catch (error, stackTrace) {
        print("error $error");
        print("stack $stackTrace");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.lgPadding),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
