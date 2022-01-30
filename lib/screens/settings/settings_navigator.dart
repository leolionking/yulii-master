import 'package:flutter/material.dart';

import 'routing/settings_router.dart';
import 'routing/settings_routes.dart';

class SettingsNavigator extends StatelessWidget {
  const SettingsNavigator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (SettingsRouter().canPop()) {
          SettingsRouter().pop();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Navigator(
          key: SettingsRouter().navigatorKey,
          onGenerateRoute: SettingsRouter().router.generator,
          initialRoute: SettingsRoutes.root,
        ),
      ),
    );
  }
}
