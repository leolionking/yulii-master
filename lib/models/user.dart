import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:yulli/models/credit_transaction.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  factory User({
    @nullable @required String email,
    @nullable @required String firstname,
    @nullable @required String lastname,
    @nullable @required bool isEmailVerified,
    String remoteId,
    @JsonKey(name: 'friends', defaultValue: [])
    @nullable
        List<String> friendsIds,
    @nullable CreditTransaction lastCredits,
    @nullable int totalTasks,
    @nullable int finishedTasks,
    @nullable String avatarUrl,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.empty() =>
      User(email: null, firstname: null, lastname: null, isEmailVerified: null);

  @late
  String get displayName => "$firstname $lastname";

  @late
  bool get isValid =>
      email != null &&
      firstname != null &&
      lastname != null &&
      isEmailVerified != null &&
      remoteId != null;

  @late
  bool get hasFriends => friendsIds != null && friendsIds.isNotEmpty;

  @late
  bool get hasAvatar => avatarUrl != null;
}
