import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yulli/abstracts/disposable.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/models/goal.dart';
import 'package:yulli/services/db_service.dart';

class GoalsService implements Disposable {
  final MyLogger _logger = MyLogger('GoalsService');
  DbService _dbService;
  final List<StreamSubscription> _subscriptions = [];
  final BehaviorSubject<List<Goal>> _goalsStreamController =
      BehaviorSubject.seeded([]);
  final BehaviorSubject<List<Goal>> _assignedGoalsStreamController =
      BehaviorSubject.seeded([]);

  Stream<List<Goal>> get assignedGoals => _assignedGoalsStreamController.stream;
  Stream<List<Goal>> get allGoals => _goalsStreamController.stream;

  GoalsService setDependencies({DbService dbService}) {
    _dbService = dbService;

    return this;
  }

  void init() async {
    /*************** */
    final allGoalsQuery = await _dbService.getAllGoalsQueries;

    final streams = allGoalsQuery.map((e) => e.snapshots()).toList();

    _subscriptions.add(
      CombineLatestStream(streams, (List<QuerySnapshot> querySnapshots) {
        return querySnapshots.fold<List<DocumentSnapshot>>(
          [],
          (previousValue, element) => [...previousValue, ...element.docs],
        ).toList();
      })
          .debounce((event) => TimerStream(true, Duration(milliseconds: 250)))
          .listen((documentSnapshots) async {
        final goals =
            await _dbService.getGoalsFromDocumentSnapshots(documentSnapshots);

        goals.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

        _onNewGoals(goals);
      }),
    );
  }

  void _onNewGoals(List<Goal> goals) async {
    final currentUser = await _dbService.getCurrentUser();

    final assignedGoals = goals
        .where((goal) => goal.isUserAssigned(currentUser.remoteId))
        .toList();

    _onNewAssignedGoals(assignedGoals);

    _goalsStreamController.add(goals);
  }

  void _onNewAssignedGoals(List<Goal> goals) {
    _logger.d("new assigned goals length: ${goals.length}");
    _assignedGoalsStreamController.add(goals);
  }

  @override
  void dispose() {
    _subscriptions.forEach((subscription) => subscription.cancel());
    _assignedGoalsStreamController.close();
    _goalsStreamController.close();
  }
}
