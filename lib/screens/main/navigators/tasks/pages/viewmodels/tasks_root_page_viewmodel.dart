import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/models/status.dart';
import 'package:yulli/models/task.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/services/tasks_service.dart';

class TasksRootViewModel extends ChangeNotifier {
  final DbService _dbService;
  final TasksService _tasksService;
  final MyLogger _logger = MyLogger("TasksRootViewModel");
  StreamSubscription _streamSubscription;

  bool _mounted = true;
  bool get mounted => _mounted;

  final List<User> _friends = [];
  List<Task> _tasks = [];
  List<Task> _cache = [];
  bool _loading = true;
  bool _processing = false;

  TasksRootViewModel(DbService dbService, this._tasksService)
      : _dbService = dbService;

  bool get loading => _loading;
  bool get processing => _processing;
  List<User> get friends => _friends;
  List<Task> get tasks => _tasks;

  void init() async {
    await _fetchFriends(notify: false);
    _streamSubscription = _tasksService.allTasks.listen((tasks) {
      _setTasks(tasks);

      if (_loading) {
        _loading = false;
        notifyListeners();
      }
    });
  }

  Future<void> refresh() async {
    if (!mounted) return;

    await Future.wait([
      _fetchFriends(notify: false),
      _fetchTasks(notify: false),
    ]);
    _loading = false;
    notifyListeners();
  }

  Future<void> _fetchFriends({bool notify = false}) async {
    _friends
      ..clear()
      ..addAll(await _dbService.getFriends());
    if (notify) notifyListeners();
  }

  Future<void> _fetchTasks({bool notify = false}) async {
    _setTasks(await _dbService.getAllTasks(), notify: notify);
  }

  void _setTasks(List<Task> tasks, {bool notify = true}) {
    _logger.d("set tasks");
    _tasks
      ..clear()
      ..addAll(tasks);

    if (notify) notifyListeners();
  }

  void setProcessing(bool processing) {
    if (!mounted) return;
    _processing = processing;
    notifyListeners();
  }

  Future<void> updateTaskToNextStatus(Task task) async {
    if (!mounted) return;
    final currentUser = await _dbService.getCurrentUser();
    if (!task.status.hasNext ||
        task.status == Status.done ||
        !task.assignees.contains(currentUser.remoteId)) return;
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

  void search(String search) {
    if (search.isEmpty && _cache.isNotEmpty) {
      _tasks = List.from(_cache);
    } else if (search.isNotEmpty) {
      if (_cache.isEmpty) {
        _cache = List.from(_tasks);
      }
      _tasks = _cache
          .where((element) =>
              element.name.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _mounted = false;
    _streamSubscription?.cancel();
    super.dispose();
  }
}
