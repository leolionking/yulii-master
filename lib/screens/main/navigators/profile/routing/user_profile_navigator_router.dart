import 'package:fluro_fork/fluro_fork.dart' as fluro;
import 'package:flutter/material.dart';
import 'package:yulli/screens/main/navigators/profile/routing/user_profile_navigator_route_handler.dart';
import 'package:yulli/screens/main/navigators/profile/routing/user_profile_navigator_routes.dart';
import 'package:yulli/widgets/undefined_view.dart';

class UserProfileNavigatorRouter {
  static final fluro.Router _router = fluro.Router();
  static final UserProfileNavigatorRouter _singleton =
      UserProfileNavigatorRouter._init();

  UserProfileNavigatorRouter._init() {
    _configureRoutes();
  }

  factory UserProfileNavigatorRouter() => _singleton;

  final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey(debugLabel: "UserProfileNavigatorRouter");

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  fluro.Router get router => _router;

  void _configureRoutes() {
    _router.notFoundHandler = fluro.Handler(handlerFunc: (context, _) {
      final path = ModalRoute.of(context).settings?.name;
      return UndefinedView(path: path);
    });

    _router.define(
      UserProfileNavigatorRoutes.root,
      handler: UserProfileNavigatorRouteHandlers.rootPage,
    );
  }
}
