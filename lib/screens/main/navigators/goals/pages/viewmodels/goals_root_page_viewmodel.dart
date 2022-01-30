import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/models/goal.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/screens/main/navigators/goals/pages/widgets/goals_list_filter_bottom_sheet.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/extensions/index.dart';
import 'package:yulli/services/goals_service.dart';

class GoalsRootPageViewModel extends ChangeNotifier {
  final MyLogger _logger = MyLogger('GoalsRootPageViewModel');
  final DbService _dbService;
  final GoalsService _goalsService;
  StreamSubscription _streamSubscription;

  bool _loading = true;
  GoalsListFilter _currentFilter = GoalsListFilter.notClaimed;
  List<User> _friends = [];
  List<Goal> _allGoals = [];
  List<Goal> _claimGoals = [];
  List<Goal> _cacheGoals = [];

  GoalsRootPageViewModel(this._dbService, this._goalsService);

  bool get loading => _loading;
  List<User> get friends => _friends;
  List<Goal> get allGoals => _allGoals;
  GoalsListFilter get currentFilter => _currentFilter;

  Future<void> init() async {
    setLoading(true);
    await _fetchFriends(notify: false);
    _streamSubscription = _goalsService.allGoals.listen((goals) {
      _setGoals(goals);

      if (_loading) setLoading(false);
    });
  }

  Future<void> refresh() async {
    setLoading(true);
    await Future.wait([
      _fetchFriends(notify: false),
      // _fetchGoals(notify: false),
    ]);
    setLoading(false);
  }

  void setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  Future<void> _fetchFriends({bool notify = false}) async {
    _logger.i("fetching friends...");
    _friends
      ..clear()
      ..addAll(await _dbService.getFriends());
    if (notify) notifyListeners();
  }

  Future<void> _fetchGoals({bool notify = false}) async {
    _logger.i("fetching all goals...");
    _setGoals(await _dbService.getAllGoals(), notify: notify);
  }

  void _setGoals(List<Goal> goals, {bool notify = true}) {
    _allGoals
      ..clear()
      ..addAll(goals);
    if (notify) notifyListeners();
  }

  void sortClaimedFirst() {
    if (_claimGoals.isEmpty) {
      _claimGoals = _allGoals
          .where((element) => element.hasBeenClaimAtLeastOnce)
          .toList();
    }
    _cacheGoals = List.from(_allGoals);
    _allGoals = _claimGoals;
    _currentFilter = GoalsListFilter.claimed;
    notifyListeners();
  }

  void sortMostRecentFirst() {
    if (_cacheGoals.isNotEmpty) {
      _allGoals = List.from(_cacheGoals);
    }
    _currentFilter = GoalsListFilter.notClaimed;
    notifyListeners();
  }

  void search(String search) {
    if (search.isEmpty && _cacheGoals.isNotEmpty) {
      _allGoals = List.from(_cacheGoals);
    } else if (search.isNotEmpty) {
      if (_cacheGoals.isEmpty) {
        _cacheGoals = List.from(_allGoals);
      }
      _allGoals = _cacheGoals
          .where((element) =>
              element.name.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}
