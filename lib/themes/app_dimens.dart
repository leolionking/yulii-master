import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 414.0 iPhone XR
const double DEVICE_DRAFT_WIDTH = 414.0;

/// 896.0 iPhone XR
const double DEVICE_DRAFT_HEIGHT = 896.0;

enum DeviceScreenType {
  /// 320 x 569
  smallPhone,

  /// 360 x 740
  mediumPhone,

  /// 480 x 853
  largePhone,

  /// 600 x 960
  smallTablet,

  /// 800 x 1280
  mediumTablet,

  /// 1024 x 1336
  largeTablet
}

class _DeviceScreenTypeHelper {
  static List<double> rangeWidth(DeviceScreenType screenType) {
    switch (screenType) {
      case DeviceScreenType.mediumPhone:
        return [360, 480];
      case DeviceScreenType.largePhone:
        return [480, 600];
      case DeviceScreenType.smallTablet:
        return [600, 800];
      case DeviceScreenType.mediumTablet:
        return [800, 1024];
      case DeviceScreenType.largeTablet:
        return [1024, double.maxFinite];
      default:
        return [0, 360];
    }
  }
}

class AppDimens {
  final BuildContext context;
  final Orientation orientation;
  final DeviceScreenType screenType;
  final Size screenSize;

  /// 4.0
  static const double xsPadding = 4.0;

  /// 6.0
  static const double nxsPadding = 6.0;

  /// 8.0
  static const double smPadding = 8.0;

  static const double nsmPadding = 12.0;

  /// 16.0
  static const double padding = 16.0;

  /// 20.0
  static const double npadding = 20.0;

  /// 24.0
  static const double mdPadding = 24.0;

  /// 32.0
  static const double lgPadding = 32.0;

  /// 40.0
  static const double nlgPadding = 40.0;

  /// 48.0
  static const double xlPadding = 48.0;

  /// 64.0
  static const double xxlPadding = 64.0;

  /// 96
  static const double xlPaddingDouble = 96.0;

  /// 128.0
  static const double xxlPaddingDouble = 128.0;

  /// 16.0
  static const double defaultTextSize = 16.0;

  /// 14.0
  static const double signInputTextSize = 14.0;

  /// 44.0
  static const double buttonMinHeight = 44.0;

  static const double buttonMinHeightSM = 38.0;

  static const double chatListItemAvatarSize = 56.0;

  static const double chatListItemHeight = chatListItemAvatarSize + padding * 2;

  AppDimens(this.context)
      : orientation = MediaQuery.of(context).orientation,
        screenType = _getDeviceScreenType(MediaQuery.of(context)),
        screenSize = MediaQuery.of(context).size;

  double getSizeByScreenType(Map<DeviceScreenType, double> map,
      {double defaultValue = 0.0}) {
    if (map.containsKey(screenType)) {
      return map[screenType];
    }
    return defaultValue;
  }

  static double getScalableHeight(double value) =>
      ScreenUtil().setHeight(value);
  static double getScalableWidth(double value) => ScreenUtil().setWidth(value);

  bool atLeast(DeviceScreenType screenType) {
    final range = _DeviceScreenTypeHelper.rangeWidth(screenType);
    final deviceWidth = screenSize.width;

    return range[0] < deviceWidth && range[1] >= deviceWidth;
  }

  bool get isAtLeastMediumVariant1 =>
      screenType == DeviceScreenType.mediumPhone && screenSize.height < 812.0;
  bool get isAtLeastMediumVariant2 =>
      screenType == DeviceScreenType.mediumPhone && screenSize.height >= 812.0;
  bool get isAtLeastMediumVariant3 =>
      screenType == DeviceScreenType.mediumPhone && screenSize.height >= 896.0;

  double get statusBarHeight => MediaQuery.of(context).padding.top;

  factory AppDimens.of(BuildContext context) => AppDimens(context);

  static DeviceScreenType _getDeviceScreenType(MediaQueryData mediaQuery) {
    var orientation = mediaQuery.orientation;
    double deviceWidth = 0;

    if (orientation == Orientation.landscape) {
      deviceWidth = mediaQuery.size.height;
    } else {
      deviceWidth = mediaQuery.size.width;
    }

    if (deviceWidth >= 1024) {
      return DeviceScreenType.largeTablet;
    }
    if (deviceWidth >= 800) {
      return DeviceScreenType.mediumTablet;
    }
    if (deviceWidth >= 600) {
      return DeviceScreenType.smallTablet;
    }
    if (deviceWidth >= 480) {
      return DeviceScreenType.largePhone;
    }
    if (deviceWidth >= 360) {
      return DeviceScreenType.mediumPhone;
    }
    return DeviceScreenType.smallPhone;
  }
}
