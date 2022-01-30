import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/constants/asset_images.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/status.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/routing/app_router.dart';
import 'package:yulli/screens/notifications/viewmodels/notification_screen_viewmodel.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/app_bar_ok_button.dart';
import 'package:yulli/widgets/if_else_widget.dart';
import 'package:yulli/widgets/no_data.dart';
import 'package:yulli/widgets/notification_item.dart';
import 'package:yulli/models/notification.dart' as model;

class NotificationScreenBody extends StatefulWidget {
  final RefreshController controller;

  const NotificationScreenBody({
    Key key,
    @required this.controller,
  }) : super(key: key);

  @override
  _NotificationScreenBodyState createState() => _NotificationScreenBodyState();
}

class _NotificationScreenBodyState extends State<NotificationScreenBody> {
  NotificationScreenViewModel _viewModel;
  StreamSubscription _loadingStreamSubscription;
  final MyLogger _logger = MyLogger("_NotificationScreenBodyState");

  void _onNotificationAction(model.Notification notification,
      NotificationItemActionButton actionButton) {
    _viewModel.respondToNotification(
      notification,
      actionButton.isFirst ? Status.closed : Status.done,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _viewModel ??= Provider.of<NotificationScreenViewModel>(context);

    _loadingStreamSubscription ??= _viewModel.loading.listen((event) {
      print('loading $event');
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _viewModel.setAllNotificationsAsRead();
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _loadingStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    return NestedScrollView(
      headerSliverBuilder: (_, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            backgroundColor: Colors.white,
            leading: SizedBox(),
            elevation: 1,
            title: Text(
              localization.screens.notifications,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            forceElevated: true,
            pinned: true,
            actions: <Widget>[
              AppBarOkButton(
                onPressed: () => AppRouter().pop(),
              ),
            ],
            bottom: PreferredSize(
              child: StreamBuilder<bool>(
                stream: _viewModel.loading,
                builder: (_, snapshot) {
                  if (snapshot.hasData && snapshot.data)
                    return LinearProgressIndicator();
                  else
                    return SizedBox();
                },
              ),
              preferredSize: Size.fromHeight(1),
            ),
          ),
        ];
      },
      body: IfElseWidget(
        condition: _viewModel.hasNotification,
        ifWidget: SmartRefresher(
          controller: widget.controller,
          // onRefresh: _onRefresh,
          enablePullDown: false,
          child: ListView.builder(
            itemCount: _viewModel.notifications.length,
            padding: EdgeInsets.symmetric(
              horizontal: AppDimens.mdPadding,
              vertical: AppDimens.padding,
            ),
            itemBuilder: (_, index) {
              final notification = _viewModel.notifications[index];

              return NotificationItem(
                notification: notification,
                onActionPressed: this._onNotificationAction,
              );
            },
          ),
        ),
        elseWidget: NoData(
          text: localization.notices.noNotification,
        ),
      ),
    );
  }
}
