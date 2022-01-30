import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:yulli/models/status.dart';
import 'package:yulli/models/uploaded_file.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/utils/models_utils.dart';

part 'goal.freezed.dart';
part 'goal.g.dart';

enum GoalType {
  pro,
  classic,
}

class GoalTypeValue {
  static const pro = "pro";
  static const classic = "classic";
}

extension GoalTypeExtension on GoalType {
  bool get isIdle => this == null;
  bool get isPro => this == GoalType.pro;
  bool get isClassic => this == GoalType.classic;
}

@freezed
abstract class Goal with _$Goal {
  factory Goal({
    @required
        String name,
    @nullable
        String description,
    @required
        bool isMystery,
    @Default(0)
    @nullable
        int points,
    @required
    @JsonKey(
      fromJson: ModelUtils.statusValueToEnum,
      toJson: ModelUtils.statusEnumToValue,
    )
        Status status,
    @required
        String authorId,
    @nullable
        List<String> referer,
    @nullable
        List<String> assignees,
    @required
    @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds,
    )
        DateTime createdAt,
    @required
    @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds,
    )
        DateTime updatedAt,
    @nullable
    @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds,
    )
        DateTime duedate,
    @nullable
        String remoteId,
    @nullable
        List<String> tasksIds,
    @nullable
        List<User> refererUsers,
    @nullable
        List<User> assigneesUsers,
    @nullable
    @JsonKey(
      fromJson: ModelUtils.goalTypeValueToEnum,
      toJson: ModelUtils.goalTypeToValue,
    )
        GoalType goalType,
    @Default(false)
    @nullable
        bool hasBeenClaimAtLeastOnce,
    @JsonKey(
      fromJson: ModelUtils.mapToUploadedFilesList,
      toJson: ModelUtils.uploadedFilesListToJson,
    )
    @nullable
        List<UploadedFile> files,
  }) = _Goal;

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);

  @late
  bool get isNew =>
      createdAt != null &&
      DateTime.now().subtract(const Duration(minutes: 60)).isBefore(createdAt);
}

extension TaskExtension on Goal {
  bool isUserAssigned(String userId) =>
      this.assignees.any((assignee) => assignee == userId);

  bool isAuthor(String userId) => this.authorId == userId;

  bool isReferer(String userId) =>
      this.referer.any((element) => element == userId);

  bool get isPro => this.tasksIds.isNotEmpty;

  bool canEdit(String userId) {
    if (this.isAuthor(userId)) {
      if (this.isUserAssigned(userId)) {
        return this.status == Status.pending;
      }
      return !this.hasBeenClaimAtLeastOnce;
    }
    return false;
  }
}
