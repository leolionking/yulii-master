// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Goal _$GoalFromJson(Map<String, dynamic> json) {
  return _Goal.fromJson(json);
}

/// @nodoc
class _$GoalTearOff {
  const _$GoalTearOff();

// ignore: unused_element
  _Goal call(
      {@required
          String name,
      @nullable
          String description,
      @required
          bool isMystery,
      @nullable
          int points = 0,
      @required
      @JsonKey(fromJson: ModelUtils.statusValueToEnum, toJson: ModelUtils.statusEnumToValue)
          Status status,
      @required
          String authorId,
      @nullable
          List<String> referer,
      @nullable
          List<String> assignees,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime updatedAt,
      @nullable
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
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
      @JsonKey(fromJson: ModelUtils.goalTypeValueToEnum, toJson: ModelUtils.goalTypeToValue)
          GoalType goalType,
      @nullable
          bool hasBeenClaimAtLeastOnce = false,
      @JsonKey(fromJson: ModelUtils.mapToUploadedFilesList, toJson: ModelUtils.uploadedFilesListToJson)
      @nullable
          List<UploadedFile> files}) {
    return _Goal(
      name: name,
      description: description,
      isMystery: isMystery,
      points: points,
      status: status,
      authorId: authorId,
      referer: referer,
      assignees: assignees,
      createdAt: createdAt,
      updatedAt: updatedAt,
      duedate: duedate,
      remoteId: remoteId,
      tasksIds: tasksIds,
      refererUsers: refererUsers,
      assigneesUsers: assigneesUsers,
      goalType: goalType,
      hasBeenClaimAtLeastOnce: hasBeenClaimAtLeastOnce,
      files: files,
    );
  }

// ignore: unused_element
  Goal fromJson(Map<String, Object> json) {
    return Goal.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Goal = _$GoalTearOff();

/// @nodoc
mixin _$Goal {
  String get name;
  @nullable
  String get description;
  bool get isMystery;
  @nullable
  int get points;
  @JsonKey(
      fromJson: ModelUtils.statusValueToEnum,
      toJson: ModelUtils.statusEnumToValue)
  Status get status;
  String get authorId;
  @nullable
  List<String> get referer;
  @nullable
  List<String> get assignees;
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  DateTime get createdAt;
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  DateTime get updatedAt;
  @nullable
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  DateTime get duedate;
  @nullable
  String get remoteId;
  @nullable
  List<String> get tasksIds;
  @nullable
  List<User> get refererUsers;
  @nullable
  List<User> get assigneesUsers;
  @nullable
  @JsonKey(
      fromJson: ModelUtils.goalTypeValueToEnum,
      toJson: ModelUtils.goalTypeToValue)
  GoalType get goalType;
  @nullable
  bool get hasBeenClaimAtLeastOnce;
  @JsonKey(
      fromJson: ModelUtils.mapToUploadedFilesList,
      toJson: ModelUtils.uploadedFilesListToJson)
  @nullable
  List<UploadedFile> get files;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $GoalCopyWith<Goal> get copyWith;
}

/// @nodoc
abstract class $GoalCopyWith<$Res> {
  factory $GoalCopyWith(Goal value, $Res Function(Goal) then) =
      _$GoalCopyWithImpl<$Res>;
  $Res call(
      {String name,
      @nullable
          String description,
      bool isMystery,
      @nullable
          int points,
      @JsonKey(fromJson: ModelUtils.statusValueToEnum, toJson: ModelUtils.statusEnumToValue)
          Status status,
      String authorId,
      @nullable
          List<String> referer,
      @nullable
          List<String> assignees,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime updatedAt,
      @nullable
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
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
      @JsonKey(fromJson: ModelUtils.goalTypeValueToEnum, toJson: ModelUtils.goalTypeToValue)
          GoalType goalType,
      @nullable
          bool hasBeenClaimAtLeastOnce,
      @JsonKey(fromJson: ModelUtils.mapToUploadedFilesList, toJson: ModelUtils.uploadedFilesListToJson)
      @nullable
          List<UploadedFile> files});
}

/// @nodoc
class _$GoalCopyWithImpl<$Res> implements $GoalCopyWith<$Res> {
  _$GoalCopyWithImpl(this._value, this._then);

  final Goal _value;
  // ignore: unused_field
  final $Res Function(Goal) _then;

  @override
  $Res call({
    Object name = freezed,
    Object description = freezed,
    Object isMystery = freezed,
    Object points = freezed,
    Object status = freezed,
    Object authorId = freezed,
    Object referer = freezed,
    Object assignees = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
    Object duedate = freezed,
    Object remoteId = freezed,
    Object tasksIds = freezed,
    Object refererUsers = freezed,
    Object assigneesUsers = freezed,
    Object goalType = freezed,
    Object hasBeenClaimAtLeastOnce = freezed,
    Object files = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed ? _value.name : name as String,
      description:
          description == freezed ? _value.description : description as String,
      isMystery: isMystery == freezed ? _value.isMystery : isMystery as bool,
      points: points == freezed ? _value.points : points as int,
      status: status == freezed ? _value.status : status as Status,
      authorId: authorId == freezed ? _value.authorId : authorId as String,
      referer: referer == freezed ? _value.referer : referer as List<String>,
      assignees:
          assignees == freezed ? _value.assignees : assignees as List<String>,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      updatedAt:
          updatedAt == freezed ? _value.updatedAt : updatedAt as DateTime,
      duedate: duedate == freezed ? _value.duedate : duedate as DateTime,
      remoteId: remoteId == freezed ? _value.remoteId : remoteId as String,
      tasksIds:
          tasksIds == freezed ? _value.tasksIds : tasksIds as List<String>,
      refererUsers: refererUsers == freezed
          ? _value.refererUsers
          : refererUsers as List<User>,
      assigneesUsers: assigneesUsers == freezed
          ? _value.assigneesUsers
          : assigneesUsers as List<User>,
      goalType: goalType == freezed ? _value.goalType : goalType as GoalType,
      hasBeenClaimAtLeastOnce: hasBeenClaimAtLeastOnce == freezed
          ? _value.hasBeenClaimAtLeastOnce
          : hasBeenClaimAtLeastOnce as bool,
      files: files == freezed ? _value.files : files as List<UploadedFile>,
    ));
  }
}

/// @nodoc
abstract class _$GoalCopyWith<$Res> implements $GoalCopyWith<$Res> {
  factory _$GoalCopyWith(_Goal value, $Res Function(_Goal) then) =
      __$GoalCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      @nullable
          String description,
      bool isMystery,
      @nullable
          int points,
      @JsonKey(fromJson: ModelUtils.statusValueToEnum, toJson: ModelUtils.statusEnumToValue)
          Status status,
      String authorId,
      @nullable
          List<String> referer,
      @nullable
          List<String> assignees,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime updatedAt,
      @nullable
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
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
      @JsonKey(fromJson: ModelUtils.goalTypeValueToEnum, toJson: ModelUtils.goalTypeToValue)
          GoalType goalType,
      @nullable
          bool hasBeenClaimAtLeastOnce,
      @JsonKey(fromJson: ModelUtils.mapToUploadedFilesList, toJson: ModelUtils.uploadedFilesListToJson)
      @nullable
          List<UploadedFile> files});
}

/// @nodoc
class __$GoalCopyWithImpl<$Res> extends _$GoalCopyWithImpl<$Res>
    implements _$GoalCopyWith<$Res> {
  __$GoalCopyWithImpl(_Goal _value, $Res Function(_Goal) _then)
      : super(_value, (v) => _then(v as _Goal));

  @override
  _Goal get _value => super._value as _Goal;

  @override
  $Res call({
    Object name = freezed,
    Object description = freezed,
    Object isMystery = freezed,
    Object points = freezed,
    Object status = freezed,
    Object authorId = freezed,
    Object referer = freezed,
    Object assignees = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
    Object duedate = freezed,
    Object remoteId = freezed,
    Object tasksIds = freezed,
    Object refererUsers = freezed,
    Object assigneesUsers = freezed,
    Object goalType = freezed,
    Object hasBeenClaimAtLeastOnce = freezed,
    Object files = freezed,
  }) {
    return _then(_Goal(
      name: name == freezed ? _value.name : name as String,
      description:
          description == freezed ? _value.description : description as String,
      isMystery: isMystery == freezed ? _value.isMystery : isMystery as bool,
      points: points == freezed ? _value.points : points as int,
      status: status == freezed ? _value.status : status as Status,
      authorId: authorId == freezed ? _value.authorId : authorId as String,
      referer: referer == freezed ? _value.referer : referer as List<String>,
      assignees:
          assignees == freezed ? _value.assignees : assignees as List<String>,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      updatedAt:
          updatedAt == freezed ? _value.updatedAt : updatedAt as DateTime,
      duedate: duedate == freezed ? _value.duedate : duedate as DateTime,
      remoteId: remoteId == freezed ? _value.remoteId : remoteId as String,
      tasksIds:
          tasksIds == freezed ? _value.tasksIds : tasksIds as List<String>,
      refererUsers: refererUsers == freezed
          ? _value.refererUsers
          : refererUsers as List<User>,
      assigneesUsers: assigneesUsers == freezed
          ? _value.assigneesUsers
          : assigneesUsers as List<User>,
      goalType: goalType == freezed ? _value.goalType : goalType as GoalType,
      hasBeenClaimAtLeastOnce: hasBeenClaimAtLeastOnce == freezed
          ? _value.hasBeenClaimAtLeastOnce
          : hasBeenClaimAtLeastOnce as bool,
      files: files == freezed ? _value.files : files as List<UploadedFile>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Goal with DiagnosticableTreeMixin implements _Goal {
  _$_Goal(
      {@required
          this.name,
      @nullable
          this.description,
      @required
          this.isMystery,
      @nullable
          this.points = 0,
      @required
      @JsonKey(fromJson: ModelUtils.statusValueToEnum, toJson: ModelUtils.statusEnumToValue)
          this.status,
      @required
          this.authorId,
      @nullable
          this.referer,
      @nullable
          this.assignees,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          this.createdAt,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          this.updatedAt,
      @nullable
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          this.duedate,
      @nullable
          this.remoteId,
      @nullable
          this.tasksIds,
      @nullable
          this.refererUsers,
      @nullable
          this.assigneesUsers,
      @nullable
      @JsonKey(fromJson: ModelUtils.goalTypeValueToEnum, toJson: ModelUtils.goalTypeToValue)
          this.goalType,
      @nullable
          this.hasBeenClaimAtLeastOnce = false,
      @JsonKey(fromJson: ModelUtils.mapToUploadedFilesList, toJson: ModelUtils.uploadedFilesListToJson)
      @nullable
          this.files})
      : assert(name != null),
        assert(isMystery != null),
        assert(status != null),
        assert(authorId != null),
        assert(createdAt != null),
        assert(updatedAt != null);

  factory _$_Goal.fromJson(Map<String, dynamic> json) =>
      _$_$_GoalFromJson(json);

  @override
  final String name;
  @override
  @nullable
  final String description;
  @override
  final bool isMystery;
  @JsonKey(defaultValue: 0)
  @override
  @nullable
  final int points;
  @override
  @JsonKey(
      fromJson: ModelUtils.statusValueToEnum,
      toJson: ModelUtils.statusEnumToValue)
  final Status status;
  @override
  final String authorId;
  @override
  @nullable
  final List<String> referer;
  @override
  @nullable
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
  @nullable
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  final DateTime duedate;
  @override
  @nullable
  final String remoteId;
  @override
  @nullable
  final List<String> tasksIds;
  @override
  @nullable
  final List<User> refererUsers;
  @override
  @nullable
  final List<User> assigneesUsers;
  @override
  @nullable
  @JsonKey(
      fromJson: ModelUtils.goalTypeValueToEnum,
      toJson: ModelUtils.goalTypeToValue)
  final GoalType goalType;
  @JsonKey(defaultValue: false)
  @override
  @nullable
  final bool hasBeenClaimAtLeastOnce;
  @override
  @JsonKey(
      fromJson: ModelUtils.mapToUploadedFilesList,
      toJson: ModelUtils.uploadedFilesListToJson)
  @nullable
  final List<UploadedFile> files;

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
    return 'Goal(name: $name, description: $description, isMystery: $isMystery, points: $points, status: $status, authorId: $authorId, referer: $referer, assignees: $assignees, createdAt: $createdAt, updatedAt: $updatedAt, duedate: $duedate, remoteId: $remoteId, tasksIds: $tasksIds, refererUsers: $refererUsers, assigneesUsers: $assigneesUsers, goalType: $goalType, hasBeenClaimAtLeastOnce: $hasBeenClaimAtLeastOnce, files: $files, isNew: $isNew)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Goal'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('isMystery', isMystery))
      ..add(DiagnosticsProperty('points', points))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('authorId', authorId))
      ..add(DiagnosticsProperty('referer', referer))
      ..add(DiagnosticsProperty('assignees', assignees))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('duedate', duedate))
      ..add(DiagnosticsProperty('remoteId', remoteId))
      ..add(DiagnosticsProperty('tasksIds', tasksIds))
      ..add(DiagnosticsProperty('refererUsers', refererUsers))
      ..add(DiagnosticsProperty('assigneesUsers', assigneesUsers))
      ..add(DiagnosticsProperty('goalType', goalType))
      ..add(DiagnosticsProperty(
          'hasBeenClaimAtLeastOnce', hasBeenClaimAtLeastOnce))
      ..add(DiagnosticsProperty('files', files))
      ..add(DiagnosticsProperty('isNew', isNew));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Goal &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.isMystery, isMystery) ||
                const DeepCollectionEquality()
                    .equals(other.isMystery, isMystery)) &&
            (identical(other.points, points) ||
                const DeepCollectionEquality().equals(other.points, points)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.authorId, authorId) ||
                const DeepCollectionEquality()
                    .equals(other.authorId, authorId)) &&
            (identical(other.referer, referer) ||
                const DeepCollectionEquality()
                    .equals(other.referer, referer)) &&
            (identical(other.assignees, assignees) ||
                const DeepCollectionEquality()
                    .equals(other.assignees, assignees)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.duedate, duedate) ||
                const DeepCollectionEquality()
                    .equals(other.duedate, duedate)) &&
            (identical(other.remoteId, remoteId) ||
                const DeepCollectionEquality()
                    .equals(other.remoteId, remoteId)) &&
            (identical(other.tasksIds, tasksIds) ||
                const DeepCollectionEquality()
                    .equals(other.tasksIds, tasksIds)) &&
            (identical(other.refererUsers, refererUsers) ||
                const DeepCollectionEquality()
                    .equals(other.refererUsers, refererUsers)) &&
            (identical(other.assigneesUsers, assigneesUsers) ||
                const DeepCollectionEquality()
                    .equals(other.assigneesUsers, assigneesUsers)) &&
            (identical(other.goalType, goalType) ||
                const DeepCollectionEquality()
                    .equals(other.goalType, goalType)) &&
            (identical(
                    other.hasBeenClaimAtLeastOnce, hasBeenClaimAtLeastOnce) ||
                const DeepCollectionEquality().equals(
                    other.hasBeenClaimAtLeastOnce, hasBeenClaimAtLeastOnce)) &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(isMystery) ^
      const DeepCollectionEquality().hash(points) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(authorId) ^
      const DeepCollectionEquality().hash(referer) ^
      const DeepCollectionEquality().hash(assignees) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(duedate) ^
      const DeepCollectionEquality().hash(remoteId) ^
      const DeepCollectionEquality().hash(tasksIds) ^
      const DeepCollectionEquality().hash(refererUsers) ^
      const DeepCollectionEquality().hash(assigneesUsers) ^
      const DeepCollectionEquality().hash(goalType) ^
      const DeepCollectionEquality().hash(hasBeenClaimAtLeastOnce) ^
      const DeepCollectionEquality().hash(files);

  @JsonKey(ignore: true)
  @override
  _$GoalCopyWith<_Goal> get copyWith =>
      __$GoalCopyWithImpl<_Goal>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_GoalToJson(this);
  }
}

abstract class _Goal implements Goal {
  factory _Goal(
      {@required
          String name,
      @nullable
          String description,
      @required
          bool isMystery,
      @nullable
          int points,
      @required
      @JsonKey(fromJson: ModelUtils.statusValueToEnum, toJson: ModelUtils.statusEnumToValue)
          Status status,
      @required
          String authorId,
      @nullable
          List<String> referer,
      @nullable
          List<String> assignees,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime createdAt,
      @required
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
          DateTime updatedAt,
      @nullable
      @JsonKey(fromJson: ModelUtils.millisecondsToDateTime, toJson: ModelUtils.dateTimeToMilliseconds)
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
      @JsonKey(fromJson: ModelUtils.goalTypeValueToEnum, toJson: ModelUtils.goalTypeToValue)
          GoalType goalType,
      @nullable
          bool hasBeenClaimAtLeastOnce,
      @JsonKey(fromJson: ModelUtils.mapToUploadedFilesList, toJson: ModelUtils.uploadedFilesListToJson)
      @nullable
          List<UploadedFile> files}) = _$_Goal;

  factory _Goal.fromJson(Map<String, dynamic> json) = _$_Goal.fromJson;

  @override
  String get name;
  @override
  @nullable
  String get description;
  @override
  bool get isMystery;
  @override
  @nullable
  int get points;
  @override
  @JsonKey(
      fromJson: ModelUtils.statusValueToEnum,
      toJson: ModelUtils.statusEnumToValue)
  Status get status;
  @override
  String get authorId;
  @override
  @nullable
  List<String> get referer;
  @override
  @nullable
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
  @nullable
  @JsonKey(
      fromJson: ModelUtils.millisecondsToDateTime,
      toJson: ModelUtils.dateTimeToMilliseconds)
  DateTime get duedate;
  @override
  @nullable
  String get remoteId;
  @override
  @nullable
  List<String> get tasksIds;
  @override
  @nullable
  List<User> get refererUsers;
  @override
  @nullable
  List<User> get assigneesUsers;
  @override
  @nullable
  @JsonKey(
      fromJson: ModelUtils.goalTypeValueToEnum,
      toJson: ModelUtils.goalTypeToValue)
  GoalType get goalType;
  @override
  @nullable
  bool get hasBeenClaimAtLeastOnce;
  @override
  @JsonKey(
      fromJson: ModelUtils.mapToUploadedFilesList,
      toJson: ModelUtils.uploadedFilesListToJson)
  @nullable
  List<UploadedFile> get files;
  @override
  @JsonKey(ignore: true)
  _$GoalCopyWith<_Goal> get copyWith;
}
