import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'invitation.freezed.dart';
part 'invitation.g.dart';

@freezed
abstract class Invitation with _$Invitation {
  factory Invitation({
    @required String sender,
    @required String senderName,
    @nullable String receiverName,
  }) = _Invitation;

  factory Invitation.fromJson(Map<String, dynamic> json) =>
      _$InvitationFromJson(json);
}
