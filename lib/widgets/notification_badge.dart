import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/common/viewmodels/notifications_viewmodel.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/routing/app_router.dart';

class NotificationBadge extends StatelessWidget {
  const NotificationBadge({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Selector<NotificationsViewModel, int>(
      builder: (_, readCount, child) {
        return IconButton(
          tooltip: localization.screens.notifications,
          onPressed: () => AppRouter().goToNotifications(),
          icon: Badge(
            showBadge: readCount > 0,
            animationType: BadgeAnimationType.scale,
            badgeContent: Text(
              "$readCount",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                height: 1,
              ),
            ),
            child: child,
          ),
        );
      },
      selector: (_, _viewModel) => _viewModel.unreadNotitificationsCount,
      child: Icon(
        Icons.notifications_none,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
