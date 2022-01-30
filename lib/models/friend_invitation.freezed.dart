// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'friend_invitation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
FriendInvitation _$FriendInvitationFromJson(Map<String, dynamic> json) {
  return _FriendInvitation.fromJson(json);
}

/// @nodoc
class _$FriendInvitationTearOff {
  const _$FriendInvitationTearOff();

// ignore: unused_element
  _FriendInvitation call(
      {@required
          String sender,
      @required
          String receiver,
      @required
      @JsonKey(fromJson: ModelUtils.statusValueToEnum, toJson: ModelUtils.statusEnumToValue)
          Status status,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime updatedAt}) {
    return _FriendInvitation(
      sender: sender,
      receiver: receiver,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

// ignore: unused_element
  FriendInvitation fromJson(Map<String, Object> json) {
    return FriendInvitation.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $FriendInvitation = _$FriendInvitationTearOff();

/// @nodoc
mixin _$FriendInvitation {
  String get sender;
  String get receiver;
  @JsonKey(
      fromJson: ModelUtils.statusValueToEnum,
      toJson: ModelUtils.statusEnumToValue)
  Status get status;
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  DateTime get createdAt;
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  DateTime get updatedAt;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $FriendInvitationCopyWith<FriendInvitation> get copyWith;
}

/// @nodoc
abstract class $FriendInvitationCopyWith<$Res> {
  factory $FriendInvitationCopyWith(
          FriendInvitation value, $Res Function(FriendInvitation) then) =
      _$FriendInvitationCopyWithImpl<$Res>;
  $Res call(
      {String sender,
      String receiver,
      @JsonKey(fromJson: ModelUtils.statusValueToEnum, toJson: ModelUtils.statusEnumToValue)
          Status status,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime updatedAt});
}

/// @nodoc
class _$FriendInvitationCopyWithImpl<$Res>
    implements $FriendInvitationCopyWith<$Res> {
  _$FriendInvitationCopyWithImpl(this._value, this._then);

  final FriendInvitation _value;
  // ignore: unused_field
  final $Res Function(FriendInvitation) _then;

  @override
  $Res call({
    Object sender = freezed,
    Object receiver = freezed,
    Object status = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      sender: sender == freezed ? _value.sender : sender as String,
      receiver: receiver == freezed ? _value.receiver : receiver as String,
      status: status == freezed ? _value.status : status as Status,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      updatedAt:
          updatedAt == freezed ? _value.updatedAt : updatedAt as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$FriendInvitationCopyWith<$Res>
    implements $FriendInvitationCopyWith<$Res> {
  factory _$FriendInvitationCopyWith(
          _FriendInvitation value, $Res Function(_FriendInvitation) then) =
      __$FriendInvitationCopyWithImpl<$Res>;
  @override
  $Res call(
      {String sender,
      String receiver,
      @JsonKey(fromJson: ModelUtils.statusValueToEnum, toJson: ModelUtils.statusEnumToValue)
          Status status,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime updatedAt});
}

/// @nodoc
class __$FriendInvitationCopyWithImpl<$Res>
    extends _$FriendInvitationCopyWithImpl<$Res>
    implements _$FriendInvitationCopyWith<$Res> {
  __$FriendInvitationCopyWithImpl(
      _FriendInvitation _value, $Res Function(_FriendInvitation) _then)
      : super(_value, (v) => _then(v as _FriendInvitation));

  @override
  _FriendInvitation get _value => super._value as _FriendInvitation;

  @override
  $Res call({
    Object sender = freezed,
    Object receiver = freezed,
    Object status = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
  }) {
    return _then(_FriendInvitation(
      sender: sender == freezed ? _value.sender : sender as String,
      receiver: receiver == freezed ? _value.receiver : receiver as String,
      status: status == freezed ? _value.status : status as Status,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      updatedAt:
          updatedAt == freezed ? _value.updatedAt : updatedAt as DateTime,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_FriendInvitation
    with DiagnosticableTreeMixin
    implements _FriendInvitation {
  _$_FriendInvitation(
      {@required
          this.sender,
      @required
          this.receiver,
      @required
      @JsonKey(fromJson: ModelUtils.statusValueToEnum, toJson: ModelUtils.statusEnumToValue)
          this.status,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          this.createdAt,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          this.updatedAt})
      : assert(sender != null),
        assert(receiver != null),
        assert(status != null),
        assert(createdAt != null),
        assert(updatedAt != null);

  factory _$_FriendInvitation.fromJson(Map<String, dynamic> json) =>
      _$_$_FriendInvitationFromJson(json);

  @override
  final String sender;
  @override
  final String receiver;
  @override
  @JsonKey(
      fromJson: ModelUtils.statusValueToEnum,
      toJson: ModelUtils.statusEnumToValue)
  final Status status;
  @override
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  final DateTime createdAt;
  @override
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  final DateTime updatedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FriendInvitation(sender: $sender, receiver: $receiver, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FriendInvitation'))
      ..add(DiagnosticsProperty('sender', sender))
      ..add(DiagnosticsProperty('receiver', receiver))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FriendInvitation &&
            (identical(other.sender, sender) ||
                const DeepCollectionEquality().equals(other.sender, sender)) &&
            (identical(other.receiver, receiver) ||
                const DeepCollectionEquality()
                    .equals(other.receiver, receiver)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(sender) ^
      const DeepCollectionEquality().hash(receiver) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt);

  @JsonKey(ignore: true)
  @override
  _$FriendInvitationCopyWith<_FriendInvitation> get copyWith =>
      __$FriendInvitationCopyWithImpl<_FriendInvitation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_FriendInvitationToJson(this);
  }
}

abstract class _FriendInvitation implements FriendInvitation {
  factory _FriendInvitation(
      {@required
          String sender,
      @required
          String receiver,
      @required
      @JsonKey(fromJson: ModelUtils.statusValueToEnum, toJson: ModelUtils.statusEnumToValue)
          Status status,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime updatedAt}) = _$_FriendInvitation;

  factory _FriendInvitation.fromJson(Map<String, dynamic> json) =
      _$_FriendInvitation.fromJson;

  @override
  String get sender;
  @override
  String get receiver;
  @override
  @JsonKey(
      fromJson: ModelUtils.statusValueToEnum,
      toJson: ModelUtils.statusEnumToValue)
  Status get status;
  @override
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  DateTime get createdAt;
  @override
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$FriendInvitationCopyWith<_FriendInvitation> get copyWith;
}
