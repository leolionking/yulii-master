// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_invitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FriendInvitation _$_$_FriendInvitationFromJson(Map<String, dynamic> json) {
  return _$_FriendInvitation(
    sender: json['sender'] as String,
    receiver: json['receiver'] as String,
    status: ModelUtils.statusValueToEnum(json['status'] as String),
    createdAt: ModelUtils.millisecondsToDateTime(json['createdAt'] as int),
    updatedAt: ModelUtils.millisecondsToDateTime(json['updatedAt'] as int),
  );
}

Map<String, dynamic> _$_$_FriendInvitationToJson(
        _$_FriendInvitation instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'receiver': instance.receiver,
      'status': ModelUtils.statusEnumToValue(instance.status),
      'createdAt': ModelUtils.dateTimeToMilliseconds(instance.createdAt),
      'updatedAt': ModelUtils.dateTimeToMilliseconds(instance.updatedAt),
    };
