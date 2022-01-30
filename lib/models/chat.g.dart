// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Chat _$_$_ChatFromJson(Map<String, dynamic> json) {
  return _$_Chat(
    participantsIds:
        (json['participantsIds'] as List)?.map((e) => e as String)?.toList(),
    participants: (json['participants'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    createdAt: ModelUtils.millisecondsToDateTime(json['createdAt'] as int),
    updatedAt: ModelUtils.millisecondsToDateTime(json['updatedAt'] as int),
    lastMessage: json['lastMessage'] == null
        ? null
        : ChatMessage.fromJson(json['lastMessage'] as Map<String, dynamic>),
    remoteId: json['remoteId'] as String,
  );
}

Map<String, dynamic> _$_$_ChatToJson(_$_Chat instance) => <String, dynamic>{
      'participantsIds': instance.participantsIds,
      'participants': instance.participants,
      'createdAt': ModelUtils.dateTimeToMilliseconds(instance.createdAt),
      'updatedAt': ModelUtils.dateTimeToMilliseconds(instance.updatedAt),
      'lastMessage': instance.lastMessage,
      'remoteId': instance.remoteId,
    };
