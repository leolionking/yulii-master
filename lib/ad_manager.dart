// import 'dart:io';
// import 'package:firebase_admob/firebase_admob.dart';

// class AdManager {
//   static BannerAd _bannerAd;

//   static BannerAd _createBannerAd() {
//     return BannerAd(
//       adUnitId: BannerAd.testAdUnitId,
//       size: AdSize.banner,
//       targetingInfo: targetingInfo,
//       listener: (MobileAdEvent event) {
//         print("BannerAd event $event");
//       },
//     );
//   }

//   static void showBannerAd(double anchorOffset) {
//     // if (_bannerAd == null) _bannerAd = _createBannerAd();
//     // _bannerAd
//     //   ..load()
//     //   ..show(
//     //     anchorOffset: anchorOffset ?? 0.0,
//     //     anchorType: AnchorType.bottom,
//     //   );
//   }

//   static void hideBannerAd() async {
//     // await _bannerAd?.dispose();
//     // _bannerAd = null;
//   }

//   static String get appId {
//     if (Platform.isAndroid) {
//       return "ca-app-pub-2143291677808718~5687067689";
//     } else if (Platform.isIOS) {
//       return "ca-app-pub-2143291677808718~1021394901";
//     } else {
//       throw new UnsupportedError("Unsupported platform");
//     }
//   }

//   static String get bannerAdUnitId {
//     if (Platform.isAndroid) {
//       return "ca-app-pub-3940256099942544/6300978111";
//     } else if (Platform.isIOS) {
//       return "ca-app-pub-3940256099942544/6300978111";
//     } else {
//       throw new UnsupportedError("Unsupported platform");
//     }
//   }

//   static String get interstitialAdUnitId {
//     if (Platform.isAndroid) {
//       return "<YOUR_ANDROID_INTERSTITIAL_AD_UNIT_ID>";
//     } else if (Platform.isIOS) {
//       return "<YOUR_IOS_INTERSTITIAL_AD_UNIT_ID>";
//     } else {
//       throw new UnsupportedError("Unsupported platform");
//     }
//   }

//   static String get rewardedAdUnitId {
//     if (Platform.isAndroid) {
//       return "<YOUR_ANDROID_REWARDED_AD_UNIT_ID>";
//     } else if (Platform.isIOS) {
//       return "<YOUR_IOS_REWARDED_AD_UNIT_ID>";
//     } else {
//       throw new UnsupportedError("Unsupported platform");
//     }
//   }

//   static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//     keywords: <String>['flutterio', 'beautiful apps'],
//     contentUrl: 'https://flutter.io',
//     childDirected: false,
//   );

//   static BannerAd myBanner = BannerAd(
//     adUnitId: bannerAdUnitId,
//     size: AdSize.smartBanner,
//   );
// }
