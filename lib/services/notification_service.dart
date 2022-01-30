import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yulli/abstracts/disposable.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/services/local_notifications_service.dart';

enum NotificationMessageSource {
  normal,
  resume,
  launch,
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  _onMessage(message);
}

void _onMessage(RemoteMessage message) {
  RemoteNotification notification = message.notification;
  Map<String, dynamic> data = message.data;

  if (notification != null) {
    LocalNotificationsService().showNotification(
      notification.title,
      notification.body,
      payload: (data?.containsKey('type') ?? false) && data['type'] == "message"
          ? LocalNotificationsService.MESSAGE_NOTIFICATION_PAYLOAD
          : null,
    );
  }
}

class NotificationService implements Disposable {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final MyLogger _logger = MyLogger("NotificationService");
  final BehaviorSubject<RemoteMessage> _onMessageStreamController =
      BehaviorSubject();
  final BehaviorSubject<Map<String, dynamic>> _onLaunchMessageStreamController =
      BehaviorSubject();
  final BehaviorSubject<Map<String, dynamic>> _onResumeMessageStreamController =
      BehaviorSubject();
  bool _hasPermission = false;
  NotificationSettings _settings;
  bool _isConfigured = false;
  StreamSubscription _onIosSettingsRegisteredSubscription;
  List<StreamSubscription> _streamSubscriptions = [];

  bool get hasPermission =>
      Platform.isAndroid ||
      (Platform.isIOS &&
          _settings?.authorizationStatus == AuthorizationStatus.authorized);

  Stream<RemoteMessage> get onMessage => _onMessageStreamController.distinct();

  Stream<Map<String, dynamic>> get onLaunchMessage =>
      _onLaunchMessageStreamController.distinct();

  Stream<Map<String, dynamic>> get onResumeMessage =>
      _onResumeMessageStreamController.distinct();

  Stream<String> get onFcmTokenRefresh => _firebaseMessaging.onTokenRefresh;

  Future<String> get fcmToken => _firebaseMessaging.getToken();

  Future<void> init() async {
    await _firebaseMessaging.setAutoInitEnabled(true);
    _settings = await _firebaseMessaging.requestPermission();
    if (!_isConfigured) {
      final subscriptions = [
        onMessage.listen(_onMessage),
      ];
      _streamSubscriptions.addAll(subscriptions);
      _configure();
    }
  }

  void _configure() {
    FirebaseMessaging.onMessage.listen((event) {
      _logger.d("onMessage: $event");
      _onMessageStreamController.add(event);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // _firebaseMessaging.configure(
    //   onMessage: (message) async {
    //     _logger.d("onMessage: $message");
    //     _onMessageStreamController.add(message);
    //   },
    //   onLaunch: (message) async {
    //     _logger.d("onLaunch: $message");
    //     _onLaunchMessageStreamController.add(message);
    //   },
    //   onResume: (message) async {
    //     _logger.d("onResume: $message");
    //     _onResumeMessageStreamController.add(message);
    //   },
    // );
    _isConfigured = true;
  }

  Future<void> logout() async {
    await _firebaseMessaging.setAutoInitEnabled(false);
    await _firebaseMessaging.deleteToken();
  }

  @override
  void dispose() {
    _onMessageStreamController?.close();
    _onLaunchMessageStreamController?.close();
    _onResumeMessageStreamController?.close();
    _onIosSettingsRegisteredSubscription?.cancel();
    _streamSubscriptions.forEach((element) {
      element.cancel();
    });
  }
}
