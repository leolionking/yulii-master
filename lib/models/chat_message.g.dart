// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatMessage _$_$_ChatMessageFromJson(Map<String, dynamic> json) {
  return _$_ChatMessage(
    type: _ChatMessageTypeHelper.stringToEnum(json['type'] as String),
    chatId: json['chatId'] as String,
    participantsIds:
        (json['participantsIds'] as List)?.map((e) => e as String)?.toList(),
    senderId: json['senderId'] as String,
    receiverId: json['receiverId'] as String,
    createdAt: ModelUtils.millisecondsToDateTime(json['createdAt'] as int),
    deletedAt: ModelUtils.millisecondsToDateTime(json['deletedAt'] as int),
    content: json['content'] as String,
    remoteId: json['remoteId'] as String,
    file: ModelUtils.mapToUploadedFile(json['file'] as Map<String, dynamic>),
    read: json['read'] as bool ?? false,
  );
}

Map<String, dynamic> _$_$_ChatMessageToJson(_$_ChatMessage instance) =>
    <String, dynamic>{
      'type': _ChatMessageTypeHelper.enumToString(instance.type),
      'chatId': instance.chatId,
      'participantsIds': instance.participantsIds,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'createdAt': ModelUtils.dateTimeToMilliseconds(instance.createdAt),
      'deletedAt': ModelUtils.dateTimeToMilliseconds(instance.deletedAt),
      'content': instance.content,
      'remoteId': instance.remoteId,
      'file': ModelUtils.uploadedFileToJson(instance.file),
      'read': instance.read,
    };
