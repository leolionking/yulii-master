import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yulli/models/chat_message.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/utils/models_utils.dart';
import 'package:flutter/foundation.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

@freezed
abstract class Chat with _$Chat {
  factory Chat({
    @required
        List<String> participantsIds,
    @nullable
        List<User> participants,
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
    @nullable
        ChatMessage lastMessage,
    @nullable
        String remoteId,
  }) = _Chat;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}
