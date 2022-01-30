import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/models/goal.dart';
import 'package:yulli/models/status.dart';
import 'package:yulli/models/task.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/services/tasks_service.dart';

class HomeRootPageViewModel extends ChangeNotifier {
  final DbService _dbService;
  final TasksService _tasksService;
  final MyLogger _logger = MyLogger("HomeRootPageViewModel");
  StreamSubscription _streamSubscription;

  HomeRootPageViewModel(DbService dbService, this._tasksService)
      : _dbService = dbService;

  final List<Goal> _goals = <Goal>[];
  final List<Task> _tasks = <Task>[];
  bool _loading = true;
  bool _processing = false;

  List<Goal> get goals => _goals;
  List<Task> get tasks => _tasks;
  List<Task> get finishedTasks =>
      tasks.where((element) => element.status.isDone).toList();
  int get finishedTasksLength => finishedTasks.length;

  bool get loading => _loading;
  bool get processing => _processing;

  void init() async {
    _streamSubscription = _tasksService.assignedTasks.listen((tasks) {
      _setTasks(tasks);

      if (_loading) {
        _loading = false;
        notifyListeners();
      }
    });
  }

  Future<void> refresh() async {
    await Future.wait([
      // _setAssignedGoals(notify: false),
      _setAssignedTasks(notify: false),
    ]);
    _loading = false;
    notifyListeners();
  }

  void setProcessing(bool processing) {
    _processing = processing;
    notifyListeners();
  }

  Future<void> updateTaskToNextStatus(Task task) async {
    if (!task.status.hasNext || task.status == Status.done) return;
    _logger.i("updating task...");
    setProcessing(true);
    try {
      await _dbService.updateTaskStatus(task, task.status.next);
      // await refresh();
    } catch (e) {
      _logger.e("erreur", error: e);
    }
    setProcessing(false);
  }

  Future<void> _setAssignedTasks({bool notify = false}) async {
    List<Task> tasks = await _dbService.getMyAssignedTasks();
    _setTasks(tasks, notify: notify);
  }

  void _setTasks(List<Task> tasks, {bool notify = true}) {
    print('set task');
    _tasks
      ..clear()
      ..addAll(tasks);

    if (notify) notifyListeners();
  }

  Future<void> _setAssignedGoals({bool notify = false}) async {
    List<Goal> goals = await _dbService.getMyAssignedGoals();
    _goals
      ..clear()
      ..addAll(goals);

    if (notify) notifyListeners();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}
