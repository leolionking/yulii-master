// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CreditTransaction _$_$_CreditTransactionFromJson(Map<String, dynamic> json) {
  return _$_CreditTransaction(
    previous: json['previous'] as int,
    current: json['current'] as int,
    transactionValue: json['transactionValue'] as int,
    transactionType: ModelUtils.creditTransactionTypeValueToEnum(
        json['transactionType'] as String),
    createdAt: ModelUtils.millisecondsToDateTime(json['createdAt'] as int),
    ownerId: json['ownerId'] as String,
    remoteId: json['remoteId'] as String,
  );
}

Map<String, dynamic> _$_$_CreditTransactionToJson(
        _$_CreditTransaction instance) =>
    <String, dynamic>{
      'previous': instance.previous,
      'current': instance.current,
      'transactionValue': instance.transactionValue,
      'transactionType':
          ModelUtils.creditTransactionTypeToValue(instance.transactionType),
      'createdAt': ModelUtils.dateTimeToMilliseconds(instance.createdAt),
      'ownerId': instance.ownerId,
      'remoteId': instance.remoteId,
    };
