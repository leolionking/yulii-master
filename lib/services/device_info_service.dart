import 'package:package_info/package_info.dart';

class DeviceInfoService {
  PackageInfo _packageInfo;

  Future<PackageInfo> get packageInfo async =>
      _packageInfo ??= (await PackageInfo.fromPlatform());
}
