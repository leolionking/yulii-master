import 'package:fluro_fork/fluro_fork.dart' as fluro;
import 'package:flutter/material.dart';
import 'package:yulli/screens/main/navigators/goals/routing/goals_routes.dart';
import 'package:yulli/screens/main/navigators/goals/routing/goals_routes_handlers.dart';
import 'package:yulli/widgets/undefined_view.dart';

class GoalsRouter {
  static final fluro.Router _router = fluro.Router();
  static final GoalsRouter _singleton = GoalsRouter._init();

  GoalsRouter._init() {
    _configureRoutes();
  }

  factory GoalsRouter() => _singleton;

  fluro.Router get router => _router;

  final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey(debugLabel: "GoalsRouter");

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  void _configureRoutes() {
    _router.notFoundHandler = fluro.Handler(handlerFunc: (context, _) {
      final path = ModalRoute.of(context).settings?.name;
      return UndefinedView(path: path);
    });

    _router.define(
      GoalsRoutes.root,
      handler: GoalsRoutesHandler.goalsRootPage,
    );
  }
}
