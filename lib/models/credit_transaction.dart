import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:yulli/utils/models_utils.dart';

part 'credit_transaction.freezed.dart';
part 'credit_transaction.g.dart';

enum CreditTransactionType {
  increase,
  decrease,
  idle,
}

class CreditTransactionTypeValue {
  static const increase = 'increase';
  static const decrease = 'decrease';
}

@freezed
abstract class CreditTransaction with _$CreditTransaction {
  factory CreditTransaction({
    @required
        int previous,
    @required
        int current,
    @required
        int transactionValue,
    @JsonKey(
      fromJson: ModelUtils.creditTransactionTypeValueToEnum,
      toJson: ModelUtils.creditTransactionTypeToValue,
    )
    @required
        CreditTransactionType transactionType,
    @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds,
    )
    @required
        DateTime createdAt,
    @required
        String ownerId,
    @nullable
        String remoteId,
  }) = _CreditTransaction;

  factory CreditTransaction.fromJson(Map<String, dynamic> json) =>
      _$CreditTransactionFromJson(json);

  factory CreditTransaction.createDefault(String ownerId) => CreditTransaction(
        previous: 0,
        current: 0,
        transactionValue: 0,
        transactionType: CreditTransactionType.idle,
        createdAt: DateTime.now(),
        ownerId: ownerId,
        remoteId: null,
      );
}
