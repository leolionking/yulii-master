// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
class _$UserTearOff {
  const _$UserTearOff();

// ignore: unused_element
  _User call(
      {@required
      @nullable
          String email,
      @required
      @nullable
          String firstname,
      @required
      @nullable
          String lastname,
      @required
      @nullable
          bool isEmailVerified,
      String remoteId,
      @JsonKey(name: 'friends', defaultValue: [])
      @nullable
          List<String> friendsIds,
      @nullable
          CreditTransaction lastCredits,
      @nullable
          int totalTasks,
      @nullable
          int finishedTasks,
      @nullable
          String avatarUrl}) {
    return _User(
      email: email,
      firstname: firstname,
      lastname: lastname,
      isEmailVerified: isEmailVerified,
      remoteId: remoteId,
      friendsIds: friendsIds,
      lastCredits: lastCredits,
      totalTasks: totalTasks,
      finishedTasks: finishedTasks,
      avatarUrl: avatarUrl,
    );
  }

// ignore: unused_element
  User fromJson(Map<String, Object> json) {
    return User.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $User = _$UserTearOff();

/// @nodoc
mixin _$User {
  @nullable
  String get email;
  @nullable
  String get firstname;
  @nullable
  String get lastname;
  @nullable
  bool get isEmailVerified;
  String get remoteId;
  @JsonKey(name: 'friends', defaultValue: [])
  @nullable
  List<String> get friendsIds;
  @nullable
  CreditTransaction get lastCredits;
  @nullable
  int get totalTasks;
  @nullable
  int get finishedTasks;
  @nullable
  String get avatarUrl;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call(
      {@nullable
          String email,
      @nullable
          String firstname,
      @nullable
          String lastname,
      @nullable
          bool isEmailVerified,
      String remoteId,
      @JsonKey(name: 'friends', defaultValue: [])
      @nullable
          List<String> friendsIds,
      @nullable
          CreditTransaction lastCredits,
      @nullable
          int totalTasks,
      @nullable
          int finishedTasks,
      @nullable
          String avatarUrl});

  $CreditTransactionCopyWith<$Res> get lastCredits;
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final User _value;
  // ignore: unused_field
  final $Res Function(User) _then;

  @override
  $Res call({
    Object email = freezed,
    Object firstname = freezed,
    Object lastname = freezed,
    Object isEmailVerified = freezed,
    Object remoteId = freezed,
    Object friendsIds = freezed,
    Object lastCredits = freezed,
    Object totalTasks = freezed,
    Object finishedTasks = freezed,
    Object avatarUrl = freezed,
  }) {
    return _then(_value.copyWith(
      email: email == freezed ? _value.email : email as String,
      firstname: firstname == freezed ? _value.firstname : firstname as String,
      lastname: lastname == freezed ? _value.lastname : lastname as String,
      isEmailVerified: isEmailVerified == freezed
          ? _value.isEmailVerified
          : isEmailVerified as bool,
      remoteId: remoteId == freezed ? _value.remoteId : remoteId as String,
      friendsIds: friendsIds == freezed
          ? _value.friendsIds
          : friendsIds as List<String>,
      lastCredits: lastCredits == freezed
          ? _value.lastCredits
          : lastCredits as CreditTransaction,
      totalTasks: totalTasks == freezed ? _value.totalTasks : totalTasks as int,
      finishedTasks: finishedTasks == freezed
          ? _value.finishedTasks
          : finishedTasks as int,
      avatarUrl: avatarUrl == freezed ? _value.avatarUrl : avatarUrl as String,
    ));
  }

  @override
  $CreditTransactionCopyWith<$Res> get lastCredits {
    if (_value.lastCredits == null) {
      return null;
    }
    return $CreditTransactionCopyWith<$Res>(_value.lastCredits, (value) {
      return _then(_value.copyWith(lastCredits: value));
    });
  }
}

/// @nodoc
abstract class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) then) =
      __$UserCopyWithImpl<$Res>;
  @override
  $Res call(
      {@nullable
          String email,
      @nullable
          String firstname,
      @nullable
          String lastname,
      @nullable
          bool isEmailVerified,
      String remoteId,
      @JsonKey(name: 'friends', defaultValue: [])
      @nullable
          List<String> friendsIds,
      @nullable
          CreditTransaction lastCredits,
      @nullable
          int totalTasks,
      @nullable
          int finishedTasks,
      @nullable
          String avatarUrl});

  @override
  $CreditTransactionCopyWith<$Res> get lastCredits;
}

/// @nodoc
class __$UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(_User _value, $Res Function(_User) _then)
      : super(_value, (v) => _then(v as _User));

  @override
  _User get _value => super._value as _User;

  @override
  $Res call({
    Object email = freezed,
    Object firstname = freezed,
    Object lastname = freezed,
    Object isEmailVerified = freezed,
    Object remoteId = freezed,
    Object friendsIds = freezed,
    Object lastCredits = freezed,
    Object totalTasks = freezed,
    Object finishedTasks = freezed,
    Object avatarUrl = freezed,
  }) {
    return _then(_User(
      email: email == freezed ? _value.email : email as String,
      firstname: firstname == freezed ? _value.firstname : firstname as String,
      lastname: lastname == freezed ? _value.lastname : lastname as String,
      isEmailVerified: isEmailVerified == freezed
          ? _value.isEmailVerified
          : isEmailVerified as bool,
      remoteId: remoteId == freezed ? _value.remoteId : remoteId as String,
      friendsIds: friendsIds == freezed
          ? _value.friendsIds
          : friendsIds as List<String>,
      lastCredits: lastCredits == freezed
          ? _value.lastCredits
          : lastCredits as CreditTransaction,
      totalTasks: totalTasks == freezed ? _value.totalTasks : totalTasks as int,
      finishedTasks: finishedTasks == freezed
          ? _value.finishedTasks
          : finishedTasks as int,
      avatarUrl: avatarUrl == freezed ? _value.avatarUrl : avatarUrl as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_User with DiagnosticableTreeMixin implements _User {
  _$_User(
      {@required @nullable this.email,
      @required @nullable this.firstname,
      @required @nullable this.lastname,
      @required @nullable this.isEmailVerified,
      this.remoteId,
      @JsonKey(name: 'friends', defaultValue: []) @nullable this.friendsIds,
      @nullable this.lastCredits,
      @nullable this.totalTasks,
      @nullable this.finishedTasks,
      @nullable this.avatarUrl});

  factory _$_User.fromJson(Map<String, dynamic> json) =>
      _$_$_UserFromJson(json);

  @override
  @nullable
  final String email;
  @override
  @nullable
  final String firstname;
  @override
  @nullable
  final String lastname;
  @override
  @nullable
  final bool isEmailVerified;
  @override
  final String remoteId;
  @override
  @JsonKey(name: 'friends', defaultValue: [])
  @nullable
  final List<String> friendsIds;
  @override
  @nullable
  final CreditTransaction lastCredits;
  @override
  @nullable
  final int totalTasks;
  @override
  @nullable
  final int finishedTasks;
  @override
  @nullable
  final String avatarUrl;

  bool _diddisplayName = false;
  String _displayName;

  @override
  String get displayName {
    if (_diddisplayName == false) {
      _diddisplayName = true;
      _displayName = "$firstname $lastname";
    }
    return _displayName;
  }

  bool _didisValid = false;
  bool _isValid;

  @override
  bool get isValid {
    if (_didisValid == false) {
      _didisValid = true;
      _isValid = email != null &&
          firstname != null &&
          lastname != null &&
          isEmailVerified != null &&
          remoteId != null;
    }
    return _isValid;
  }

  bool _didhasFriends = false;
  bool _hasFriends;

  @override
  bool get hasFriends {
    if (_didhasFriends == false) {
      _didhasFriends = true;
      _hasFriends = friendsIds != null && friendsIds.isNotEmpty;
    }
    return _hasFriends;
  }

  bool _didhasAvatar = false;
  bool _hasAvatar;

  @override
  bool get hasAvatar {
    if (_didhasAvatar == false) {
      _didhasAvatar = true;
      _hasAvatar = avatarUrl != null;
    }
    return _hasAvatar;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'User(email: $email, firstname: $firstname, lastname: $lastname, isEmailVerified: $isEmailVerified, remoteId: $remoteId, friendsIds: $friendsIds, lastCredits: $lastCredits, totalTasks: $totalTasks, finishedTasks: $finishedTasks, avatarUrl: $avatarUrl, displayName: $displayName, isValid: $isValid, hasFriends: $hasFriends, hasAvatar: $hasAvatar)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'User'))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('firstname', firstname))
      ..add(DiagnosticsProperty('lastname', lastname))
      ..add(DiagnosticsProperty('isEmailVerified', isEmailVerified))
      ..add(DiagnosticsProperty('remoteId', remoteId))
      ..add(DiagnosticsProperty('friendsIds', friendsIds))
      ..add(DiagnosticsProperty('lastCredits', lastCredits))
      ..add(DiagnosticsProperty('totalTasks', totalTasks))
      ..add(DiagnosticsProperty('finishedTasks', finishedTasks))
      ..add(DiagnosticsProperty('avatarUrl', avatarUrl))
      ..add(DiagnosticsProperty('displayName', displayName))
      ..add(DiagnosticsProperty('isValid', isValid))
      ..add(DiagnosticsProperty('hasFriends', hasFriends))
      ..add(DiagnosticsProperty('hasAvatar', hasAvatar));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _User &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.firstname, firstname) ||
                const DeepCollectionEquality()
                    .equals(other.firstname, firstname)) &&
            (identical(other.lastname, lastname) ||
                const DeepCollectionEquality()
                    .equals(other.lastname, lastname)) &&
            (identical(other.isEmailVerified, isEmailVerified) ||
                const DeepCollectionEquality()
                    .equals(other.isEmailVerified, isEmailVerified)) &&
            (identical(other.remoteId, remoteId) ||
                const DeepCollectionEquality()
                    .equals(other.remoteId, remoteId)) &&
            (identical(other.friendsIds, friendsIds) ||
                const DeepCollectionEquality()
                    .equals(other.friendsIds, friendsIds)) &&
            (identical(other.lastCredits, lastCredits) ||
                const DeepCollectionEquality()
                    .equals(other.lastCredits, lastCredits)) &&
            (identical(other.totalTasks, totalTasks) ||
                const DeepCollectionEquality()
                    .equals(other.totalTasks, totalTasks)) &&
            (identical(other.finishedTasks, finishedTasks) ||
                const DeepCollectionEquality()
                    .equals(other.finishedTasks, finishedTasks)) &&
            (identical(other.avatarUrl, avatarUrl) ||
                const DeepCollectionEquality()
                    .equals(other.avatarUrl, avatarUrl)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(firstname) ^
      const DeepCollectionEquality().hash(lastname) ^
      const DeepCollectionEquality().hash(isEmailVerified) ^
      const DeepCollectionEquality().hash(remoteId) ^
      const DeepCollectionEquality().hash(friendsIds) ^
      const DeepCollectionEquality().hash(lastCredits) ^
      const DeepCollectionEquality().hash(totalTasks) ^
      const DeepCollectionEquality().hash(finishedTasks) ^
      const DeepCollectionEquality().hash(avatarUrl);

  @JsonKey(ignore: true)
  @override
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_UserToJson(this);
  }
}

abstract class _User implements User {
  factory _User(
      {@required
      @nullable
          String email,
      @required
      @nullable
          String firstname,
      @required
      @nullable
          String lastname,
      @required
      @nullable
          bool isEmailVerified,
      String remoteId,
      @JsonKey(name: 'friends', defaultValue: [])
      @nullable
          List<String> friendsIds,
      @nullable
          CreditTransaction lastCredits,
      @nullable
          int totalTasks,
      @nullable
          int finishedTasks,
      @nullable
          String avatarUrl}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  @nullable
  String get email;
  @override
  @nullable
  String get firstname;
  @override
  @nullable
  String get lastname;
  @override
  @nullable
  bool get isEmailVerified;
  @override
  String get remoteId;
  @override
  @JsonKey(name: 'friends', defaultValue: [])
  @nullable
  List<String> get friendsIds;
  @override
  @nullable
  CreditTransaction get lastCredits;
  @override
  @nullable
  int get totalTasks;
  @override
  @nullable
  int get finishedTasks;
  @override
  @nullable
  String get avatarUrl;
  @override
  @JsonKey(ignore: true)
  _$UserCopyWith<_User> get copyWith;
}
