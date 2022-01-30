import 'package:flutter/foundation.dart';

class AppInfo {
  final String appName;
  final String appVersion;

  const AppInfo({
    @required this.appName,
    @required this.appVersion,
  });

  String get nameAndVersion => "$appName version $appVersion";
}
