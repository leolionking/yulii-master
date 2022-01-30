import 'dart:async';

import 'package:device_preview/device_preview.dart' as dependency;
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yulli/app/app.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/services/local_notifications_service.dart';

import 'ad_manager.dart';

void main() async {
  MyLogger.sWhitelist = [
    'NotificationsViewModel',
    // 'NotificationScreenViewModel',
    // 'NotificationService',
    // 'LocalNotificationsService',
    // 'HomeRootBody',
    // 'HomeRootPageViewModel',
    // 'DbService',
    // 'GoalsService',
    // 'TasksService',
    // 'ChatMessagesViewModel',
    // 'ChatListScreenViewModel',
    // 'FileUtils',
    // 'ChatViewModel',
    // 'AppLanguageViewModel',
    // 'UserProfilePageViewModel',
    // 'AppDataService',
    // 'FileStorageService',
    // 'TaskRootPageBody',
    // 'NotificationItem',
    // '_DialBottomSheetGoalState',
    // '_MembersSelectorState',
    // 'TasksRootViewModel',
  ];
  WidgetsFlutterBinding.ensureInitialized();

  List<Future> configs = [
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]),
  ];

  await Future.wait<dynamic>(configs);

  await Firebase.initializeApp();

  // await FirebaseAdMob.instance.initialize(appId: AdManager.appId);

  runApp(
    dependency.DevicePreview(
      enabled: false,
      builder: (_) => YulliApp(),
    ),
  );
}
