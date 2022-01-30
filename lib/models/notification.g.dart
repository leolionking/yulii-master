// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Notification _$_$_NotificationFromJson(Map<String, dynamic> json) {
  return _$_Notification(
    receiver: json['receiver'] as String,
    type: _NotificationTypeHelper.stringToEnum(json['type'] as String),
    data: json['data'] as Map<String, dynamic>,
    createdAt: ModelUtils.millisecondsToDateTime(json['createdAt'] as int),
    updatedAt: ModelUtils.millisecondsToDateTime(json['updatedAt'] as int),
    status: ModelUtils.statusValueToEnum(json['status'] as String),
    read: json['read'] as bool,
    remoteId: json['remoteId'] as String,
  );
}

Map<String, dynamic> _$_$_NotificationToJson(_$_Notification instance) =>
    <String, dynamic>{
      'receiver': instance.receiver,
      'type': _NotificationTypeHelper.enumToString(instance.type),
      'data': instance.data,
      'createdAt': ModelUtils.dateTimeToMilliseconds(instance.createdAt),
      'updatedAt': ModelUtils.dateTimeToMilliseconds(instance.updatedAt),
      'status': ModelUtils.statusEnumToValue(instance.status),
      'read': instance.read,
      'remoteId': instance.remoteId,
    };
