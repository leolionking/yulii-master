// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'chat_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return _ChatMessage.fromJson(json);
}

/// @nodoc
class _$ChatMessageTearOff {
  const _$ChatMessageTearOff();

// ignore: unused_element
  _ChatMessage call(
      {@required
      @JsonKey(fromJson: _ChatMessageTypeHelper.stringToEnum, toJson: _ChatMessageTypeHelper.enumToString)
          ChatMessageType type,
      @nullable
          String chatId,
      @nullable
          List<String> participantsIds,
      String senderId,
      String receiverId,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
      @nullable
          DateTime deletedAt,
      @nullable
          String content,
      @nullable
          String remoteId,
      @JsonKey(fromJson: ModelUtils.mapToUploadedFile, toJson: ModelUtils.uploadedFileToJson)
      @nullable
          UploadedFile file,
      bool read = false}) {
    return _ChatMessage(
      type: type,
      chatId: chatId,
      participantsIds: participantsIds,
      senderId: senderId,
      receiverId: receiverId,
      createdAt: createdAt,
      deletedAt: deletedAt,
      content: content,
      remoteId: remoteId,
      file: file,
      read: read,
    );
  }

// ignore: unused_element
  ChatMessage fromJson(Map<String, Object> json) {
    return ChatMessage.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $ChatMessage = _$ChatMessageTearOff();

/// @nodoc
mixin _$ChatMessage {
  @JsonKey(
      fromJson: _ChatMessageTypeHelper.stringToEnum,
      toJson: _ChatMessageTypeHelper.enumToString)
  ChatMessageType get type;
  @nullable
  String get chatId;
  @nullable
  List<String> get participantsIds;
  String get senderId;
  String get receiverId;
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  DateTime get createdAt;
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  @nullable
  DateTime get deletedAt;
  @nullable
  String get content;
  @nullable
  String get remoteId;
  @JsonKey(
      fromJson: ModelUtils.mapToUploadedFile,
      toJson: ModelUtils.uploadedFileToJson)
  @nullable
  UploadedFile get file;
  bool get read;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $ChatMessageCopyWith<ChatMessage> get copyWith;
}

/// @nodoc
abstract class $ChatMessageCopyWith<$Res> {
  factory $ChatMessageCopyWith(
          ChatMessage value, $Res Function(ChatMessage) then) =
      _$ChatMessageCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(fromJson: _ChatMessageTypeHelper.stringToEnum, toJson: _ChatMessageTypeHelper.enumToString)
          ChatMessageType type,
      @nullable
          String chatId,
      @nullable
          List<String> participantsIds,
      String senderId,
      String receiverId,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
      @nullable
          DateTime deletedAt,
      @nullable
          String content,
      @nullable
          String remoteId,
      @JsonKey(fromJson: ModelUtils.mapToUploadedFile, toJson: ModelUtils.uploadedFileToJson)
      @nullable
          UploadedFile file,
      bool read});

  $UploadedFileCopyWith<$Res> get file;
}

/// @nodoc
class _$ChatMessageCopyWithImpl<$Res> implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._value, this._then);

  final ChatMessage _value;
  // ignore: unused_field
  final $Res Function(ChatMessage) _then;

  @override
  $Res call({
    Object type = freezed,
    Object chatId = freezed,
    Object participantsIds = freezed,
    Object senderId = freezed,
    Object receiverId = freezed,
    Object createdAt = freezed,
    Object deletedAt = freezed,
    Object content = freezed,
    Object remoteId = freezed,
    Object file = freezed,
    Object read = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed ? _value.type : type as ChatMessageType,
      chatId: chatId == freezed ? _value.chatId : chatId as String,
      participantsIds: participantsIds == freezed
          ? _value.participantsIds
          : participantsIds as List<String>,
      senderId: senderId == freezed ? _value.senderId : senderId as String,
      receiverId:
          receiverId == freezed ? _value.receiverId : receiverId as String,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      deletedAt:
          deletedAt == freezed ? _value.deletedAt : deletedAt as DateTime,
      content: content == freezed ? _value.content : content as String,
      remoteId: remoteId == freezed ? _value.remoteId : remoteId as String,
      file: file == freezed ? _value.file : file as UploadedFile,
      read: read == freezed ? _value.read : read as bool,
    ));
  }

  @override
  $UploadedFileCopyWith<$Res> get file {
    if (_value.file == null) {
      return null;
    }
    return $UploadedFileCopyWith<$Res>(_value.file, (value) {
      return _then(_value.copyWith(file: value));
    });
  }
}

/// @nodoc
abstract class _$ChatMessageCopyWith<$Res>
    implements $ChatMessageCopyWith<$Res> {
  factory _$ChatMessageCopyWith(
          _ChatMessage value, $Res Function(_ChatMessage) then) =
      __$ChatMessageCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(fromJson: _ChatMessageTypeHelper.stringToEnum, toJson: _ChatMessageTypeHelper.enumToString)
          ChatMessageType type,
      @nullable
          String chatId,
      @nullable
          List<String> participantsIds,
      String senderId,
      String receiverId,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
      @nullable
          DateTime deletedAt,
      @nullable
          String content,
      @nullable
          String remoteId,
      @JsonKey(fromJson: ModelUtils.mapToUploadedFile, toJson: ModelUtils.uploadedFileToJson)
      @nullable
          UploadedFile file,
      bool read});

  @override
  $UploadedFileCopyWith<$Res> get file;
}

/// @nodoc
class __$ChatMessageCopyWithImpl<$Res> extends _$ChatMessageCopyWithImpl<$Res>
    implements _$ChatMessageCopyWith<$Res> {
  __$ChatMessageCopyWithImpl(
      _ChatMessage _value, $Res Function(_ChatMessage) _then)
      : super(_value, (v) => _then(v as _ChatMessage));

  @override
  _ChatMessage get _value => super._value as _ChatMessage;

  @override
  $Res call({
    Object type = freezed,
    Object chatId = freezed,
    Object participantsIds = freezed,
    Object senderId = freezed,
    Object receiverId = freezed,
    Object createdAt = freezed,
    Object deletedAt = freezed,
    Object content = freezed,
    Object remoteId = freezed,
    Object file = freezed,
    Object read = freezed,
  }) {
    return _then(_ChatMessage(
      type: type == freezed ? _value.type : type as ChatMessageType,
      chatId: chatId == freezed ? _value.chatId : chatId as String,
      participantsIds: participantsIds == freezed
          ? _value.participantsIds
          : participantsIds as List<String>,
      senderId: senderId == freezed ? _value.senderId : senderId as String,
      receiverId:
          receiverId == freezed ? _value.receiverId : receiverId as String,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      deletedAt:
          deletedAt == freezed ? _value.deletedAt : deletedAt as DateTime,
      content: content == freezed ? _value.content : content as String,
      remoteId: remoteId == freezed ? _value.remoteId : remoteId as String,
      file: file == freezed ? _value.file : file as UploadedFile,
      read: read == freezed ? _value.read : read as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_ChatMessage with DiagnosticableTreeMixin implements _ChatMessage {
  _$_ChatMessage(
      {@required
      @JsonKey(fromJson: _ChatMessageTypeHelper.stringToEnum, toJson: _ChatMessageTypeHelper.enumToString)
          this.type,
      @nullable
          this.chatId,
      @nullable
          this.participantsIds,
      this.senderId,
      this.receiverId,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          this.createdAt,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
      @nullable
          this.deletedAt,
      @nullable
          this.content,
      @nullable
          this.remoteId,
      @JsonKey(fromJson: ModelUtils.mapToUploadedFile, toJson: ModelUtils.uploadedFileToJson)
      @nullable
          this.file,
      this.read = false})
      : assert(type != null),
        assert(createdAt != null),
        assert(read != null);

  factory _$_ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$_$_ChatMessageFromJson(json);

  @override
  @JsonKey(
      fromJson: _ChatMessageTypeHelper.stringToEnum,
      toJson: _ChatMessageTypeHelper.enumToString)
  final ChatMessageType type;
  @override
  @nullable
  final String chatId;
  @override
  @nullable
  final List<String> participantsIds;
  @override
  final String senderId;
  @override
  final String receiverId;
  @override
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  final DateTime createdAt;
  @override
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  @nullable
  final DateTime deletedAt;
  @override
  @nullable
  final String content;
  @override
  @nullable
  final String remoteId;
  @override
  @JsonKey(
      fromJson: ModelUtils.mapToUploadedFile,
      toJson: ModelUtils.uploadedFileToJson)
  @nullable
  final UploadedFile file;
  @JsonKey(defaultValue: false)
  @override
  final bool read;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatMessage(type: $type, chatId: $chatId, participantsIds: $participantsIds, senderId: $senderId, receiverId: $receiverId, createdAt: $createdAt, deletedAt: $deletedAt, content: $content, remoteId: $remoteId, file: $file, read: $read)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatMessage'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('chatId', chatId))
      ..add(DiagnosticsProperty('participantsIds', participantsIds))
      ..add(DiagnosticsProperty('senderId', senderId))
      ..add(DiagnosticsProperty('receiverId', receiverId))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('deletedAt', deletedAt))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('remoteId', remoteId))
      ..add(DiagnosticsProperty('file', file))
      ..add(DiagnosticsProperty('read', read));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ChatMessage &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.chatId, chatId) ||
                const DeepCollectionEquality().equals(other.chatId, chatId)) &&
            (identical(other.participantsIds, participantsIds) ||
                const DeepCollectionEquality()
                    .equals(other.participantsIds, participantsIds)) &&
            (identical(other.senderId, senderId) ||
                const DeepCollectionEquality()
                    .equals(other.senderId, senderId)) &&
            (identical(other.receiverId, receiverId) ||
                const DeepCollectionEquality()
                    .equals(other.receiverId, receiverId)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.deletedAt, deletedAt) ||
                const DeepCollectionEquality()
                    .equals(other.deletedAt, deletedAt)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality()
                    .equals(other.content, content)) &&
            (identical(other.remoteId, remoteId) ||
                const DeepCollectionEquality()
                    .equals(other.remoteId, remoteId)) &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)) &&
            (identical(other.read, read) ||
                const DeepCollectionEquality().equals(other.read, read)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(chatId) ^
      const DeepCollectionEquality().hash(participantsIds) ^
      const DeepCollectionEquality().hash(senderId) ^
      const DeepCollectionEquality().hash(receiverId) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(deletedAt) ^
      const DeepCollectionEquality().hash(content) ^
      const DeepCollectionEquality().hash(remoteId) ^
      const DeepCollectionEquality().hash(file) ^
      const DeepCollectionEquality().hash(read);

  @JsonKey(ignore: true)
  @override
  _$ChatMessageCopyWith<_ChatMessage> get copyWith =>
      __$ChatMessageCopyWithImpl<_ChatMessage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ChatMessageToJson(this);
  }
}

abstract class _ChatMessage implements ChatMessage {
  factory _ChatMessage(
      {@required
      @JsonKey(fromJson: _ChatMessageTypeHelper.stringToEnum, toJson: _ChatMessageTypeHelper.enumToString)
          ChatMessageType type,
      @nullable
          String chatId,
      @nullable
          List<String> participantsIds,
      String senderId,
      String receiverId,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
      @nullable
          DateTime deletedAt,
      @nullable
          String content,
      @nullable
          String remoteId,
      @JsonKey(fromJson: ModelUtils.mapToUploadedFile, toJson: ModelUtils.uploadedFileToJson)
      @nullable
          UploadedFile file,
      bool read}) = _$_ChatMessage;

  factory _ChatMessage.fromJson(Map<String, dynamic> json) =
      _$_ChatMessage.fromJson;

  @override
  @JsonKey(
      fromJson: _ChatMessageTypeHelper.stringToEnum,
      toJson: _ChatMessageTypeHelper.enumToString)
  ChatMessageType get type;
  @override
  @nullable
  String get chatId;
  @override
  @nullable
  List<String> get participantsIds;
  @override
  String get senderId;
  @override
  String get receiverId;
  @override
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  DateTime get createdAt;
  @override
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  @nullable
  DateTime get deletedAt;
  @override
  @nullable
  String get content;
  @override
  @nullable
  String get remoteId;
  @override
  @JsonKey(
      fromJson: ModelUtils.mapToUploadedFile,
      toJson: ModelUtils.uploadedFileToJson)
  @nullable
  UploadedFile get file;
  @override
  bool get read;
  @override
  @JsonKey(ignore: true)
  _$ChatMessageCopyWith<_ChatMessage> get copyWith;
}
