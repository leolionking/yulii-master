import 'package:flutter/material.dart';
import 'package:yulli/screens/main/navigators/profile/routing/user_profile_navigator_router.dart';
import 'package:yulli/screens/main/navigators/profile/routing/user_profile_navigator_routes.dart';

class UserProfileNavigator extends StatelessWidget {
  const UserProfileNavigator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: UserProfileNavigatorRouter().navigatorKey,
      onGenerateRoute: UserProfileNavigatorRouter().router.generator,
      initialRoute: UserProfileNavigatorRoutes.root,
    );
  }
}
