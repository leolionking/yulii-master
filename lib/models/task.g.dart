// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Task _$_$_TaskFromJson(Map<String, dynamic> json) {
  return _$_Task(
    name: json['name'] as String,
    description: json['description'] as String,
    points: json['points'] as int,
    authorId: json['authorId'] as String,
    assignees: (json['assignees'] as List)?.map((e) => e as String)?.toList(),
    createdAt: ModelUtils.millisecondsToDateTime(json['createdAt'] as int),
    updatedAt: ModelUtils.millisecondsToDateTime(json['updatedAt'] as int),
    status: ModelUtils.statusValueToEnum(json['status'] as String),
    dueDate: ModelUtils.millisecondsToDateTime(json['dueDate'] as int),
    assigneesUsers: (json['assigneesUsers'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    goalId: json['goalId'] as String,
    goal: json['goal'] == null
        ? null
        : Goal.fromJson(json['goal'] as Map<String, dynamic>),
    remoteId: json['remoteId'] as String,
    files: ModelUtils.mapToUploadedFilesList(json['files'] as List),
  );
}

Map<String, dynamic> _$_$_TaskToJson(_$_Task instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'points': instance.points,
      'authorId': instance.authorId,
      'assignees': instance.assignees,
      'createdAt': ModelUtils.dateTimeToMilliseconds(instance.createdAt),
      'updatedAt': ModelUtils.dateTimeToMilliseconds(instance.updatedAt),
      'status': ModelUtils.statusEnumToValue(instance.status),
      'dueDate': ModelUtils.dateTimeToMilliseconds(instance.dueDate),
      'assigneesUsers': instance.assigneesUsers,
      'goalId': instance.goalId,
      'goal': instance.goal,
      'remoteId': instance.remoteId,
      'files': ModelUtils.uploadedFilesListToJson(instance.files),
    };
