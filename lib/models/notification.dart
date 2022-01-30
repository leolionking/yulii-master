import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/models/status.dart';
import 'package:yulli/utils/models_utils.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

enum NotificationType {
  invitation,
  invitationAccepted,
  taskCreated,
  taskStatusChanged,
  taskDeclined,
  goalCreated,
  goalSuggested,
  goalClaimed,
  newMessage,
}

class NotificationTypeValue {
  static const invitation = "invitation";
  static const invitationAccepted = "invitation_accepted";
  static const taskCreated = "task_created";
  static const taskStatusChanged = "task_status_changed";
  static const taskDeclined = "task_declined";
  static const goalCreated = "goal_created";
  static const goalSuggested = "goal_suggested";
  static const goalClaimed = "goal_claimed";
  static const newMessage = "new_message";
}

class _NotificationTypeHelper {
  static String enumToString(NotificationType type) {
    switch (type) {
      case NotificationType.invitation:
        return NotificationTypeValue.invitation;
      case NotificationType.taskCreated:
        return NotificationTypeValue.taskCreated;
      case NotificationType.goalCreated:
        return NotificationTypeValue.goalCreated;
      case NotificationType.goalSuggested:
        return NotificationTypeValue.goalSuggested;
      case NotificationType.goalClaimed:
        return NotificationTypeValue.goalClaimed;
      case NotificationType.taskStatusChanged:
        return NotificationTypeValue.taskStatusChanged;
      case NotificationType.invitationAccepted:
        return NotificationTypeValue.invitationAccepted;
      case NotificationType.newMessage:
        return NotificationTypeValue.newMessage;
      case NotificationType.taskDeclined:
        return NotificationTypeValue.taskDeclined;
    }
    return null;
  }

  static NotificationType stringToEnum(String type) {
    switch (type) {
      case NotificationTypeValue.invitation:
        return NotificationType.invitation;
      case NotificationTypeValue.taskCreated:
        return NotificationType.taskCreated;
      case NotificationTypeValue.goalCreated:
        return NotificationType.goalCreated;
      case NotificationTypeValue.goalSuggested:
        return NotificationType.goalSuggested;
      case NotificationTypeValue.goalClaimed:
        return NotificationType.goalClaimed;
      case NotificationTypeValue.taskStatusChanged:
        return NotificationType.taskStatusChanged;
      case NotificationTypeValue.invitationAccepted:
        return NotificationType.invitationAccepted;
      case NotificationTypeValue.newMessage:
        return NotificationType.newMessage;
      case NotificationTypeValue.taskDeclined:
        return NotificationType.taskDeclined;
    }
    return null;
  }
}

@freezed
abstract class Notification with _$Notification {
  const factory Notification({
    @required
        String receiver,
    @JsonKey(
      fromJson: _NotificationTypeHelper.stringToEnum,
      toJson: _NotificationTypeHelper.enumToString,
    )
    @required
        NotificationType type,
    @required
        Map<String, dynamic> data,
    @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds,
    )
    @required
        DateTime createdAt,
    @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds,
    )
    @required
        DateTime updatedAt,
    @JsonKey(
      fromJson: ModelUtils.statusValueToEnum,
      toJson: ModelUtils.statusEnumToValue,
    )
    @required
        Status status,
    @required
        bool read,
    @nullable
        String remoteId,
  }) = _Notification;

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
}
