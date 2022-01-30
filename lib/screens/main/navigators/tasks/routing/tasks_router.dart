import 'package:fluro_fork/fluro_fork.dart' as fluro;
import 'package:flutter/material.dart';
import 'package:yulli/screens/main/navigators/tasks/routing/tasks_routes.dart';
import 'package:yulli/screens/main/navigators/tasks/routing/tasks_routes_handlers.dart';
import 'package:yulli/widgets/undefined_view.dart';

class TasksRouter {
  static final fluro.Router _router = fluro.Router();
  static final TasksRouter _singleton = TasksRouter._init();

  TasksRouter._init() {
    _configureRoutes();
  }

  factory TasksRouter() => _singleton;

  fluro.Router get router => _router;

  final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey(debugLabel: "TasksRouter");

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  void _configureRoutes() {
    _router.notFoundHandler = fluro.Handler(handlerFunc: (context, _) {
      final path = ModalRoute.of(context).settings?.name;
      return UndefinedView(path: path);
    });

    _router.define(
      TasksRoutes.root,
      handler: TasksRoutesHandlers.tasksRootPage,
    );
  }
}
