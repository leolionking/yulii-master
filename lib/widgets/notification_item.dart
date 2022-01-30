import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/invitation.dart';
import 'package:yulli/models/notification.dart' as model;
import 'package:yulli/models/status.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/services/app_data.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/themes/app_text_styles.dart';
import 'package:yulli/utils/models_utils.dart';

enum NotificationItemActionButton {
  first,
  second,
}

extension NotificationItemActionButtonExtension
    on NotificationItemActionButton {
  bool get isFirst => this == NotificationItemActionButton.first;
}

class NotificationItem extends StatelessWidget {
  final model.Notification notification;
  final Function(model.Notification, NotificationItemActionButton)
      onActionPressed;

  const NotificationItem({
    Key key,
    @required this.notification,
    @required this.onActionPressed,
  })  : assert(notification != null),
        super(key: key);

  Color _getNotificationColor(model.Notification notification) {
    switch (notification.type) {
      case model.NotificationType.taskCreated:
      case model.NotificationType.goalCreated:
        return AppColors.primary;

      case model.NotificationType.taskStatusChanged:
        final itemStatus =
            ModelUtils.statusValueToEnum(notification.data['itemStatus']);

        if (itemStatus == Status.done) {
          return AppColors.success;
        }
        return AppColors.secondary;
      case model.NotificationType.invitation:
        return AppColors.grey;
      default:
        return AppColors.secondary;
    }
  }

  String _getNotificationText(
      model.Notification notification, BuildContext context) {
    final localization = AppLocalization.of(context);
    final dbService = Provider.of<DbService>(context, listen: false);

    MyLogger.debug(
        message: notification.data.toString(), tag: "NotificationItem");

    switch (notification.type) {
      case model.NotificationType.invitation:
        return localization.notifications.invitation(
          user: Invitation.fromJson(notification.data).senderName,
        );
      case model.NotificationType.taskDeclined:
        return localization.notifications.declinedDeal(
          name: notification.data['senderName'],
          title: notification.data['itemName'],
        );
      case model.NotificationType.invitationAccepted:
        return localization.notifications.invitationAccepted(
          user: Invitation.fromJson(notification.data).senderName,
        );
      case model.NotificationType.taskCreated:
        return localization.notifications
            .newDeal(taskName: notification.data['itemName']);
      case model.NotificationType.goalCreated:
        if (notification.data.containsKey('isMystery') &&
            notification.data['isMystery']) {
          return localization.notifications.assignedMysteryDeal(
            name: notification.data['senderName'],
          );
        }
        return localization.notifications.assignedDeal(
          name: notification.data['senderName'],
          title: notification.data['itemName'],
        );
      case model.NotificationType.newMessage:
        return localization.notifications.newMessage(
          user: notification.data['senderName'],
        );
      case model.NotificationType.goalSuggested:
        return localization.notifications.suggestedDeal(
          name: notification.data['senderName'],
          title: notification.data['itemName'],
        );
      case model.NotificationType.goalClaimed:
        return localization.notifications.claimReward(
          name: notification.data['senderName'],
          goalName: notification.data['itemName'],
        );
      case model.NotificationType.taskStatusChanged:
        final itemStatus =
            ModelUtils.statusValueToEnum(notification.data['itemStatus']);

        switch (itemStatus) {
          case Status.pending:
            return localization.notifications.validationRequestDeal(
              name: notification.data['senderName'],
              title: notification.data['itemName'],
            );
          // case Status.declined:
          //   return localization.notifications.declinedDeal(
          //     name: notification.data['senderName'],
          //     title: notification.data['itemName'],
          //   );
          case Status.done:
            return localization.notifications.approvedDeal(
              name: notification.data['senderName'],
              title: notification.data['itemName'],
            );
          default:
            return "";
        }
    }
    return null;
  }

  Widget _getNotificationRichText(
      model.Notification notification, BuildContext context) {}

  bool _hasActionButton(model.Notification notification) {
    switch (notification.type) {
      case model.NotificationType.invitation:
        return notification.status == Status.pending;
      case model.NotificationType.goalSuggested:
        return notification.status.isPending;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Container(
      padding: const EdgeInsets.only(
        top: AppDimens.padding,
        left: AppDimens.padding,
        right: AppDimens.padding,
      ),
      margin: const EdgeInsets.only(
        bottom: AppDimens.nsmPadding,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: _getNotificationColor(notification),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            _getNotificationText(notification, context),
            style: AppTextStyles.of(context).notificationItem,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: AppDimens.smPadding,
          ),
          _hasActionButton(notification)
              ? Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppDimens.smPadding,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          onActionPressed?.call(
                            notification,
                            NotificationItemActionButton.first,
                          );
                        },
                        child: Text(localization.actions.ignore),
                      ),
                      SizedBox(
                        width: AppDimens.smPadding,
                      ),
                      FlatButton(
                        onPressed: () {
                          onActionPressed?.call(
                            notification,
                            NotificationItemActionButton.second,
                          );
                        },
                        padding: EdgeInsets.zero,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        child: Text(localization.actions.accept),
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  height: AppDimens.padding,
                ),
        ],
      ),
    );
  }
}
