import 'package:fluro_fork/fluro_fork.dart' as fluro;
import 'package:flutter/material.dart';
import 'package:yulli/abstracts/base_router.dart';
import 'package:yulli/screens/settings/routing/settings_routes.dart';
import 'package:yulli/widgets/undefined_view.dart';

import 'settings_routes_handler.dart';

class SettingsRouter extends BaseRouter {
  static final fluro.Router _router = fluro.Router();
  static final SettingsRouter _singleton = SettingsRouter._init();

  SettingsRouter._init() {
    _configureRoutes();
  }

  factory SettingsRouter() => _singleton;

  fluro.Router get router => _router;

  final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey(debugLabel: "SettingsRouter");

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  Future<void> goToAboutPage(BuildContext context) {
    return router.navigateTo(
      context,
      SettingsRoutes.about,
    );
    // return navigatorKey.currentState.pushNamed(SettingsRoutes.about);
  }

  Future<void> goToAccountSettingsPage() {
    return navigatorKey.currentState.pushNamed(SettingsRoutes.accountSettings);
  }

  Future<void> goToTermsPage() {
    return navigatorKey.currentState.pushNamed(SettingsRoutes.terms);
  }

  Future<void> goToPrivacyPage() {
    return navigatorKey.currentState.pushNamed(SettingsRoutes.privacy);
  }

  Future<void> goToQaPage() {
    return navigatorKey.currentState.pushNamed(SettingsRoutes.qa);
  }

  void _configureRoutes() {
    _router.notFoundHandler = fluro.Handler(handlerFunc: (context, _) {
      final path = ModalRoute.of(context).settings?.name;
      return UndefinedView(path: path);
    });

    _router.define(
      SettingsRoutes.root,
      handler: SettingsRoutesHandler.settingsRootPage,
      // transitionType: TransitionType.native,
    );

    _router.define(
      SettingsRoutes.about,
      handler: SettingsRoutesHandler.aboutPage,
      transitionType: fluro.TransitionType.native,
    );

    _router.define(
      SettingsRoutes.terms,
      handler: SettingsRoutesHandler.termsPage,
      transitionType: fluro.TransitionType.native,
    );

    _router.define(
      SettingsRoutes.privacy,
      handler: SettingsRoutesHandler.privacyPage,
      transitionType: fluro.TransitionType.native,
    );

    _router.define(
      SettingsRoutes.qa,
      handler: SettingsRoutesHandler.qaPage,
      transitionType: fluro.TransitionType.native,
    );

    _router.define(
      SettingsRoutes.accountSettings,
      handler: SettingsRoutesHandler.accountSettingsPage,
      transitionType: fluro.TransitionType.native,
    );
  }
}
