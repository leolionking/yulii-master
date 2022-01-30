import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:yulli/common/viewmodels/add_friend_viewmodel.dart';
import 'package:yulli/common/viewmodels/app_language_viewmodel.dart';
import 'package:yulli/common/viewmodels/chat_viewmodel.dart';
import 'package:yulli/common/viewmodels/friends_viewmodel.dart';
import 'package:yulli/common/viewmodels/main_components_view_model.dart';
import 'package:yulli/common/viewmodels/notifications_viewmodel.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/services/app_data.dart';
import 'package:yulli/services/auth_service.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/services/device_info.dart';
import 'package:yulli/services/file_storage_service.dart';
import 'package:yulli/services/goals_service.dart';
import 'package:yulli/services/notification_service.dart';
import 'package:yulli/services/connectivity_service.dart';
import 'package:yulli/services/tasks_service.dart';

List<SingleChildWidget> providers = [
  ..._indepentServices,
  ..._dependentServices,
  ..._viewModelDependencies,
];

List<SingleChildWidget> _indepentServices = [
  Provider(
    create: (_) => DeviceInfo(),
  ),
  Provider<NotificationService>(
    create: (_) => NotificationService(),
    dispose: (_, _service) => _service.dispose(),
  ),
  Provider<FileStorageService>(
    create: (_) => FileStorageService(),
    dispose: (_, _service) => _service.dispose(),
  ),
  ChangeNotifierProvider<AppLanguageViewModel>(
    create: (_) => AppLanguageViewModel(),
  ),
  ChangeNotifierProvider<ConnectivityService>(
    create: (_) => ConnectivityService(),
  ),
];
List<SingleChildWidget> _dependentServices = [
  ProxyProvider4<DeviceInfo, NotificationService, ConnectivityService,
      AppLanguageViewModel, DbService>(
    lazy: false,
    update: (_, deviceInfo, notificationService, connectivityService,
            appLanguageVM, __) =>
        __ ??
        DbService(
          notificationService: notificationService,
          deviceInfo: deviceInfo,
          connectivityService: connectivityService,
          appLanguageViewModel: appLanguageVM,
        ),
  ),
  ProxyProvider2<DbService, NotificationService, AuthService>(
    update: (_, dbService, notificationService, __) => AuthService(
      dbService: dbService,
      notificationService: notificationService,
    ),
  ),
  ChangeNotifierProxyProvider3<DbService, DeviceInfo, FileStorageService,
      AppDataService>(
    update: (_, dbService, deviceInfo, fileStorage, appDataService) =>
        appDataService
          ..setDbService(dbService)
          ..setDeviceInfo(deviceInfo)
          ..setFileStorageService(fileStorage),
    create: (_) => AppDataService(),
  ),
  ChangeNotifierProxyProvider<DbService, NotificationsViewModel>(
    create: (_) => NotificationsViewModel(),
    update: (_, dbService, notificationsViewModel) =>
        notificationsViewModel..setDbService(dbService),
  ),
  ProxyProvider<DbService, GoalsService>(
    create: (_) => GoalsService(),
    update: (_, dbService, goalsService) => goalsService.setDependencies(
      dbService: dbService,
    ),
    dispose: (_, goalsService) => goalsService.dispose(),
  ),
  ProxyProvider<DbService, TasksService>(
    create: (_) => TasksService(),
    update: (_, dbService, tasksService) => tasksService.setDependencies(
      dbService: dbService,
    ),
    dispose: (_, tasksService) => tasksService.dispose(),
  ),
];

List<SingleChildWidget> _viewModelDependencies = [
  ChangeNotifierProxyProvider<DbService, FriendsViewModel>(
    create: (_) => FriendsViewModel(),
    update: (_, dbService, friendsViewModel) => friendsViewModel
      ..setDependencies(
        dbService: dbService,
      ),
  ),
  ChangeNotifierProxyProvider<DbService, ChatViewModel>(
    create: (_) => ChatViewModel(),
    update: (_, dbService, chatViewModel) => chatViewModel
      ..setDependencies(
        dbService: dbService,
      ),
  ),
  ChangeNotifierProvider<MainComponentViewModel>(
    create: (_) => MainComponentViewModel(),
  ),
];
