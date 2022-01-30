import 'package:fluro_fork/fluro_fork.dart' as fluro;
import 'package:flutter/material.dart';
import 'package:yulli/screens/main/routing/bottom_navigation_route_handlers.dart';
import 'package:yulli/screens/main/routing/bottom_navigation_routes.dart';
import 'package:yulli/screens/main/routing/bottom_navigation_routes_observer.dart';
import 'package:yulli/widgets/undefined_view.dart';

class BottomNavigationRouter {
  static final fluro.Router _router = fluro.Router();
  static final BottomNavigationRouter _singleton =
      BottomNavigationRouter._init();

  BottomNavigationRouter._init() {
    _configureRoutes();
  }

  factory BottomNavigationRouter() => _singleton;

  final BottomNavigationRoutesObserver observer =
      BottomNavigationRoutesObserver();

  fluro.Router get router => _router;

  final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "BottomNavigationRouter");

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  Future<void> goToHome() {
    return navigatorKey.currentState
        .pushReplacementNamed(BottomNavigationRoutes.home);
  }

  Future<void> goToTasks() {
    return navigatorKey.currentState
        .pushReplacementNamed(BottomNavigationRoutes.tasks);
  }

  Future<void> goToGoals() {
    return navigatorKey.currentState
        .pushReplacementNamed(BottomNavigationRoutes.goals);
  }

  Future<void> goToProfile() {
    return navigatorKey.currentState
        .pushReplacementNamed(BottomNavigationRoutes.profile);
  }

  void _configureRoutes() {
    _router.notFoundHandler = fluro.Handler(handlerFunc: (context, _) {
      final path = ModalRoute.of(context).settings?.name;
      return UndefinedView(path: path);
    });

    _router.define(
      BottomNavigationRoutes.home,
      handler: BottomNavigationRouteHandlers.homeNavigator,
      transitionType: fluro.TransitionType.fadeIn,
    );

    _router.define(
      BottomNavigationRoutes.tasks,
      handler: BottomNavigationRouteHandlers.tasksNavigator,
      transitionType: fluro.TransitionType.fadeIn,
    );

    _router.define(
      BottomNavigationRoutes.goals,
      handler: BottomNavigationRouteHandlers.goalsNavigator,
      transitionType: fluro.TransitionType.fadeIn,
    );

    _router.define(
      BottomNavigationRoutes.profile,
      handler: BottomNavigationRouteHandlers.profileNavigator,
      transitionType: fluro.TransitionType.fadeIn,
    );
  }
}
