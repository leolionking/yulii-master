import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/common/viewmodels/notifications_viewmodel.dart';
import 'package:yulli/models/status.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/models/notification.dart' as model;

class NotificationScreenViewModel extends ChangeNotifier {
  final DbService dbService;
  final MyLogger _logger = MyLogger("NotificationScreenViewModel");
  NotificationsViewModel _notificationsViewModel;

  final BehaviorSubject<bool> _loadingStreamSubject = BehaviorSubject();

  NotificationScreenViewModel({
    @required this.dbService,
  }) : assert(dbService != null);

  void setViewModel(NotificationsViewModel viewModel) {
    _logger.d("setting viewmodel...");
    _notificationsViewModel = viewModel;
    notifyListeners();
  }

  List<model.Notification> get notifications =>
      _notificationsViewModel?.notifications ?? [];
  bool get hasNotification => notifications.isNotEmpty;
  Stream<bool> get loading => _loadingStreamSubject.distinct();

  void setLoading(bool loading) {
    _loadingStreamSubject.add(loading);
  }

  Future<void> respondToNotification(
      model.Notification notification, Status status) async {
    setLoading(true);
    switch (notification.type) {
      // case model.NotificationType.taskCreated:
      //   _logger.d('here');
      //   if (status.isClosed) {
      //     await dbService.updateTaskStatusByTaskId(
      //       notification.data['itemId'],
      //       Status.declined,
      //     );
      //   } else if (status.isDone) {
      //     await dbService.updateTaskStatusByTaskId(
      //       notification.data['itemId'],
      //       Status.pending,
      //     );
      //   }
      //   break;
      case model.NotificationType.invitation:
        await dbService.sendInvitationResponse(
          notification.data['itemId'],
          status,
        );
        await dbService.updateNotificationStatus(notification, status);
        break;
      case model.NotificationType.goalSuggested:
        await dbService.openGoal(notification.data['itemId']);
        await dbService.updateNotificationStatus(notification, status);
        break;
      default:
    }
    // await dbService.updateNotificationStatus(notification, status);
    setLoading(false);
  }

  Future<void> setAllNotificationsAsRead() async {
    await dbService.setAllNotificationsAsRead(notifications);
  }

  @override
  void dispose() {
    _loadingStreamSubject.close();
    super.dispose();
  }
}
