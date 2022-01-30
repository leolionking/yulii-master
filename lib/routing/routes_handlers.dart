import 'package:fluro_fork/fluro_fork.dart';
import 'package:yulli/screens/chat/chat_list_screen.dart';
import 'package:yulli/screens/chat/chat_user_selection_screen.dart';
import 'package:yulli/screens/forgotpassword/forgot_password_screen.dart';
import 'package:yulli/screens/launch/launch_screen.dart';
import 'package:yulli/screens/launch/onboarding_screen.dart';
import 'package:yulli/screens/main/main_screen.dart';
import 'package:yulli/screens/notifications/notifications_screen.dart';
import 'package:yulli/screens/settings/settings_navigator.dart';
import 'package:yulli/screens/signin/signin_screen.dart';
import 'package:yulli/screens/signup/signup_screen.dart';
import 'package:yulli/screens/verifycode/verify_code_screen.dart';
import 'package:yulli/screens/newpassword/new_password_screen.dart';
import 'package:yulli/screens/resetpasswordsent/reset_password_sent_screen.dart';

class RoutesHandlers {
  static final launchScreen = Handler(
    handlerFunc: (_, __) => LaunchScreen(),
  );
  static final onboardingScreen = Handler(
    handlerFunc: (_, params) => OnboardingScreen(
      fromSettings: params.containsKey('from-settings') &&
          params['from-settings'][0]?.toLowerCase() == 'true',
    ),
  );

  static final signUpScreen = Handler(
    handlerFunc: (_, __) => SignUpScreen(),
  );

  static final signInScreen = Handler(
    handlerFunc: (_, __) => SignInScreen(),
  );

  static final forgotPasswordScreen = Handler(
    handlerFunc: (_, __) => ForgotPasswordScreen(),
  );

  static final verifyCodeScreen = Handler(
    handlerFunc: (_, __) => VerifyCodeScreen(),
  );

  static final newPasswordScreen = Handler(
    handlerFunc: (_, __) => NewPasswordScreen(),
  );

  static final mainScreen = Handler(
    handlerFunc: (_, __) => MainScreen(),
  );

  static final notificationsScreen = Handler(
    handlerFunc: (_, __) => NotificationsScreen(),
  );

  static final resetPasswordSent = Handler(
    handlerFunc: (_, __) => ResetPasswordSentScreen(),
  );

  static final settings = Handler(
    handlerFunc: (_, __) => SettingsNavigator(),
  );

  static final chatList = Handler(
    handlerFunc: (_, __) => ChatListScreen(),
  );

  static final chatListSelectUser = Handler(
    handlerFunc: (_, __) => ChatUserSelectionScreen(),
  );
}
