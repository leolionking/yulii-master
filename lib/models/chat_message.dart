import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yulli/models/uploaded_file.dart';
import 'package:yulli/utils/models_utils.dart';
import 'package:flutter/foundation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

enum ChatMessageType {
  text,
  video,
  image,
  deleted,
}

class _ChatMessageTypeHelper {
  static String enumToString(ChatMessageType type) {
    switch (type) {
      case ChatMessageType.text:
        return "text";
      case ChatMessageType.video:
        return "video";
      case ChatMessageType.image:
        return "image";
      case ChatMessageType.deleted:
        return "deleted";
    }
    return null;
  }

  static ChatMessageType stringToEnum(String value) {
    switch (value) {
      case "text":
        return ChatMessageType.text;
      case "video":
        return ChatMessageType.video;
      case "image":
        return ChatMessageType.image;
      case "deleted":
        return ChatMessageType.deleted;
    }
    return null;
  }
}

@freezed
abstract class ChatMessage with _$ChatMessage {
  factory ChatMessage({
    @JsonKey(
      fromJson: _ChatMessageTypeHelper.stringToEnum,
      toJson: _ChatMessageTypeHelper.enumToString,
    )
    @required
        ChatMessageType type,
    @nullable
        String chatId,
    @nullable
        List<String> participantsIds,
    String senderId,
    String receiverId,
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
    @nullable
        DateTime deletedAt,
    @nullable
        String content,
    @nullable
        String remoteId,
    @JsonKey(
      fromJson: ModelUtils.mapToUploadedFile,
      toJson: ModelUtils.uploadedFileToJson,
    )
    @nullable
        UploadedFile file,
    @Default(false)
        bool read,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}
