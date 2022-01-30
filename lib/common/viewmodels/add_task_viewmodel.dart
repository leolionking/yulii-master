import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yulli/abstracts/form_mode_viewmodel.dart';
import 'package:yulli/abstracts/form_viewmodel.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/exceptions/unexpected_error.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/status.dart';
import 'package:yulli/models/task.dart';
import 'package:yulli/models/uploaded_file.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/services/app_data.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/services/file_storage_service.dart';

class AddTaskViewModel extends FormModeViewModel {
  final MyLogger _logger = MyLogger('AddTaskViewModel');
  final DbService _dbService;
  final FileStorageService _fileStorageService;
  final AppDataService _appDataService;
  Task _task;
  String _name;
  String _description;
  User _member;
  int _points = 10;
  DateTime _date;
  bool _isAssigned = false;
  bool _loading = false;
  List<UploadedFile> _files = [];

  AddTaskViewModel(
    AppLocalization_Labels localization,
    this._appDataService,
    this._dbService,
    this._fileStorageService, {
    FormMode formMode = FormMode.create,
  }) : super(localization, formMode);

  String get name => _name;
  String get description => _description;
  User get member => _member;
  int get points => _points;
  DateTime get date => _date;
  bool get isAssigned => _isAssigned;
  bool get loading => _loading;
  bool get hasTask => _task != null;
  Task get task => _task;
  List<UploadedFile> get files => _files;
  bool get isValid =>
      _name != null && _name.isNotEmpty && _member != null && _points != null;

  void init(GlobalKey<FormState> formStateKey) {
    super.init(formStateKey);

    if (_task != null) {
      _loading = true;
    }
  }

  Future<void> updateTaskStatus(Status status) async {
    if (!hasTask) return;
    setSubmitting(true);
    try {
      Task iTask = _task;

      if (isAssigned && iTask.status.isOpened) {
        iTask = task.copyWith(files: files);
      }
      _logger.d("status $status");

      iTask = iTask.copyWith(status: status);
      await _dbService.updateTask(iTask);
      _task = iTask;
    } catch (e, s) {
      _logger.e(e, error: e, stackTrace: s);
      print(e);
      print(s);
    } finally {
      setSubmitting(false);
    }
  }

  Future<void> addFile(File file, {bool isVideo = false}) async {
    assert(isVideo != null);
    if (file == null || !await file.exists()) {
      return;
    }
    _setLoading(true);
    final uploadedFile = await _fileStorageService.upload(file);

    _logger.d('user r ${_appDataService.currentUser.remoteId}');

    _files.add(uploadedFile.copyWith(
      fileType: isVideo ? FileType.video : FileType.image,
      authorId: _appDataService.currentUser.remoteId,
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

  bool fileIsMine(UploadedFile file) => file.authorId == _member.remoteId;

  void setDate(DateTime date) {
    _date = date;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  Future<void> populateTask() async {
    _logger.i(task);
    _name = _task.name;
    _description = _task.description;
    _member = await _dbService.getRemoteUser(_task.assignees.first);
    _points = _task.points;
    _date = _task.dueDate;
    _files = _task.files;
    _isAssigned = _appDataService.currentUser.remoteId == _member.remoteId;
    _setLoading(false);
  }

  void setTask(Task task) {
    _task = task;
  }

  @override
  void clearErrors() {
    // TODO: implement clearErrors
  }

  @override
  Future<bool> validate({bool editing = false}) async {
    setSubmitting(true);

    if (formState.validate()) {
      final currentUser = await _dbService.getCurrentUser();
      final now = DateTime.now().toUtc();

      Task task;

      if (editing) {
        task = _task.copyWith(
          name: name,
          description: description,
          points: points,
          assignees: [member.remoteId],
          updatedAt: now,
          dueDate: date,
          files: files,
          assigneesUsers: null,
        );
      } else {
        task = Task(
          name: name,
          description: description,
          points: points,
          authorId: currentUser.remoteId,
          assignees: [member.remoteId],
          createdAt: now,
          updatedAt: now,
          files: files,
          status: Status.opened,
          dueDate: date,
        );
      }

      try {
        if (editing) {
          await _dbService.updateTask(task);
        } else {
          await _dbService.createTask(task);
        }

        setSubmitting(false);
        return true;
      } on PlatformException catch (e) {
        print(e);
        handleUnexpectedException(
          UnexpectedException(
            localization.errors.exceptions.networkConnectionFailed,
          ),
        );
      } catch (e) {
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
    addToCache('_task', _task);
    addToCache('_name', _name);
    addToCache('_description', _description);
    addToCache('_member', _member);
    addToCache('_points', _points);
    addToCache('_date', _date);
    addToCache('_isAssigned', _isAssigned);
  }

  @protected
  @override
  void onCacheRestore() {
    _task = getFromCache('_task');
    _name = getFromCache('_name');
    _description = getFromCache('_description');
    _member = getFromCache('_member');
    _points = getFromCache('_points');
    _date = getFromCache('_date');
    _isAssigned = getFromCache('_isAssigned');
    notifyListeners();
  }

  @override
  void validateAllInputs({bool notify = true}) {
    // TODO: implement validateAllInputs
  }

  @override
  String toString() => """
    name: $name,
    description: $description,
    member: $member,
    points: $points,
    date: $date,
    submitting: $submitting,
    isValid: $isValid,
  """;
}
