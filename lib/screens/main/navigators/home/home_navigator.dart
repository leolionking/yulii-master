import 'package:flutter/material.dart';
import 'package:yulli/screens/main/navigators/home/routing/home_router.dart';
import 'package:yulli/screens/main/navigators/home/routing/home_routes.dart';

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: HomeRouter().navigatorKey,
      initialRoute: HomeRoutes.root,
      onGenerateRoute: HomeRouter().router.generator,
    );
  }
}
