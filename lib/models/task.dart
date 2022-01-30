import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:yulli/models/remote_model.dart';
import 'package:yulli/models/status.dart';
import 'package:yulli/models/uploaded_file.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/models/goal.dart';
import 'package:yulli/utils/models_utils.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
abstract class Task with _$Task {
  factory Task({
    @required
        String name,
    @nullable
    @required
        String description,
    @required
        int points,
    @required
        String authorId,
    @required
        List<String> assignees,
    @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds,
    )
    @required
        DateTime createdAt,
    @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds,
    )
    @required
        DateTime updatedAt,
    @JsonKey(
      fromJson: ModelUtils.statusValueToEnum,
      toJson: ModelUtils.statusEnumToValue,
    )
    @required
        Status status,
    @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds,
    )
    @nullable
        DateTime dueDate,
    @nullable
        List<User> assigneesUsers,
    @nullable
        String goalId,
    @nullable
        Goal goal,
    @nullable
        String remoteId,
    @JsonKey(
      fromJson: ModelUtils.mapToUploadedFilesList,
      toJson: ModelUtils.uploadedFilesListToJson,
    )
    @nullable
        List<UploadedFile> files,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  @late
  bool get isLinkedToGoal => this.goalId != null;

  @late
  bool get isNew => createdAt != null && DateTime.now().subtract(const Duration(minutes: 5)).isBefore(createdAt);
}

extension TaskExtension on Task {
  bool isUserAssigned(String userId) =>
      this.assignees.any((assignee) => assignee == userId);
  bool isAuthor(String userId) => this.authorId == userId;
}

extension ListTaskExtension on List<Task> {
  bool get allAreDone => this.every((task) => task.status.isDone);
}
