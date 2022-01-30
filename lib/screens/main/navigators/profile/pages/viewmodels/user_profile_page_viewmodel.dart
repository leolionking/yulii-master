import 'package:flutter/cupertino.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/models/my_tasks_by_friend.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/services/db_service.dart';

class UserProfilePageViewModel extends ChangeNotifier {
  final DbService _dbService;
  final MyLogger _logger = MyLogger('UserProfilePageViewModel');
  bool _loading = true;
  int _currentTabIndex = 0;
  List<User> _friends = [];
  List<MyTasksByFriend> _myTasksByFriends = [];
  bool _tabOneLoading = true;
  bool _tabTwoLoading = false;

  UserProfilePageViewModel(this._dbService);

  bool get loading => _loading;
  bool get currentTabHasData =>
      (_currentTabIndex == 0 && _friends.isNotEmpty) || false;
  int get currentTabIndex => _currentTabIndex;
  List<User> get friends => _friends;
  List<MyTasksByFriend> get myTasksByFriend => _myTasksByFriends;
  bool get tabOneLoading => _tabOneLoading;
  bool get tabTwoLoading => _tabOneLoading;
  bool get tabOneHasData => _friends.isNotEmpty;
  bool get tabTwoHasData => _myTasksByFriends.isNotEmpty;

  void init() {
    refresh();
  }

  void setCurrentTab(int tabIndex) {
    _currentTabIndex = tabIndex;
    notifyListeners();
  }

  Future<void> refresh() async {
    await Future.wait([
      _fetchFriendsAndTheirStats(),
      _fetchMyTasksByFriends(),
    ]);
  }

  void _setTabOneLoading(bool loading) {
    _tabOneLoading = loading;
    notifyListeners();
  }

  void _setTabTwoLoading(bool loading) {
    _tabTwoLoading = loading;
    notifyListeners();
  }

  void deleteFriend(User friend) async {
    await _dbService.removeFriend(friend.remoteId);
    refresh();
  }

  Future<void> _fetchFriendsAndTheirStats() async {
    _setTabOneLoading(true);
    try {
      final friends = await _dbService.getFriendsAndTheirStats();

      _friends = friends;
    } catch (e) {
      _logger.e(e, error: e);
    }
    _setTabOneLoading(false);
  }

  Future<void> _fetchMyTasksByFriends() async {
    _setTabTwoLoading(true);

    try {
      final tasksByFriends = await _dbService.getMyTasksByFriends();

      _myTasksByFriends = tasksByFriends;
    } catch (e) {
      _logger.e(e, error: e);
    }

    _logger.d('_fetchMyTasksByFriends $myTasksByFriend');

    _setTabTwoLoading(false);
  }
}
