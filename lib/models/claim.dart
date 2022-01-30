import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yulli/models/goal.dart';
import 'package:flutter/foundation.dart';
import 'package:yulli/utils/models_utils.dart';

part 'claim.freezed.dart';
part 'claim.g.dart';

@freezed
abstract class Claim with _$Claim {
  factory Claim({
    @required
        String goalId,
    @required
        String authorId,
    @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds,
    )
    @required
        DateTime createdAt,
    @required
        GoalType goalType,
    @Default(0)
    @nullable
        int points,
    @nullable
        String remoteId,
  }) = _Claim;

  factory Claim.fromJson(Map<String, dynamic> json) => _$ClaimFromJson(json);
}
