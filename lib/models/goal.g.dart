// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Goal _$_$_GoalFromJson(Map<String, dynamic> json) {
  return _$_Goal(
    name: json['name'] as String,
    description: json['description'] as String,
    isMystery: json['isMystery'] as bool,
    points: json['points'] as int ?? 0,
    status: ModelUtils.statusValueToEnum(json['status'] as String),
    authorId: json['authorId'] as String,
    referer: (json['referer'] as List)?.map((e) => e as String)?.toList(),
    assignees: (json['assignees'] as List)?.map((e) => e as String)?.toList(),
    createdAt: ModelUtils.millisecondsToDateTime(json['createdAt'] as int),
    updatedAt: ModelUtils.millisecondsToDateTime(json['updatedAt'] as int),
    duedate: ModelUtils.millisecondsToDateTime(json['duedate'] as int),
    remoteId: json['remoteId'] as String,
    tasksIds: (json['tasksIds'] as List)?.map((e) => e as String)?.toList(),
    refererUsers: (json['refererUsers'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    assigneesUsers: (json['assigneesUsers'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    goalType: ModelUtils.goalTypeValueToEnum(json['goalType'] as String),
    hasBeenClaimAtLeastOnce: json['hasBeenClaimAtLeastOnce'] as bool ?? false,
    files: ModelUtils.mapToUploadedFilesList(json['files'] as List),
  );
}

Map<String, dynamic> _$_$_GoalToJson(_$_Goal instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'isMystery': instance.isMystery,
      'points': instance.points,
      'status': ModelUtils.statusEnumToValue(instance.status),
      'authorId': instance.authorId,
      'referer': instance.referer,
      'assignees': instance.assignees,
      'createdAt': ModelUtils.dateTimeToMilliseconds(instance.createdAt),
      'updatedAt': ModelUtils.dateTimeToMilliseconds(instance.updatedAt),
      'duedate': ModelUtils.dateTimeToMilliseconds(instance.duedate),
      'remoteId': instance.remoteId,
      'tasksIds': instance.tasksIds,
      'refererUsers': instance.refererUsers,
      'assigneesUsers': instance.assigneesUsers,
      'goalType': ModelUtils.goalTypeToValue(instance.goalType),
      'hasBeenClaimAtLeastOnce': instance.hasBeenClaimAtLeastOnce,
      'files': ModelUtils.uploadedFilesListToJson(instance.files),
    };
