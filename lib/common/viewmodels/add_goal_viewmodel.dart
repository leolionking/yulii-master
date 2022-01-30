import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:yulli/abstracts/form_mode_viewmodel.dart';
import 'package:yulli/abstracts/form_viewmodel.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/exceptions/unexpected_error.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/goal.dart';
import 'package:yulli/models/status.dart';
import 'package:yulli/models/task.dart';
import 'package:yulli/models/uploaded_file.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/services/file_storage_service.dart';

class AddGoalViewModel extends FormModeViewModel {
  final MyLogger _logger = MyLogger('AddGoalViewModel');
  final DbService _dbService;
  final FileStorageService _fileStorageService;
  String _name;
  String _description;
  User _member;
  int _points = 10;
  List<Task> _tasks = [];
  bool _isMistery = false;
  GoalType _type;
  bool _submitting = false;
  bool _isAssigned = false;
  Goal _goal;
  bool _loading = false;
  bool _hasBeenClaimedByCurrentUser = false;
  List<UploadedFile> _files = [];
  ValueNotifier<bool> _claimed = ValueNotifier(false);

  ValueNotifier<bool> get claimed => _claimed;

  AddGoalViewModel(
    AppLocalization_Labels localization,
    this._dbService,
    this._fileStorageService, {
    FormMode formMode = FormMode.create,
  }) : super(localization, formMode);

  String get name => _name;
  String get description => _description;
  User get member => _member;
  int get points => _points;
  List<Task> get tasks => _tasks;
  bool get isMistery => _isMistery;
  GoalType get type => _type;
  bool get submitting => _submitting;
  bool get isAssigned => _isAssigned;
  bool get isValid =>
      _name != null &&
      _name.isNotEmpty &&
      _member != null &&
      _type != null &&
      ((_type.isPro && _tasks.isNotEmpty) || (_type.isClassic && _points > 0));
  bool get hasGoal => _goal != null;
  Goal get goal => _goal;
  bool get loading => _loading;
  bool get hasBeenClaimedByCurrentUser => _hasBeenClaimedByCurrentUser;
  List<UploadedFile> get files => _files;

  bool isHiddenCauseMistery(User currentUser) =>
      hasGoal && !goal.isAuthor(currentUser.remoteId) && goal.isMystery;

  bool canClaim(User currentUser) {
    if (!hasGoal) return false;

    if (hasBeenClaimedByCurrentUser) return false;

    if (goal.goalType.isClassic && currentUser.lastCredits != null) {
      return currentUser.lastCredits.current >= goal.points;
    } else if (goal.goalType.isPro &&
        tasks.isNotEmpty &&
        tasks.allAreDone &&
        !hasBeenClaimedByCurrentUser) {
      return true;
    }

    return false;
  }

  bool hasEnoughPoints(User currentUser) {
    return goal.goalType.isClassic &&
        (currentUser.lastCredits?.current ?? -1) >= goal.points;
  }

  bool isCurrentUserAuthor(User currentUser) =>
      hasGoal && goal.isAuthor(currentUser.remoteId);

  void init(GlobalKey<FormState> formStateKey) {
    super.init(formStateKey);

    if (_goal != null) {
      _loading = true;
    }
  }

  Future<void> addFile(File file, {bool isVideo = false}) async {
    assert(isVideo != null);
    if (file == null || !await file.exists()) {
      return;
    }
    _setLoading(true);
    final uploadedFile = await _fileStorageService.upload(file);

    _files.add(uploadedFile.copyWith(
      fileType: isVideo ? FileType.video : FileType.image,
    ));
    _setLoading(false);
  }

  void removeFile(UploadedFile uploadedFile) {
    _files = _files
        .where((element) => element.filePath != uploadedFile.filePath)
        .toList();
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setDescription(String description) {
    _description = description;
    notifyListeners();
  }

  void setMember(User member, {bool notify = true}) {
    _member = member;
    if (notify) notifyListeners();
  }

  void setPoints(int points) {
    _points = points;
    notifyListeners();
  }

  void setIsAssigned(bool assigned) {
    _isAssigned = assigned;
    notifyListeners();
  }

  void addTasks(List<Task> tasks, {bool clearBefore = false}) {
    if (clearBefore) {
      clearTasks(notify: false);
    }
    _tasks.addAll(tasks);
    notifyListeners();
  }

  void clearTasks({bool notify = true}) {
    _tasks.clear();
    if (notify) notifyListeners();
  }

  void addTask(Task task) {
    if (_tasks.contains(task)) return;
    _tasks.add(task);
    notifyListeners();
  }

  void removeTaskByIndex(int index) async {
    try {
      if (!_tasks.asMap().containsKey(index)) return;

      final task = _tasks[index];

      if (task.isLinkedToGoal) {
        await _dbService.unlinkTask(task.remoteId);
      }

      _tasks.removeAt(index);

      notifyListeners();
    } catch (e) {}
  }

  void setMistery(bool isMistery) {
    _isMistery = isMistery;
    notifyListeners();
  }

  void setSubmitting(bool submitting) {
    _submitting = submitting;
    notifyListeners();
  }

  void setType(GoalType goalType) {
    _type = goalType;
    notifyListeners();
  }

  void setGoal(Goal goal) {
    _goal = goal;
  }

  Future<void> populateGoal() async {
    _name = _goal.name;
    _description = _goal.description;
    _points = _goal.points;
    _isMistery = _goal.isMystery;
    _type = _goal.goalType;
    _files = _goal.files;

    final currentUser = await _dbService.getCurrentUser();

    if (currentUser.remoteId == _goal.authorId) {
      _isAssigned = !_goal.isUserAssigned(currentUser.remoteId);
    }

    final results = await Future.wait([
      _dbService.getRemoteUser(_goal.assignees.first),
      _dbService.getTasksByIds(_goal.tasksIds),
      _dbService.getLastUserClaim(_goal.remoteId)
    ]);

    _member = results[0];
    _tasks = results[1];
    var lastClaim = results[2];

    if (lastClaim != null) {
      _hasBeenClaimedByCurrentUser = true;
      _claimed.value = _hasBeenClaimedByCurrentUser;
    }

    _setLoading(false);
  }

  void _setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  @override
  void clearErrors() {
    // TODO: implement clearErrors
  }

  Future<void> claim() async {
    try {
      setSubmitting(true);
      await _dbService.claimGoal(_goal);
    } catch (e) {
      _logger.e(e, error: e);
      throw e;
    } finally {
      setSubmitting(false);
    }
  }

  @override
  Future<bool> validate({bool editing = false}) async {
    setSubmitting(true);

    if (formState.validate()) {
      final currentUser = await _dbService.getCurrentUser();
      final now = DateTime.now().toUtc();
      Goal goal;

      if (editing) {
        assert(_goal != null);
        goal = _goal.copyWith(
          name: name,
          description: description,
          isMystery: isMistery,
          points: null,
          updatedAt: now,
          files: files,
          assignees: isAssigned ? [member.remoteId] : [currentUser.remoteId],
          referer: !isAssigned ? [member.remoteId] : [currentUser.remoteId],
          refererUsers: null,
          assigneesUsers: null,
        );
      } else {
        goal = Goal(
          name: name,
          description: description,
          isMystery: isMistery,
          points: null,
          status: !isAssigned ? Status.pending : Status.opened,
          authorId: currentUser.remoteId,
          createdAt: now,
          updatedAt: now,
          goalType: type,
          files: files,
          assignees: isAssigned ? [member.remoteId] : [currentUser.remoteId],
          referer: !isAssigned ? [member.remoteId] : [currentUser.remoteId],
        );
      }

      _logger.i(goal);

      if (type.isClassic) {
        goal = goal.copyWith(points: points);
      } else if (type.isPro) {
        goal = goal.copyWith(tasksIds: tasks.map((e) => e.remoteId).toList());
      }

      try {
        if (editing) {
          await _dbService.updateGoal(goal);
        } else {
          await _dbService.createGoals(goal);
        }

        setSubmitting(false);
        return true;
      } on PlatformException catch (e) {
        handleUnexpectedException(
          UnexpectedException(
            localization.errors.exceptions.networkConnectionFailed,
          ),
        );
      } catch (e) {
        _logger.e(e, error: e);
        handleUnexpectedException(
          UnexpectedException(
            localization.errors.exceptions.unexpected,
          ),
        );
      }
    } else {
      setValidationState(FormValidationState.invalid);
    }
    setSubmitting(false);
    return false;
  }

  @protected
  @override
  void onCacheInit() {
    addToCache('_name', _name);
    addToCache('_description', _description);
    addToCache('_member', _member);
    addToCache('_tasks', _tasks);
    addToCache('_isMistery', _isMistery);
    addToCache('_type', _type);
    addToCache('_isAssigned', _isAssigned);
    addToCache('_goal', _goal);
    addToCache('_hasBeenClaimedByCurrentUser', _hasBeenClaimedByCurrentUser);
  }

  @protected
  @override
  void onCacheRestore() {
    _name = getFromCache('_name');
    _description = getFromCache('_description');
    _member = getFromCache('_member');
    _tasks = getFromCache('_tasks');
    _isMistery = getFromCache('_isMistery');
    _type = getFromCache('_type');
    _isAssigned = getFromCache('_isAssigned');
    _goal = getFromCache('_goal');
    _hasBeenClaimedByCurrentUser = getFromCache('_hasBeenClaimedByCurrentUser');
    notifyListeners();
  }

  @override
  void validateAllInputs({bool notify = true}) {
    // TODO: implement validateAllInputs
  }

  @override
  void dispose() {
    _claimed.dispose();
    super.dispose();
  }

  @override
  String toString() => """
    name: $name,
    description: $description,
    member: $member,
    points: $points,
    isMistery: $isMistery,
    type: $type,
    submitting: $submitting,
    isValid: $isValid,
    tasks: $tasks,
  """;
}
