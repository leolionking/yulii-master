import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yulli/common/utils/focus_node_utils.dart';
import 'package:yulli/common/viewmodels/app_language_viewmodel.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/provider_setup.dart';
import 'package:yulli/routing/app_router.dart';
import 'package:yulli/routing/routes.dart';
import 'package:yulli/screens/main/routing/bottom_navigation_router.dart';

import 'package:yulli/themes/app_theme.dart';

class YulliApp extends StatefulWidget {
  const YulliApp({Key key}) : super(key: key);

  @override
  _YulliAppState createState() => _YulliAppState();
}

class _YulliAppState extends State<YulliApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    BottomNavigationRouter().observer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...providers,
      ],
      child: Consumer<AppLanguageViewModel>(
        builder: (context, appLanguageViewModel, __) {
          return RefreshConfiguration(
            headerBuilder: () => ClassicHeader(),
            footerBuilder: () => ClassicFooter(),
            enableScrollWhenRefreshCompleted: true,
            enableLoadingWhenFailed: true,
            hideFooterWhenNotFull: false,
            enableBallisticLoad: true,
            maxOverScrollExtent: 100,
            maxUnderScrollExtent: 100,
            headerTriggerDistance: 100.0,
            footerTriggerDistance: 100.0,
            springDescription: SpringDescription(
              stiffness: 170,
              damping: 16,
              mass: 1.9,
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusNodeUtils.unfocusAll();
              },
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                locale: kReleaseMode
                    ? appLanguageViewModel.locale
                    : DevicePreview.locale(context),
                localizationsDelegates: [
                  const AppLocalizationDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  RefreshLocalizations.delegate,
                ],
                supportedLocales: AppLocalization.languages.keys.toList(),
                theme: AppTheme.lightTheme,
                builder: DevicePreview.appBuilder,
                onGenerateRoute: AppRouter().router.generator,
                navigatorKey: AppRouter().navigatorKey,
                initialRoute: Routes.launch,
              ),
            ),
          );
        },
      ),
    );
  }
}
