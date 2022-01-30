import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';

class DeviceInfo {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  PackageInfo _packageInfo;

  Future<String> get model async {
    if (Platform.isAndroid) {
      return (await deviceInfo.androidInfo).model;
    } else if (Platform.isIOS) {
      return (await deviceInfo.iosInfo).utsname.machine;
    }
    return null;
  }

  Future<String> get appVersion async => (await packageInfo).version;
  Future<String> get appBuildNumber async => (await packageInfo).buildNumber;
  Future<String> get appName async => (await packageInfo).appName;

  Future<PackageInfo> get packageInfo async =>
      _packageInfo ??= (await PackageInfo.fromPlatform());
}
