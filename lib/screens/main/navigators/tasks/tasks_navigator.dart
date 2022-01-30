import 'package:flutter/material.dart';
import 'package:yulli/screens/main/navigators/tasks/routing/tasks_router.dart';
import 'package:yulli/screens/main/navigators/tasks/routing/tasks_routes.dart';

class TasksNavigator extends StatelessWidget {
  const TasksNavigator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: TasksRouter().navigatorKey,
      onGenerateRoute: TasksRouter().router.generator,
      initialRoute: TasksRoutes.root,
    );
  }
}
