import 'package:fluro_fork/fluro_fork.dart' as fluro;
import 'package:flutter/widgets.dart';
import 'package:yulli/abstracts/base_router.dart';
// import 'package:yulli/ad_manager.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/routing/routes.dart';
import 'package:yulli/routing/routes_handlers.dart';
import 'package:yulli/widgets/undefined_view.dart';

class AppRouter extends BaseRouter {
  static final fluro.Router _router = fluro.Router();
  static final AppRouter _singleton = AppRouter._init();
  bool _isInit = false;

  AppRouter._init();

  factory AppRouter() {
    _singleton._init();
    return _singleton;
  }

  fluro.Router get router => _router;

  final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey(debugLabel: "AppRouter");

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  void _init() {
    if (_isInit) return;
    _configureRoutes();
    _isInit = true;
  }

  Future<void> goToLaunch() {
    return navigatorKey.currentState
        .pushNamedAndRemoveUntil(Routes.launch, (route) => false);
  }

  Future<void> goToOnboarding(BuildContext context,
      {bool fromSettings = false}) {
    return router.navigateTo(
      context,
      "${Routes.onboardingBase}/$fromSettings",
    );
  }

  Future<void> goToSignUp(BuildContext context, {bool clearStack = false}) {
    return router.navigateTo(
      context,
      Routes.signUp,
      clearStack: clearStack,
    );
  }

  Future<void> goToSignIn(BuildContext context, {bool clearStack = false}) {
    return router.navigateTo(
      context,
      Routes.signIn,
      clearStack: clearStack,
    );
  }

  Future<void> goToForgotPassword(BuildContext context,
      {bool clearStack = false}) {
    return router.navigateTo(
      context,
      Routes.forgotPassword,
      clearStack: clearStack,
    );
  }

  Future<void> goToNewPassword(BuildContext context,
      {bool clearStack = false}) {
    return router.navigateTo(
      context,
      Routes.newPassword,
      clearStack: clearStack,
    );
  }

  Future<void> goToVerifyCode(BuildContext context, {bool clearStack = true}) {
    return router.navigateTo(
      context,
      Routes.verifyCode,
      clearStack: clearStack,
    );
  }

  Future<void> goToResetPasswordSent(BuildContext context) {
    return router.navigateTo(
      context,
      Routes.resetPasswordSent,
      replace: true,
    );
  }

  Future<void> goToMain(BuildContext context) {
    return router.navigateTo(
      context,
      Routes.main,
      clearStack: true,
    );
  }

  Future<void> goToNotifications() {
    // AdManager.hideBannerAd();
    return navigatorKey.currentState.pushNamed(Routes.notifications);
  }

  Future<void> goToSettings() {
    // AdManager.hideBannerAd();
    return navigatorKey.currentState.pushNamed(Routes.settings);
  }

  Future<void> goToChatList() {
    // AdManager.hideBannerAd();
    return navigatorKey.currentState.pushNamed(Routes.chatList);
  }

  Future<dynamic> goToChatUserSelection() {
    // AdManager.hideBannerAd();
    return navigatorKey.currentState.pushNamed(Routes.chatSelectUser);
  }

  void _configureRoutes() {
    _router.notFoundHandler = fluro.Handler(handlerFunc: (context, _) {
      final path = ModalRoute.of(context).settings?.name;
      print('here');
      return UndefinedView(path: path);
    });

    _router.define(
      Routes.launch,
      handler: RoutesHandlers.launchScreen,
    );

    _router.define(
      Routes.onboarding,
      handler: RoutesHandlers.onboardingScreen,
    );

    _router.define(
      Routes.signUp,
      handler: RoutesHandlers.signUpScreen,
      transitionType: fluro.TransitionType.native,
    );

    _router.define(
      Routes.signIn,
      handler: RoutesHandlers.signInScreen,
      transitionType: fluro.TransitionType.native,
    );

    _router.define(
      Routes.forgotPassword,
      handler: RoutesHandlers.forgotPasswordScreen,
      transitionType: fluro.TransitionType.native,
    );

    _router.define(
      Routes.verifyCode,
      handler: RoutesHandlers.verifyCodeScreen,
      transitionType: fluro.TransitionType.native,
    );

    _router.define(
      Routes.newPassword,
      handler: RoutesHandlers.newPasswordScreen,
      transitionType: fluro.TransitionType.native,
    );

    _router.define(
      Routes.main,
      handler: RoutesHandlers.mainScreen,
      transitionType: fluro.TransitionType.inFromRight,
    );

    _router.define(
      Routes.resetPasswordSent,
      handler: RoutesHandlers.resetPasswordSent,
      transitionType: fluro.TransitionType.native,
    );

    _router.define(
      Routes.notifications,
      handler: RoutesHandlers.notificationsScreen,
    );

    _router.define(
      Routes.settings,
      handler: RoutesHandlers.settings,
      // transitionType: TransitionType.fadeIn,
    );

    _router.define(
      Routes.chatList,
      handler: RoutesHandlers.chatList,
      // transitionType: TransitionType.fadeIn,
    );

    _router.define(
      Routes.chatSelectUser,
      handler: RoutesHandlers.chatListSelectUser,
      // transitionType: TransitionType.fadeIn,
    );
  }
}
