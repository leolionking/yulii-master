import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:yulli/models/status.dart';
import 'package:yulli/utils/models_utils.dart';

part 'friend_invitation.freezed.dart';
part 'friend_invitation.g.dart';

@freezed
abstract class FriendInvitation with _$FriendInvitation {
  factory FriendInvitation({
    @required
        String sender,
    @required
        String receiver,
    @JsonKey(
      fromJson: ModelUtils.statusValueToEnum,
      toJson: ModelUtils.statusEnumToValue,
    )
    @required
        Status status,
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
  }) = _FriendInvitation;

  factory FriendInvitation.fromJson(Map<String, dynamic> json) =>
      _$FriendInvitationFromJson(json);
}
