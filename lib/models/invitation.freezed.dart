// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'invitation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Invitation _$InvitationFromJson(Map<String, dynamic> json) {
  return _Invitation.fromJson(json);
}

/// @nodoc
class _$InvitationTearOff {
  const _$InvitationTearOff();

// ignore: unused_element
  _Invitation call(
      {@required String sender,
      @required String senderName,
      @nullable String receiverName}) {
    return _Invitation(
      sender: sender,
      senderName: senderName,
      receiverName: receiverName,
    );
  }

// ignore: unused_element
  Invitation fromJson(Map<String, Object> json) {
    return Invitation.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Invitation = _$InvitationTearOff();

/// @nodoc
mixin _$Invitation {
  String get sender;
  String get senderName;
  @nullable
  String get receiverName;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $InvitationCopyWith<Invitation> get copyWith;
}

/// @nodoc
abstract class $InvitationCopyWith<$Res> {
  factory $InvitationCopyWith(
          Invitation value, $Res Function(Invitation) then) =
      _$InvitationCopyWithImpl<$Res>;
  $Res call({String sender, String senderName, @nullable String receiverName});
}

/// @nodoc
class _$InvitationCopyWithImpl<$Res> implements $InvitationCopyWith<$Res> {
  _$InvitationCopyWithImpl(this._value, this._then);

  final Invitation _value;
  // ignore: unused_field
  final $Res Function(Invitation) _then;

  @override
  $Res call({
    Object sender = freezed,
    Object senderName = freezed,
    Object receiverName = freezed,
  }) {
    return _then(_value.copyWith(
      sender: sender == freezed ? _value.sender : sender as String,
      senderName:
          senderName == freezed ? _value.senderName : senderName as String,
      receiverName: receiverName == freezed
          ? _value.receiverName
          : receiverName as String,
    ));
  }
}

/// @nodoc
abstract class _$InvitationCopyWith<$Res> implements $InvitationCopyWith<$Res> {
  factory _$InvitationCopyWith(
          _Invitation value, $Res Function(_Invitation) then) =
      __$InvitationCopyWithImpl<$Res>;
  @override
  $Res call({String sender, String senderName, @nullable String receiverName});
}

/// @nodoc
class __$InvitationCopyWithImpl<$Res> extends _$InvitationCopyWithImpl<$Res>
    implements _$InvitationCopyWith<$Res> {
  __$InvitationCopyWithImpl(
      _Invitation _value, $Res Function(_Invitation) _then)
      : super(_value, (v) => _then(v as _Invitation));

  @override
  _Invitation get _value => super._value as _Invitation;

  @override
  $Res call({
    Object sender = freezed,
    Object senderName = freezed,
    Object receiverName = freezed,
  }) {
    return _then(_Invitation(
      sender: sender == freezed ? _value.sender : sender as String,
      senderName:
          senderName == freezed ? _value.senderName : senderName as String,
      receiverName: receiverName == freezed
          ? _value.receiverName
          : receiverName as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Invitation with DiagnosticableTreeMixin implements _Invitation {
  _$_Invitation(
      {@required this.sender,
      @required this.senderName,
      @nullable this.receiverName})
      : assert(sender != null),
        assert(senderName != null);

  factory _$_Invitation.fromJson(Map<String, dynamic> json) =>
      _$_$_InvitationFromJson(json);

  @override
  final String sender;
  @override
  final String senderName;
  @override
  @nullable
  final String receiverName;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Invitation(sender: $sender, senderName: $senderName, receiverName: $receiverName)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Invitation'))
      ..add(DiagnosticsProperty('sender', sender))
      ..add(DiagnosticsProperty('senderName', senderName))
      ..add(DiagnosticsProperty('receiverName', receiverName));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Invitation &&
            (identical(other.sender, sender) ||
                const DeepCollectionEquality().equals(other.sender, sender)) &&
            (identical(other.senderName, senderName) ||
                const DeepCollectionEquality()
                    .equals(other.senderName, senderName)) &&
            (identical(other.receiverName, receiverName) ||
                const DeepCollectionEquality()
                    .equals(other.receiverName, receiverName)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(sender) ^
      const DeepCollectionEquality().hash(senderName) ^
      const DeepCollectionEquality().hash(receiverName);

  @JsonKey(ignore: true)
  @override
  _$InvitationCopyWith<_Invitation> get copyWith =>
      __$InvitationCopyWithImpl<_Invitation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_InvitationToJson(this);
  }
}

abstract class _Invitation implements Invitation {
  factory _Invitation(
      {@required String sender,
      @required String senderName,
      @nullable String receiverName}) = _$_Invitation;

  factory _Invitation.fromJson(Map<String, dynamic> json) =
      _$_Invitation.fromJson;

  @override
  String get sender;
  @override
  String get senderName;
  @override
  @nullable
  String get receiverName;
  @override
  @JsonKey(ignore: true)
  _$InvitationCopyWith<_Invitation> get copyWith;
}
