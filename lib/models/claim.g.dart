// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Claim _$_$_ClaimFromJson(Map<String, dynamic> json) {
  return _$_Claim(
    goalId: json['goalId'] as String,
    authorId: json['authorId'] as String,
    createdAt: ModelUtils.millisecondsToDateTime(json['createdAt'] as int),
    goalType: _$enumDecodeNullable(_$GoalTypeEnumMap, json['goalType']),
    points: json['points'] as int ?? 0,
    remoteId: json['remoteId'] as String,
  );
}

Map<String, dynamic> _$_$_ClaimToJson(_$_Claim instance) => <String, dynamic>{
      'goalId': instance.goalId,
      'authorId': instance.authorId,
      'createdAt': ModelUtils.dateTimeToMilliseconds(instance.createdAt),
      'goalType': _$GoalTypeEnumMap[instance.goalType],
      'points': instance.points,
      'remoteId': instance.remoteId,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$GoalTypeEnumMap = {
  GoalType.pro: 'pro',
  GoalType.classic: 'classic',
};
