// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Invitation _$_$_InvitationFromJson(Map<String, dynamic> json) {
  return _$_Invitation(
    sender: json['sender'] as String,
    senderName: json['senderName'] as String,
    receiverName: json['receiverName'] as String,
  );
}

Map<String, dynamic> _$_$_InvitationToJson(_$_Invitation instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'senderName': instance.senderName,
      'receiverName': instance.receiverName,
    };
