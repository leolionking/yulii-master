// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Chat _$ChatFromJson(Map<String, dynamic> json) {
  return _Chat.fromJson(json);
}

/// @nodoc
class _$ChatTearOff {
  const _$ChatTearOff();

// ignore: unused_element
  _Chat call(
      {@required
          List<String> participantsIds,
      @nullable
          List<User> participants,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime updatedAt,
      @nullable
          ChatMessage lastMessage,
      @nullable
          String remoteId}) {
    return _Chat(
      participantsIds: participantsIds,
      participants: participants,
      createdAt: createdAt,
      updatedAt: updatedAt,
      lastMessage: lastMessage,
      remoteId: remoteId,
    );
  }

// ignore: unused_element
  Chat fromJson(Map<String, Object> json) {
    return Chat.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Chat = _$ChatTearOff();

/// @nodoc
mixin _$Chat {
  List<String> get participantsIds;
  @nullable
  List<User> get participants;
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  DateTime get createdAt;
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  DateTime get updatedAt;
  @nullable
  ChatMessage get lastMessage;
  @nullable
  String get remoteId;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $ChatCopyWith<Chat> get copyWith;
}

/// @nodoc
abstract class $ChatCopyWith<$Res> {
  factory $ChatCopyWith(Chat value, $Res Function(Chat) then) =
      _$ChatCopyWithImpl<$Res>;
  $Res call(
      {List<String> participantsIds,
      @nullable
          List<User> participants,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime updatedAt,
      @nullable
          ChatMessage lastMessage,
      @nullable
          String remoteId});

  $ChatMessageCopyWith<$Res> get lastMessage;
}

/// @nodoc
class _$ChatCopyWithImpl<$Res> implements $ChatCopyWith<$Res> {
  _$ChatCopyWithImpl(this._value, this._then);

  final Chat _value;
  // ignore: unused_field
  final $Res Function(Chat) _then;

  @override
  $Res call({
    Object participantsIds = freezed,
    Object participants = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
    Object lastMessage = freezed,
    Object remoteId = freezed,
  }) {
    return _then(_value.copyWith(
      participantsIds: participantsIds == freezed
          ? _value.participantsIds
          : participantsIds as List<String>,
      participants: participants == freezed
          ? _value.participants
          : participants as List<User>,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      updatedAt:
          updatedAt == freezed ? _value.updatedAt : updatedAt as DateTime,
      lastMessage: lastMessage == freezed
          ? _value.lastMessage
          : lastMessage as ChatMessage,
      remoteId: remoteId == freezed ? _value.remoteId : remoteId as String,
    ));
  }

  @override
  $ChatMessageCopyWith<$Res> get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }
    return $ChatMessageCopyWith<$Res>(_value.lastMessage, (value) {
      return _then(_value.copyWith(lastMessage: value));
    });
  }
}

/// @nodoc
abstract class _$ChatCopyWith<$Res> implements $ChatCopyWith<$Res> {
  factory _$ChatCopyWith(_Chat value, $Res Function(_Chat) then) =
      __$ChatCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<String> participantsIds,
      @nullable
          List<User> participants,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime updatedAt,
      @nullable
          ChatMessage lastMessage,
      @nullable
          String remoteId});

  @override
  $ChatMessageCopyWith<$Res> get lastMessage;
}

/// @nodoc
class __$ChatCopyWithImpl<$Res> extends _$ChatCopyWithImpl<$Res>
    implements _$ChatCopyWith<$Res> {
  __$ChatCopyWithImpl(_Chat _value, $Res Function(_Chat) _then)
      : super(_value, (v) => _then(v as _Chat));

  @override
  _Chat get _value => super._value as _Chat;

  @override
  $Res call({
    Object participantsIds = freezed,
    Object participants = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
    Object lastMessage = freezed,
    Object remoteId = freezed,
  }) {
    return _then(_Chat(
      participantsIds: participantsIds == freezed
          ? _value.participantsIds
          : participantsIds as List<String>,
      participants: participants == freezed
          ? _value.participants
          : participants as List<User>,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      updatedAt:
          updatedAt == freezed ? _value.updatedAt : updatedAt as DateTime,
      lastMessage: lastMessage == freezed
          ? _value.lastMessage
          : lastMessage as ChatMessage,
      remoteId: remoteId == freezed ? _value.remoteId : remoteId as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Chat with DiagnosticableTreeMixin implements _Chat {
  _$_Chat(
      {@required
          this.participantsIds,
      @nullable
          this.participants,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          this.createdAt,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          this.updatedAt,
      @nullable
          this.lastMessage,
      @nullable
          this.remoteId})
      : assert(participantsIds != null),
        assert(createdAt != null),
        assert(updatedAt != null);

  factory _$_Chat.fromJson(Map<String, dynamic> json) =>
      _$_$_ChatFromJson(json);

  @override
  final List<String> participantsIds;
  @override
  @nullable
  final List<User> participants;
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
  @nullable
  final ChatMessage lastMessage;
  @override
  @nullable
  final String remoteId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Chat(participantsIds: $participantsIds, participants: $participants, createdAt: $createdAt, updatedAt: $updatedAt, lastMessage: $lastMessage, remoteId: $remoteId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Chat'))
      ..add(DiagnosticsProperty('participantsIds', participantsIds))
      ..add(DiagnosticsProperty('participants', participants))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('lastMessage', lastMessage))
      ..add(DiagnosticsProperty('remoteId', remoteId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Chat &&
            (identical(other.participantsIds, participantsIds) ||
                const DeepCollectionEquality()
                    .equals(other.participantsIds, participantsIds)) &&
            (identical(other.participants, participants) ||
                const DeepCollectionEquality()
                    .equals(other.participants, participants)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.lastMessage, lastMessage) ||
                const DeepCollectionEquality()
                    .equals(other.lastMessage, lastMessage)) &&
            (identical(other.remoteId, remoteId) ||
                const DeepCollectionEquality()
                    .equals(other.remoteId, remoteId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(participantsIds) ^
      const DeepCollectionEquality().hash(participants) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(lastMessage) ^
      const DeepCollectionEquality().hash(remoteId);

  @JsonKey(ignore: true)
  @override
  _$ChatCopyWith<_Chat> get copyWith =>
      __$ChatCopyWithImpl<_Chat>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ChatToJson(this);
  }
}

abstract class _Chat implements Chat {
  factory _Chat(
      {@required
          List<String> participantsIds,
      @nullable
          List<User> participants,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime updatedAt,
      @nullable
          ChatMessage lastMessage,
      @nullable
          String remoteId}) = _$_Chat;

  factory _Chat.fromJson(Map<String, dynamic> json) = _$_Chat.fromJson;

  @override
  List<String> get participantsIds;
  @override
  @nullable
  List<User> get participants;
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
  @nullable
  ChatMessage get lastMessage;
  @override
  @nullable
  String get remoteId;
  @override
  @JsonKey(ignore: true)
  _$ChatCopyWith<_Chat> get copyWith;
}
