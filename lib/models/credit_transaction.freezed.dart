// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'credit_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
CreditTransaction _$CreditTransactionFromJson(Map<String, dynamic> json) {
  return _CreditTransaction.fromJson(json);
}

/// @nodoc
class _$CreditTransactionTearOff {
  const _$CreditTransactionTearOff();

// ignore: unused_element
  _CreditTransaction call(
      {@required
          int previous,
      @required
          int current,
      @required
          int transactionValue,
      @required
      @JsonKey(fromJson: ModelUtils.creditTransactionTypeValueToEnum, toJson: ModelUtils.creditTransactionTypeToValue)
          CreditTransactionType transactionType,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @required
          String ownerId,
      @nullable
          String remoteId}) {
    return _CreditTransaction(
      previous: previous,
      current: current,
      transactionValue: transactionValue,
      transactionType: transactionType,
      createdAt: createdAt,
      ownerId: ownerId,
      remoteId: remoteId,
    );
  }

// ignore: unused_element
  CreditTransaction fromJson(Map<String, Object> json) {
    return CreditTransaction.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $CreditTransaction = _$CreditTransactionTearOff();

/// @nodoc
mixin _$CreditTransaction {
  int get previous;
  int get current;
  int get transactionValue;
  @JsonKey(
      fromJson: ModelUtils.creditTransactionTypeValueToEnum,
      toJson: ModelUtils.creditTransactionTypeToValue)
  CreditTransactionType get transactionType;
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  DateTime get createdAt;
  String get ownerId;
  @nullable
  String get remoteId;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $CreditTransactionCopyWith<CreditTransaction> get copyWith;
}

/// @nodoc
abstract class $CreditTransactionCopyWith<$Res> {
  factory $CreditTransactionCopyWith(
          CreditTransaction value, $Res Function(CreditTransaction) then) =
      _$CreditTransactionCopyWithImpl<$Res>;
  $Res call(
      {int previous,
      int current,
      int transactionValue,
      @JsonKey(fromJson: ModelUtils.creditTransactionTypeValueToEnum, toJson: ModelUtils.creditTransactionTypeToValue)
          CreditTransactionType transactionType,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      String ownerId,
      @nullable
          String remoteId});
}

/// @nodoc
class _$CreditTransactionCopyWithImpl<$Res>
    implements $CreditTransactionCopyWith<$Res> {
  _$CreditTransactionCopyWithImpl(this._value, this._then);

  final CreditTransaction _value;
  // ignore: unused_field
  final $Res Function(CreditTransaction) _then;

  @override
  $Res call({
    Object previous = freezed,
    Object current = freezed,
    Object transactionValue = freezed,
    Object transactionType = freezed,
    Object createdAt = freezed,
    Object ownerId = freezed,
    Object remoteId = freezed,
  }) {
    return _then(_value.copyWith(
      previous: previous == freezed ? _value.previous : previous as int,
      current: current == freezed ? _value.current : current as int,
      transactionValue: transactionValue == freezed
          ? _value.transactionValue
          : transactionValue as int,
      transactionType: transactionType == freezed
          ? _value.transactionType
          : transactionType as CreditTransactionType,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      ownerId: ownerId == freezed ? _value.ownerId : ownerId as String,
      remoteId: remoteId == freezed ? _value.remoteId : remoteId as String,
    ));
  }
}

/// @nodoc
abstract class _$CreditTransactionCopyWith<$Res>
    implements $CreditTransactionCopyWith<$Res> {
  factory _$CreditTransactionCopyWith(
          _CreditTransaction value, $Res Function(_CreditTransaction) then) =
      __$CreditTransactionCopyWithImpl<$Res>;
  @override
  $Res call(
      {int previous,
      int current,
      int transactionValue,
      @JsonKey(fromJson: ModelUtils.creditTransactionTypeValueToEnum, toJson: ModelUtils.creditTransactionTypeToValue)
          CreditTransactionType transactionType,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      String ownerId,
      @nullable
          String remoteId});
}

/// @nodoc
class __$CreditTransactionCopyWithImpl<$Res>
    extends _$CreditTransactionCopyWithImpl<$Res>
    implements _$CreditTransactionCopyWith<$Res> {
  __$CreditTransactionCopyWithImpl(
      _CreditTransaction _value, $Res Function(_CreditTransaction) _then)
      : super(_value, (v) => _then(v as _CreditTransaction));

  @override
  _CreditTransaction get _value => super._value as _CreditTransaction;

  @override
  $Res call({
    Object previous = freezed,
    Object current = freezed,
    Object transactionValue = freezed,
    Object transactionType = freezed,
    Object createdAt = freezed,
    Object ownerId = freezed,
    Object remoteId = freezed,
  }) {
    return _then(_CreditTransaction(
      previous: previous == freezed ? _value.previous : previous as int,
      current: current == freezed ? _value.current : current as int,
      transactionValue: transactionValue == freezed
          ? _value.transactionValue
          : transactionValue as int,
      transactionType: transactionType == freezed
          ? _value.transactionType
          : transactionType as CreditTransactionType,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      ownerId: ownerId == freezed ? _value.ownerId : ownerId as String,
      remoteId: remoteId == freezed ? _value.remoteId : remoteId as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_CreditTransaction
    with DiagnosticableTreeMixin
    implements _CreditTransaction {
  _$_CreditTransaction(
      {@required
          this.previous,
      @required
          this.current,
      @required
          this.transactionValue,
      @required
      @JsonKey(fromJson: ModelUtils.creditTransactionTypeValueToEnum, toJson: ModelUtils.creditTransactionTypeToValue)
          this.transactionType,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          this.createdAt,
      @required
          this.ownerId,
      @nullable
          this.remoteId})
      : assert(previous != null),
        assert(current != null),
        assert(transactionValue != null),
        assert(transactionType != null),
        assert(createdAt != null),
        assert(ownerId != null);

  factory _$_CreditTransaction.fromJson(Map<String, dynamic> json) =>
      _$_$_CreditTransactionFromJson(json);

  @override
  final int previous;
  @override
  final int current;
  @override
  final int transactionValue;
  @override
  @JsonKey(
      fromJson: ModelUtils.creditTransactionTypeValueToEnum,
      toJson: ModelUtils.creditTransactionTypeToValue)
  final CreditTransactionType transactionType;
  @override
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  final DateTime createdAt;
  @override
  final String ownerId;
  @override
  @nullable
  final String remoteId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreditTransaction(previous: $previous, current: $current, transactionValue: $transactionValue, transactionType: $transactionType, createdAt: $createdAt, ownerId: $ownerId, remoteId: $remoteId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreditTransaction'))
      ..add(DiagnosticsProperty('previous', previous))
      ..add(DiagnosticsProperty('current', current))
      ..add(DiagnosticsProperty('transactionValue', transactionValue))
      ..add(DiagnosticsProperty('transactionType', transactionType))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('ownerId', ownerId))
      ..add(DiagnosticsProperty('remoteId', remoteId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CreditTransaction &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality()
                    .equals(other.previous, previous)) &&
            (identical(other.current, current) ||
                const DeepCollectionEquality()
                    .equals(other.current, current)) &&
            (identical(other.transactionValue, transactionValue) ||
                const DeepCollectionEquality()
                    .equals(other.transactionValue, transactionValue)) &&
            (identical(other.transactionType, transactionType) ||
                const DeepCollectionEquality()
                    .equals(other.transactionType, transactionType)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.ownerId, ownerId) ||
                const DeepCollectionEquality()
                    .equals(other.ownerId, ownerId)) &&
            (identical(other.remoteId, remoteId) ||
                const DeepCollectionEquality()
                    .equals(other.remoteId, remoteId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(current) ^
      const DeepCollectionEquality().hash(transactionValue) ^
      const DeepCollectionEquality().hash(transactionType) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(ownerId) ^
      const DeepCollectionEquality().hash(remoteId);

  @JsonKey(ignore: true)
  @override
  _$CreditTransactionCopyWith<_CreditTransaction> get copyWith =>
      __$CreditTransactionCopyWithImpl<_CreditTransaction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CreditTransactionToJson(this);
  }
}

abstract class _CreditTransaction implements CreditTransaction {
  factory _CreditTransaction(
      {@required
          int previous,
      @required
          int current,
      @required
          int transactionValue,
      @required
      @JsonKey(fromJson: ModelUtils.creditTransactionTypeValueToEnum, toJson: ModelUtils.creditTransactionTypeToValue)
          CreditTransactionType transactionType,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @required
          String ownerId,
      @nullable
          String remoteId}) = _$_CreditTransaction;

  factory _CreditTransaction.fromJson(Map<String, dynamic> json) =
      _$_CreditTransaction.fromJson;

  @override
  int get previous;
  @override
  int get current;
  @override
  int get transactionValue;
  @override
  @JsonKey(
      fromJson: ModelUtils.creditTransactionTypeValueToEnum,
      toJson: ModelUtils.creditTransactionTypeToValue)
  CreditTransactionType get transactionType;
  @override
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  DateTime get createdAt;
  @override
  String get ownerId;
  @override
  @nullable
  String get remoteId;
  @override
  @JsonKey(ignore: true)
  _$CreditTransactionCopyWith<_CreditTransaction> get copyWith;
}
