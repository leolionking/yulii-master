// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'claim.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Claim _$ClaimFromJson(Map<String, dynamic> json) {
  return _Claim.fromJson(json);
}

/// @nodoc
class _$ClaimTearOff {
  const _$ClaimTearOff();

// ignore: unused_element
  _Claim call(
      {@required
          String goalId,
      @required
          String authorId,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @required
          GoalType goalType,
      @nullable
          int points = 0,
      @nullable
          String remoteId}) {
    return _Claim(
      goalId: goalId,
      authorId: authorId,
      createdAt: createdAt,
      goalType: goalType,
      points: points,
      remoteId: remoteId,
    );
  }

// ignore: unused_element
  Claim fromJson(Map<String, Object> json) {
    return Claim.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Claim = _$ClaimTearOff();

/// @nodoc
mixin _$Claim {
  String get goalId;
  String get authorId;
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  DateTime get createdAt;
  GoalType get goalType;
  @nullable
  int get points;
  @nullable
  String get remoteId;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $ClaimCopyWith<Claim> get copyWith;
}

/// @nodoc
abstract class $ClaimCopyWith<$Res> {
  factory $ClaimCopyWith(Claim value, $Res Function(Claim) then) =
      _$ClaimCopyWithImpl<$Res>;
  $Res call(
      {String goalId,
      String authorId,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      GoalType goalType,
      @nullable
          int points,
      @nullable
          String remoteId});
}

/// @nodoc
class _$ClaimCopyWithImpl<$Res> implements $ClaimCopyWith<$Res> {
  _$ClaimCopyWithImpl(this._value, this._then);

  final Claim _value;
  // ignore: unused_field
  final $Res Function(Claim) _then;

  @override
  $Res call({
    Object goalId = freezed,
    Object authorId = freezed,
    Object createdAt = freezed,
    Object goalType = freezed,
    Object points = freezed,
    Object remoteId = freezed,
  }) {
    return _then(_value.copyWith(
      goalId: goalId == freezed ? _value.goalId : goalId as String,
      authorId: authorId == freezed ? _value.authorId : authorId as String,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      goalType: goalType == freezed ? _value.goalType : goalType as GoalType,
      points: points == freezed ? _value.points : points as int,
      remoteId: remoteId == freezed ? _value.remoteId : remoteId as String,
    ));
  }
}

/// @nodoc
abstract class _$ClaimCopyWith<$Res> implements $ClaimCopyWith<$Res> {
  factory _$ClaimCopyWith(_Claim value, $Res Function(_Claim) then) =
      __$ClaimCopyWithImpl<$Res>;
  @override
  $Res call(
      {String goalId,
      String authorId,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      GoalType goalType,
      @nullable
          int points,
      @nullable
          String remoteId});
}

/// @nodoc
class __$ClaimCopyWithImpl<$Res> extends _$ClaimCopyWithImpl<$Res>
    implements _$ClaimCopyWith<$Res> {
  __$ClaimCopyWithImpl(_Claim _value, $Res Function(_Claim) _then)
      : super(_value, (v) => _then(v as _Claim));

  @override
  _Claim get _value => super._value as _Claim;

  @override
  $Res call({
    Object goalId = freezed,
    Object authorId = freezed,
    Object createdAt = freezed,
    Object goalType = freezed,
    Object points = freezed,
    Object remoteId = freezed,
  }) {
    return _then(_Claim(
      goalId: goalId == freezed ? _value.goalId : goalId as String,
      authorId: authorId == freezed ? _value.authorId : authorId as String,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      goalType: goalType == freezed ? _value.goalType : goalType as GoalType,
      points: points == freezed ? _value.points : points as int,
      remoteId: remoteId == freezed ? _value.remoteId : remoteId as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Claim with DiagnosticableTreeMixin implements _Claim {
  _$_Claim(
      {@required
          this.goalId,
      @required
          this.authorId,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          this.createdAt,
      @required
          this.goalType,
      @nullable
          this.points = 0,
      @nullable
          this.remoteId})
      : assert(goalId != null),
        assert(authorId != null),
        assert(createdAt != null),
        assert(goalType != null);

  factory _$_Claim.fromJson(Map<String, dynamic> json) =>
      _$_$_ClaimFromJson(json);

  @override
  final String goalId;
  @override
  final String authorId;
  @override
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  final DateTime createdAt;
  @override
  final GoalType goalType;
  @JsonKey(defaultValue: 0)
  @override
  @nullable
  final int points;
  @override
  @nullable
  final String remoteId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Claim(goalId: $goalId, authorId: $authorId, createdAt: $createdAt, goalType: $goalType, points: $points, remoteId: $remoteId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Claim'))
      ..add(DiagnosticsProperty('goalId', goalId))
      ..add(DiagnosticsProperty('authorId', authorId))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('goalType', goalType))
      ..add(DiagnosticsProperty('points', points))
      ..add(DiagnosticsProperty('remoteId', remoteId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Claim &&
            (identical(other.goalId, goalId) ||
                const DeepCollectionEquality().equals(other.goalId, goalId)) &&
            (identical(other.authorId, authorId) ||
                const DeepCollectionEquality()
                    .equals(other.authorId, authorId)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.goalType, goalType) ||
                const DeepCollectionEquality()
                    .equals(other.goalType, goalType)) &&
            (identical(other.points, points) ||
                const DeepCollectionEquality().equals(other.points, points)) &&
            (identical(other.remoteId, remoteId) ||
                const DeepCollectionEquality()
                    .equals(other.remoteId, remoteId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(goalId) ^
      const DeepCollectionEquality().hash(authorId) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(goalType) ^
      const DeepCollectionEquality().hash(points) ^
      const DeepCollectionEquality().hash(remoteId);

  @JsonKey(ignore: true)
  @override
  _$ClaimCopyWith<_Claim> get copyWith =>
      __$ClaimCopyWithImpl<_Claim>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ClaimToJson(this);
  }
}

abstract class _Claim implements Claim {
  factory _Claim(
      {@required
          String goalId,
      @required
          String authorId,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @required
          GoalType goalType,
      @nullable
          int points,
      @nullable
          String remoteId}) = _$_Claim;

  factory _Claim.fromJson(Map<String, dynamic> json) = _$_Claim.fromJson;

  @override
  String get goalId;
  @override
  String get authorId;
  @override
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  DateTime get createdAt;
  @override
  GoalType get goalType;
  @override
  @nullable
  int get points;
  @override
  @nullable
  String get remoteId;
  @override
  @JsonKey(ignore: true)
  _$ClaimCopyWith<_Claim> get copyWith;
}
