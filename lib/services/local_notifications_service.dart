import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/routing/app_router.dart';
import 'package:yulli/services/db_service.dart';

class LocalNotificationsService {
  final MyLogger _logger = MyLogger("LocalNotificationsService");
  static final LocalNotificationsService _singleton =
      LocalNotificationsService._init();
  bool _isInit = false;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  DbService _dbService;

  static const CHANNEL_ID = "com.yulii.yulii_mobile.notifications.base";
  static const CHANNEL_NAME = "Yulii";
  static const CHANNEL_DESCRIPTION = "Yulii's Notifications";
  static const DEFAULT_ID = 0;
  static const MESSAGE_NOTIFICATION_PAYLOAD =
      "com.yulii.yulii_mobile.notifications.message";

  LocalNotificationsService._init();

  factory LocalNotificationsService() => _singleton;

  Future<void> init(DbService dbService) async {
    if (_isInit) return;
    await _init(dbService);
    _isInit = true;
  }

  Future<void> _init(DbService dbService) async {
    _dbService = dbService;

    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: _onSelectNotification,
    );
  }

  Future<void> checkIfAppHasBeenOpenedFromNotification() async {
    final NotificationAppLaunchDetails notificationAppLaunchDetails =
        await _localNotificationsPlugin.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails.didNotificationLaunchApp) {
      await _onSelectNotification(notificationAppLaunchDetails.payload);
    }
  }

  Future _onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {}

  Future _onSelectNotification(String payload) async {
    _logger.d("payload: $payload");
    var currentUser = await _dbService.getCurrentUser();
    if (currentUser.isValid && currentUser.isEmailVerified) {
      if (payload == MESSAGE_NOTIFICATION_PAYLOAD) {
        return AppRouter().goToChatList();
      }
      AppRouter().goToNotifications();
    }
  }

  void showNotification(String title, String content, {String payload}) async {
    _logger.d("showing notification...");
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      CHANNEL_ID,
      CHANNEL_NAME,
      CHANNEL_DESCRIPTION,
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _localNotificationsPlugin.show(
      DEFAULT_ID,
      title,
      content,
      platformChannelSpecifics,
      payload: payload,
    );
  }
}
