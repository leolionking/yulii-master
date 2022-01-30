import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yulli/abstracts/disposable.dart';
import 'package:yulli/common/utils/list_utils.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/models/task.dart';
import 'package:yulli/services/db_service.dart';

class TasksService implements Disposable {
  final MyLogger _logger = MyLogger('TasksService');

  final List<StreamSubscription> _subscriptions = [];
  final BehaviorSubject<List<Task>> _tasksStreamController =
      BehaviorSubject.seeded([]);
  final BehaviorSubject<List<Task>> _assignedTasksStreamController =
      BehaviorSubject.seeded([]);

  DbService _dbService;

  Stream<List<Task>> get allTasks => _tasksStreamController.stream;
  Stream<List<Task>> get assignedTasks => _assignedTasksStreamController.stream;

  TasksService setDependencies({DbService dbService}) {
    _dbService = dbService;

    return this;
  }

  void init() async {
    final allTasksQueries = await _dbService.getAllTasksQueries;

    final streams = allTasksQueries.map((e) => e.snapshots()).toList();

    _subscriptions.add(
      CombineLatestStream(
        streams,
        (List<QuerySnapshot> querySnapshots) {
          return querySnapshots.fold<List<DocumentSnapshot>>(
            [],
            (previousValue, element) =>
                [...previousValue, ...element.docs],
          ).toList();
        },
      )
          .debounce((event) => TimerStream(true, Duration(milliseconds: 250)))
          .listen((documentSnapshots) async {
        documentSnapshots = ListUtils.distinct(
          documentSnapshots,
          (document) => document.id,
        );
        final tasks =
            await _dbService.getTasksFromDocumentSnapshots(documentSnapshots);

        _onNewTasks(tasks..sort((a, b) => b.updatedAt.compareTo(a.updatedAt)));
      }),
    );
  }

  void _onNewTasks(List<Task> tasks) async {
    _logger.d("Tasks list length: ${tasks.length}");
    final currentUser = await _dbService.getCurrentUser();

    final assignedTasks = tasks
        .where((task) => task.isUserAssigned(currentUser.remoteId))
        .toList();

    _onNewAssignedTasks(assignedTasks);

    _tasksStreamController.add(tasks);
  }

  void _onNewAssignedTasks(List<Task> tasks) {
    _logger.d("Assigned tasks list length: ${tasks.length}");
    _assignedTasksStreamController.add(tasks);
  }

  @override
  void dispose() {
    _subscriptions.forEach((subscription) => subscription.cancel());
    _assignedTasksStreamController.close();
    _tasksStreamController.close();
  }
}
