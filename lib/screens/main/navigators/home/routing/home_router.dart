import 'package:fluro_fork/fluro_fork.dart' as fluro;
import 'package:flutter/material.dart';
import 'package:yulli/screens/main/navigators/home/routing/home_route_handlers.dart';
import 'package:yulli/screens/main/navigators/home/routing/home_routes.dart';
import 'package:yulli/widgets/undefined_view.dart';

class HomeRouter {
  static final fluro.Router _router = fluro.Router();
  static final HomeRouter _singleton = HomeRouter._init();

  HomeRouter._init() {
    _configureRoutes();
  }

  factory HomeRouter() => _singleton;

  fluro.Router get router => _router;

  final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey(debugLabel: "HomeRouter");

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  void _configureRoutes() {
    _router.notFoundHandler = fluro.Handler(handlerFunc: (context, _) {
      final path = ModalRoute.of(context).settings?.name;
      return UndefinedView(path: path);
    });

    _router.define(
      HomeRoutes.root,
      handler: HomeRouteHandlers.homeRootPage,
    );
  }
}
