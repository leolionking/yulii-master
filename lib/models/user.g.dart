// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$_$_UserFromJson(Map<String, dynamic> json) {
  return _$_User(
    email: json['email'] as String,
    firstname: json['firstname'] as String,
    lastname: json['lastname'] as String,
    isEmailVerified: json['isEmailVerified'] as bool,
    remoteId: json['remoteId'] as String,
    friendsIds:
        (json['friends'] as List)?.map((e) => e as String)?.toList() ?? [],
    lastCredits: json['lastCredits'] == null
        ? null
        : CreditTransaction.fromJson(
            json['lastCredits'] as Map<String, dynamic>),
    totalTasks: json['totalTasks'] as int,
    finishedTasks: json['finishedTasks'] as int,
    avatarUrl: json['avatarUrl'] as String,
  );
}

Map<String, dynamic> _$_$_UserToJson(_$_User instance) => <String, dynamic>{
      'email': instance.email,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'isEmailVerified': instance.isEmailVerified,
      'remoteId': instance.remoteId,
      'friends': instance.friendsIds,
      'lastCredits': instance.lastCredits,
      'totalTasks': instance.totalTasks,
      'finishedTasks': instance.finishedTasks,
      'avatarUrl': instance.avatarUrl,
    };
