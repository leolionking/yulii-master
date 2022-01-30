import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/models/notification.dart' as _d;
import 'package:yulli/services/db_service.dart';

class NotificationsViewModel extends ChangeNotifier {
  final MyLogger _logger = MyLogger('NotificationsViewModel');
  DbService _dbService;
  List<_d.Notification> _notifications = [];
  int _unreadNotificationsCount = 0;
  StreamSubscription _querySnapshotStreamSubscription;
  int _queryLimit = 60;
  int _currentOffset = 0;

  List<_d.Notification> get notifications => _notifications;
  int get unreadNotitificationsCount => _unreadNotificationsCount;
  bool get hasUnreadNotification => unreadNotitificationsCount > 0;

  void setDbService(DbService dbService) {
    _dbService = dbService;
    notifyListeners();
  }

  void init() {
    _logger.d("init NotificationsViewModel");
    _refreshListeners();
  }

  void _updateNotifications(List<_d.Notification> notifications) async {
    notifications.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    _logger.d("updating notifications : ${notifications.length}");
    setNotifications(notifications);
  }

  void setNotifications(List<_d.Notification> notifications) {
    _notifications = notifications;
    _unreadNotificationsCount = _getUnreadNotifications(notifications);
    notifyListeners();
    _logger.d("unread notifications : $_unreadNotificationsCount");
    _logger.d("notifications count ${notifications.length}");
  }

  int _getUnreadNotifications(List<_d.Notification> notifications) {
    return notifications.where((element) => !element.read).toList().length;
  }

  void _refreshListeners() async {
    if (_dbService != null) {
      _logger.d("refreshing listeners...");
      await _querySnapshotStreamSubscription?.cancel();

      var queries = await Future.wait([
        // _dbService.sentNotificationsQuery,
        // _dbService.pendingNotificationsQuery,
        _dbService.notClosedNotificationsQuery,
      ]);

      var streams = queries.map((e) => e.limit(_queryLimit).snapshots());

      _querySnapshotStreamSubscription = CombineLatestStream(
        streams,
        (List<QuerySnapshot> querySnapshots) =>
            querySnapshots.fold<List<_d.Notification>>(
          [],
          (previousValue, element) {
            var n = element.docs.map((e) {
              try {
                return _d.Notification.fromJson(e.data())
                    .copyWith(remoteId: e.id);
              } catch (err, s) {
                _logger.e(e.data(), error: err, stackTrace: s);
                throw e;
              }
            }).toList();

            return [...previousValue, ...n];
          },
        ).toList(),
      )
          .debounce((event) => TimerStream(true, Duration(milliseconds: 250)))
          .listen((event) async {
        var notifications = event
            .where((element) => element.type != _d.NotificationType.newMessage)
            .toList();

        for (var i = 0; i < notifications.length; i++) {
          final notification = notifications[i];

          if (notification.type == _d.NotificationType.goalCreated) {
            final isMystery =
                await _dbService.isMysteryGoal(notification.data['itemId']);

            notifications[i].data.putIfAbsent('isMystery', () => isMystery);
          }
        }
        _updateNotifications(notifications);
      });
    }
  }

  @override
  void dispose() {
    _querySnapshotStreamSubscription?.cancel();
    super.dispose();
  }
}
