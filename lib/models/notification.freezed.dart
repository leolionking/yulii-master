// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Notification _$NotificationFromJson(Map<String, dynamic> json) {
  return _Notification.fromJson(json);
}

/// @nodoc
class _$NotificationTearOff {
  const _$NotificationTearOff();

// ignore: unused_element
  _Notification call(
      {@required
          String receiver,
      @required
      @JsonKey(fromJson: _NotificationTypeHelper.stringToEnum, toJson: _NotificationTypeHelper.enumToString)
          NotificationType type,
      @required
          Map<String, dynamic> data,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime updatedAt,
      @required
      @JsonKey(fromJson: ModelUtils.statusValueToEnum, toJson: ModelUtils.statusEnumToValue)
          Status status,
      @required
          bool read,
      @nullable
          String remoteId}) {
    return _Notification(
      receiver: receiver,
      type: type,
      data: data,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status,
      read: read,
      remoteId: remoteId,
    );
  }

// ignore: unused_element
  Notification fromJson(Map<String, Object> json) {
    return Notification.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Notification = _$NotificationTearOff();

/// @nodoc
mixin _$Notification {
  String get receiver;
  @JsonKey(
      fromJson: _NotificationTypeHelper.stringToEnum,
      toJson: _NotificationTypeHelper.enumToString)
  NotificationType get type;
  Map<String, dynamic> get data;
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  DateTime get createdAt;
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  DateTime get updatedAt;
  @JsonKey(
      fromJson: ModelUtils.statusValueToEnum,
      toJson: ModelUtils.statusEnumToValue)
  Status get status;
  bool get read;
  @nullable
  String get remoteId;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $NotificationCopyWith<Notification> get copyWith;
}

/// @nodoc
abstract class $NotificationCopyWith<$Res> {
  factory $NotificationCopyWith(
          Notification value, $Res Function(Notification) then) =
      _$NotificationCopyWithImpl<$Res>;
  $Res call(
      {String receiver,
      @JsonKey(fromJson: _NotificationTypeHelper.stringToEnum, toJson: _NotificationTypeHelper.enumToString)
          NotificationType type,
      Map<String, dynamic> data,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime updatedAt,
      @JsonKey(fromJson: ModelUtils.statusValueToEnum, toJson: ModelUtils.statusEnumToValue)
          Status status,
      bool read,
      @nullable
          String remoteId});
}

/// @nodoc
class _$NotificationCopyWithImpl<$Res> implements $NotificationCopyWith<$Res> {
  _$NotificationCopyWithImpl(this._value, this._then);

  final Notification _value;
  // ignore: unused_field
  final $Res Function(Notification) _then;

  @override
  $Res call({
    Object receiver = freezed,
    Object type = freezed,
    Object data = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
    Object status = freezed,
    Object read = freezed,
    Object remoteId = freezed,
  }) {
    return _then(_value.copyWith(
      receiver: receiver == freezed ? _value.receiver : receiver as String,
      type: type == freezed ? _value.type : type as NotificationType,
      data: data == freezed ? _value.data : data as Map<String, dynamic>,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      updatedAt:
          updatedAt == freezed ? _value.updatedAt : updatedAt as DateTime,
      status: status == freezed ? _value.status : status as Status,
      read: read == freezed ? _value.read : read as bool,
      remoteId: remoteId == freezed ? _value.remoteId : remoteId as String,
    ));
  }
}

/// @nodoc
abstract class _$NotificationCopyWith<$Res>
    implements $NotificationCopyWith<$Res> {
  factory _$NotificationCopyWith(
          _Notification value, $Res Function(_Notification) then) =
      __$NotificationCopyWithImpl<$Res>;
  @override
  $Res call(
      {String receiver,
      @JsonKey(fromJson: _NotificationTypeHelper.stringToEnum, toJson: _NotificationTypeHelper.enumToString)
          NotificationType type,
      Map<String, dynamic> data,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime updatedAt,
      @JsonKey(fromJson: ModelUtils.statusValueToEnum, toJson: ModelUtils.statusEnumToValue)
          Status status,
      bool read,
      @nullable
          String remoteId});
}

/// @nodoc
class __$NotificationCopyWithImpl<$Res> extends _$NotificationCopyWithImpl<$Res>
    implements _$NotificationCopyWith<$Res> {
  __$NotificationCopyWithImpl(
      _Notification _value, $Res Function(_Notification) _then)
      : super(_value, (v) => _then(v as _Notification));

  @override
  _Notification get _value => super._value as _Notification;

  @override
  $Res call({
    Object receiver = freezed,
    Object type = freezed,
    Object data = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
    Object status = freezed,
    Object read = freezed,
    Object remoteId = freezed,
  }) {
    return _then(_Notification(
      receiver: receiver == freezed ? _value.receiver : receiver as String,
      type: type == freezed ? _value.type : type as NotificationType,
      data: data == freezed ? _value.data : data as Map<String, dynamic>,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      updatedAt:
          updatedAt == freezed ? _value.updatedAt : updatedAt as DateTime,
      status: status == freezed ? _value.status : status as Status,
      read: read == freezed ? _value.read : read as bool,
      remoteId: remoteId == freezed ? _value.remoteId : remoteId as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Notification with DiagnosticableTreeMixin implements _Notification {
  const _$_Notification(
      {@required
          this.receiver,
      @required
      @JsonKey(fromJson: _NotificationTypeHelper.stringToEnum, toJson: _NotificationTypeHelper.enumToString)
          this.type,
      @required
          this.data,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          this.createdAt,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          this.updatedAt,
      @required
      @JsonKey(fromJson: ModelUtils.statusValueToEnum, toJson: ModelUtils.statusEnumToValue)
          this.status,
      @required
          this.read,
      @nullable
          this.remoteId})
      : assert(receiver != null),
        assert(type != null),
        assert(data != null),
        assert(createdAt != null),
        assert(updatedAt != null),
        assert(status != null),
        assert(read != null);

  factory _$_Notification.fromJson(Map<String, dynamic> json) =>
      _$_$_NotificationFromJson(json);

  @override
  final String receiver;
  @override
  @JsonKey(
      fromJson: _NotificationTypeHelper.stringToEnum,
      toJson: _NotificationTypeHelper.enumToString)
  final NotificationType type;
  @override
  final Map<String, dynamic> data;
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
  @JsonKey(
      fromJson: ModelUtils.statusValueToEnum,
      toJson: ModelUtils.statusEnumToValue)
  final Status status;
  @override
  final bool read;
  @override
  @nullable
  final String remoteId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Notification(receiver: $receiver, type: $type, data: $data, createdAt: $createdAt, updatedAt: $updatedAt, status: $status, read: $read, remoteId: $remoteId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Notification'))
      ..add(DiagnosticsProperty('receiver', receiver))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('read', read))
      ..add(DiagnosticsProperty('remoteId', remoteId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Notification &&
            (identical(other.receiver, receiver) ||
                const DeepCollectionEquality()
                    .equals(other.receiver, receiver)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.read, read) ||
                const DeepCollectionEquality().equals(other.read, read)) &&
            (identical(other.remoteId, remoteId) ||
                const DeepCollectionEquality()
                    .equals(other.remoteId, remoteId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(receiver) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(data) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(read) ^
      const DeepCollectionEquality().hash(remoteId);

  @JsonKey(ignore: true)
  @override
  _$NotificationCopyWith<_Notification> get copyWith =>
      __$NotificationCopyWithImpl<_Notification>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_NotificationToJson(this);
  }
}

abstract class _Notification implements Notification {
  const factory _Notification(
      {@required
          String receiver,
      @required
      @JsonKey(fromJson: _NotificationTypeHelper.stringToEnum, toJson: _NotificationTypeHelper.enumToString)
          NotificationType type,
      @required
          Map<String, dynamic> data,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime updatedAt,
      @required
      @JsonKey(fromJson: ModelUtils.statusValueToEnum, toJson: ModelUtils.statusEnumToValue)
          Status status,
      @required
          bool read,
      @nullable
          String remoteId}) = _$_Notification;

  factory _Notification.fromJson(Map<String, dynamic> json) =
      _$_Notification.fromJson;

  @override
  String get receiver;
  @override
  @JsonKey(
      fromJson: _NotificationTypeHelper.stringToEnum,
      toJson: _NotificationTypeHelper.enumToString)
  NotificationType get type;
  @override
  Map<String, dynamic> get data;
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
  @JsonKey(
      fromJson: ModelUtils.statusValueToEnum,
      toJson: ModelUtils.statusEnumToValue)
  Status get status;
  @override
  bool get read;
  @override
  @nullable
  String get remoteId;
  @override
  @JsonKey(ignore: true)
  _$NotificationCopyWith<_Notification> get copyWith;
}
