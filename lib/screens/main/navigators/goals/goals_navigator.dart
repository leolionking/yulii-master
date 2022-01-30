import 'package:flutter/material.dart';
import 'package:yulli/screens/main/navigators/goals/routing/goals_router.dart';
import 'package:yulli/screens/main/navigators/goals/routing/goals_routes.dart';

class GoalsNavigator extends StatelessWidget {
  const GoalsNavigator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: GoalsRouter().navigatorKey,
      onGenerateRoute: GoalsRouter().router.generator,
      initialRoute: GoalsRoutes.root,
    );
  }
}
