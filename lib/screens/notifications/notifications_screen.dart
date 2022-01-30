import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yulli/common/viewmodels/notifications_viewmodel.dart';
import 'package:yulli/screens/notifications/viewmodels/notification_screen_viewmodel.dart';
import 'package:yulli/screens/notifications/widgets/notification_screen_body.dart';
import 'package:yulli/services/db_service.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final RefreshController _controller =
      RefreshController(initialRefresh: false);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<NotificationsViewModel,
        NotificationScreenViewModel>(
      create: (_) => NotificationScreenViewModel(
        dbService: Provider.of<DbService>(context, listen: false),
      ),
      update: (_, notificationsViewModel, notificationScreenViewModel) =>
          notificationScreenViewModel..setViewModel(notificationsViewModel),
      child: Scaffold(
        // backgroundColor: Colors.grey,
        body: NotificationScreenBody(
          controller: _controller,
        ),
      ),
    );
  }
}
