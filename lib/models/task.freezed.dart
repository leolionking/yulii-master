// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Task _$TaskFromJson(Map<String, dynamic> json) {
  return _Task.fromJson(json);
}

/// @nodoc
class _$TaskTearOff {
  const _$TaskTearOff();

// ignore: unused_element
  _Task call(
      {@required
          String name,
      @required
      @nullable
          String description,
      @required
          int points,
      @required
          String authorId,
      @required
          List<String> assignees,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime updatedAt,
      @required
      @JsonKey(fromJson: ModelUtils.statusValueToEnum, toJson: ModelUtils.statusEnumToValue)
          Status status,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
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
      @JsonKey(fromJson: ModelUtils.mapToUploadedFilesList, toJson: ModelUtils.uploadedFilesListToJson)
      @nullable
          List<UploadedFile> files}) {
    return _Task(
      name: name,
      description: description,
      points: points,
      authorId: authorId,
      assignees: assignees,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status,
      dueDate: dueDate,
      assigneesUsers: assigneesUsers,
      goalId: goalId,
      goal: goal,
      remoteId: remoteId,
      files: files,
    );
  }

// ignore: unused_element
  Task fromJson(Map<String, Object> json) {
    return Task.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Task = _$TaskTearOff();

/// @nodoc
mixin _$Task {
  String get name;
  @nullable
  String get description;
  int get points;
  String get authorId;
  List<String> get assignees;
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  DateTime get createdAt;
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  DateTime get updatedAt;
  @JsonKey(
      fromJson: ModelUtils.statusValueToEnum,
      toJson: ModelUtils.statusEnumToValue)
  Status get status;
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  @nullable
  DateTime get dueDate;
  @nullable
  List<User> get assigneesUsers;
  @nullable
  String get goalId;
  @nullable
  Goal get goal;
  @nullable
  String get remoteId;
  @JsonKey(
      fromJson: ModelUtils.mapToUploadedFilesList,
      toJson: ModelUtils.uploadedFilesListToJson)
  @nullable
  List<UploadedFile> get files;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $TaskCopyWith<Task> get copyWith;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) =
      _$TaskCopyWithImpl<$Res>;
  $Res call(
      {String name,
      @nullable
          String description,
      int points,
      String authorId,
      List<String> assignees,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime updatedAt,
      @JsonKey(fromJson: ModelUtils.statusValueToEnum, toJson: ModelUtils.statusEnumToValue)
          Status status,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
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
      @JsonKey(fromJson: ModelUtils.mapToUploadedFilesList, toJson: ModelUtils.uploadedFilesListToJson)
      @nullable
          List<UploadedFile> files});

  $GoalCopyWith<$Res> get goal;
}

/// @nodoc
class _$TaskCopyWithImpl<$Res> implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  final Task _value;
  // ignore: unused_field
  final $Res Function(Task) _then;

  @override
  $Res call({
    Object name = freezed,
    Object description = freezed,
    Object points = freezed,
    Object authorId = freezed,
    Object assignees = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
    Object status = freezed,
    Object dueDate = freezed,
    Object assigneesUsers = freezed,
    Object goalId = freezed,
    Object goal = freezed,
    Object remoteId = freezed,
    Object files = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed ? _value.name : name as String,
      description:
          description == freezed ? _value.description : description as String,
      points: points == freezed ? _value.points : points as int,
      authorId: authorId == freezed ? _value.authorId : authorId as String,
      assignees:
          assignees == freezed ? _value.assignees : assignees as List<String>,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      updatedAt:
          updatedAt == freezed ? _value.updatedAt : updatedAt as DateTime,
      status: status == freezed ? _value.status : status as Status,
      dueDate: dueDate == freezed ? _value.dueDate : dueDate as DateTime,
      assigneesUsers: assigneesUsers == freezed
          ? _value.assigneesUsers
          : assigneesUsers as List<User>,
      goalId: goalId == freezed ? _value.goalId : goalId as String,
      goal: goal == freezed ? _value.goal : goal as Goal,
      remoteId: remoteId == freezed ? _value.remoteId : remoteId as String,
      files: files == freezed ? _value.files : files as List<UploadedFile>,
    ));
  }

  @override
  $GoalCopyWith<$Res> get goal {
    if (_value.goal == null) {
      return null;
    }
    return $GoalCopyWith<$Res>(_value.goal, (value) {
      return _then(_value.copyWith(goal: value));
    });
  }
}

/// @nodoc
abstract class _$TaskCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$TaskCopyWith(_Task value, $Res Function(_Task) then) =
      __$TaskCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      @nullable
          String description,
      int points,
      String authorId,
      List<String> assignees,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime updatedAt,
      @JsonKey(fromJson: ModelUtils.statusValueToEnum, toJson: ModelUtils.statusEnumToValue)
          Status status,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
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
      @JsonKey(fromJson: ModelUtils.mapToUploadedFilesList, toJson: ModelUtils.uploadedFilesListToJson)
      @nullable
          List<UploadedFile> files});

  @override
  $GoalCopyWith<$Res> get goal;
}

/// @nodoc
class __$TaskCopyWithImpl<$Res> extends _$TaskCopyWithImpl<$Res>
    implements _$TaskCopyWith<$Res> {
  __$TaskCopyWithImpl(_Task _value, $Res Function(_Task) _then)
      : super(_value, (v) => _then(v as _Task));

  @override
  _Task get _value => super._value as _Task;

  @override
  $Res call({
    Object name = freezed,
    Object description = freezed,
    Object points = freezed,
    Object authorId = freezed,
    Object assignees = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
    Object status = freezed,
    Object dueDate = freezed,
    Object assigneesUsers = freezed,
    Object goalId = freezed,
    Object goal = freezed,
    Object remoteId = freezed,
    Object files = freezed,
  }) {
    return _then(_Task(
      name: name == freezed ? _value.name : name as String,
      description:
          description == freezed ? _value.description : description as String,
      points: points == freezed ? _value.points : points as int,
      authorId: authorId == freezed ? _value.authorId : authorId as String,
      assignees:
          assignees == freezed ? _value.assignees : assignees as List<String>,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      updatedAt:
          updatedAt == freezed ? _value.updatedAt : updatedAt as DateTime,
      status: status == freezed ? _value.status : status as Status,
      dueDate: dueDate == freezed ? _value.dueDate : dueDate as DateTime,
      assigneesUsers: assigneesUsers == freezed
          ? _value.assigneesUsers
          : assigneesUsers as List<User>,
      goalId: goalId == freezed ? _value.goalId : goalId as String,
      goal: goal == freezed ? _value.goal : goal as Goal,
      remoteId: remoteId == freezed ? _value.remoteId : remoteId as String,
      files: files == freezed ? _value.files : files as List<UploadedFile>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Task with DiagnosticableTreeMixin implements _Task {
  _$_Task(
      {@required
          this.name,
      @required
      @nullable
          this.description,
      @required
          this.points,
      @required
          this.authorId,
      @required
          this.assignees,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          this.createdAt,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          this.updatedAt,
      @required
      @JsonKey(fromJson: ModelUtils.statusValueToEnum, toJson: ModelUtils.statusEnumToValue)
          this.status,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
      @nullable
          this.dueDate,
      @nullable
          this.assigneesUsers,
      @nullable
          this.goalId,
      @nullable
          this.goal,
      @nullable
          this.remoteId,
      @JsonKey(fromJson: ModelUtils.mapToUploadedFilesList, toJson: ModelUtils.uploadedFilesListToJson)
      @nullable
          this.files})
      : assert(name != null),
        assert(points != null),
        assert(authorId != null),
        assert(assignees != null),
        assert(createdAt != null),
        assert(updatedAt != null),
        assert(status != null);

  factory _$_Task.fromJson(Map<String, dynamic> json) =>
      _$_$_TaskFromJson(json);

  @override
  final String name;
  @override
  @nullable
  final String description;
  @override
  final int points;
  @override
  final String authorId;
  @override
  final List<String> assignees;
  @override
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  final DateTime createdAt;
  @override
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  final DateTime updatedAt;
  @override
  @JsonKey(
      fromJson: ModelUtils.statusValueToEnum,
      toJson: ModelUtils.statusEnumToValue)
  final Status status;
  @override
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  @nullable
  final DateTime dueDate;
  @override
  @nullable
  final List<User> assigneesUsers;
  @override
  @nullable
  final String goalId;
  @override
  @nullable
  final Goal goal;
  @override
  @nullable
  final String remoteId;
  @override
  @JsonKey(
      fromJson: ModelUtils.mapToUploadedFilesList,
      toJson: ModelUtils.uploadedFilesListToJson)
  @nullable
  final List<UploadedFile> files;

  bool _didisLinkedToGoal = false;
  bool _isLinkedToGoal;

  @override
  bool get isLinkedToGoal {
    if (_didisLinkedToGoal == false) {
      _didisLinkedToGoal = true;
      _isLinkedToGoal = this.goalId != null;
    }
    return _isLinkedToGoal;
  }

  bool _didisNew = false;
  bool _isNew;

  @override
  bool get isNew {
    if (_didisNew == false) {
      _didisNew = true;
      _isNew = createdAt != null &&
          DateTime.now()
              .subtract(const Duration(minutes: 5))
              .isBefore(createdAt);
    }
    return _isNew;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Task(name: $name, description: $description, points: $points, authorId: $authorId, assignees: $assignees, createdAt: $createdAt, updatedAt: $updatedAt, status: $status, dueDate: $dueDate, assigneesUsers: $assigneesUsers, goalId: $goalId, goal: $goal, remoteId: $remoteId, files: $files, isLinkedToGoal: $isLinkedToGoal, isNew: $isNew)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Task'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('points', points))
      ..add(DiagnosticsProperty('authorId', authorId))
      ..add(DiagnosticsProperty('assignees', assignees))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('dueDate', dueDate))
      ..add(DiagnosticsProperty('assigneesUsers', assigneesUsers))
      ..add(DiagnosticsProperty('goalId', goalId))
      ..add(DiagnosticsProperty('goal', goal))
      ..add(DiagnosticsProperty('remoteId', remoteId))
      ..add(DiagnosticsProperty('files', files))
      ..add(DiagnosticsProperty('isLinkedToGoal', isLinkedToGoal))
      ..add(DiagnosticsProperty('isNew', isNew));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Task &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.points, points) ||
                const DeepCollectionEquality().equals(other.points, points)) &&
            (identical(other.authorId, authorId) ||
                const DeepCollectionEquality()
                    .equals(other.authorId, authorId)) &&
            (identical(other.assignees, assignees) ||
                const DeepCollectionEquality()
                    .equals(other.assignees, assignees)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.dueDate, dueDate) ||
                const DeepCollectionEquality()
                    .equals(other.dueDate, dueDate)) &&
            (identical(other.assigneesUsers, assigneesUsers) ||
                const DeepCollectionEquality()
                    .equals(other.assigneesUsers, assigneesUsers)) &&
            (identical(other.goalId, goalId) ||
                const DeepCollectionEquality().equals(other.goalId, goalId)) &&
            (identical(other.goal, goal) ||
                const DeepCollectionEquality().equals(other.goal, goal)) &&
            (identical(other.remoteId, remoteId) ||
                const DeepCollectionEquality()
                    .equals(other.remoteId, remoteId)) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(points) ^
      const DeepCollectionEquality().hash(authorId) ^
      const DeepCollectionEquality().hash(assignees) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(dueDate) ^
      const DeepCollectionEquality().hash(assigneesUsers) ^
      const DeepCollectionEquality().hash(goalId) ^
      const DeepCollectionEquality().hash(goal) ^
      const DeepCollectionEquality().hash(remoteId) ^
      const DeepCollectionEquality().hash(files);

  @JsonKey(ignore: true)
  @override
  _$TaskCopyWith<_Task> get copyWith =>
      __$TaskCopyWithImpl<_Task>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_TaskToJson(this);
  }
}

abstract class _Task implements Task {
  factory _Task(
      {@required
          String name,
      @required
      @nullable
          String description,
      @required
          int points,
      @required
          String authorId,
      @required
          List<String> assignees,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime updatedAt,
      @required
      @JsonKey(fromJson: ModelUtils.statusValueToEnum, toJson: ModelUtils.statusEnumToValue)
          Status status,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
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
      @JsonKey(fromJson: ModelUtils.mapToUploadedFilesList, toJson: ModelUtils.uploadedFilesListToJson)
      @nullable
          List<UploadedFile> files}) = _$_Task;

  factory _Task.fromJson(Map<String, dynamic> json) = _$_Task.fromJson;

  @override
  String get name;
  @override
  @nullable
  String get description;
  @override
  int get points;
  @override
  String get authorId;
  @override
  List<String> get assignees;
  @override
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  DateTime get createdAt;
  @override
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  DateTime get updatedAt;
  @override
  @JsonKey(
      fromJson: ModelUtils.statusValueToEnum,
      toJson: ModelUtils.statusEnumToValue)
  Status get status;
  @override
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  @nullable
  DateTime get dueDate;
  @override
  @nullable
  List<User> get assigneesUsers;
  @override
  @nullable
  String get goalId;
  @override
  @nullable
  Goal get goal;
  @override
  @nullable
  String get remoteId;
  @override
  @JsonKey(
      fromJson: ModelUtils.mapToUploadedFilesList,
      toJson: ModelUtils.uploadedFilesListToJson)
  @nullable
  List<UploadedFile> get files;
  @override
  @JsonKey(ignore: true)
  _$TaskCopyWith<_Task> get copyWith;
}
