import 'package:flutter/cupertino.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/services/db_service.dart';

class FriendsViewModel extends ChangeNotifier {
  final MyLogger _logger = MyLogger('FriendsViewModel');
  DbService _dbService;

  final List<User> _friends = [];
  bool _loading = false;
  bool _initialLoading = false;
  String _searchValue;

  List<User> get friends {
    if (_searchValue?.isEmpty ?? true) {
      return _friends;
    }
    return _friends
        .where((element) => element.displayName
            .toLowerCase()
            .contains(_searchValue.toLowerCase()))
        .toList();
  }

  bool get initialLoading => _initialLoading;
  bool get loading => _loading;

  void setDependencies({@required DbService dbService}) {
    _dbService = dbService;
  }

  void init() async {
    _setInitialLoading(true);
    await refresh();
    _setInitialLoading(false);
  }

  Future<void> refresh() async {
    _setLoading(true);
    await _getAllFriends();
    _setLoading(false);
  }

  void _setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  void setFriends(List<User> friends) {
    _friends
      ..clear()
      ..addAll(friends);

    notifyListeners();
  }

  void search(String value) {
    _searchValue = value;
    notifyListeners();
  }

  void _setInitialLoading(bool loading) {
    _initialLoading = loading;
    notifyListeners();
  }

  Future<void> _getAllFriends() async {
    try {
      final friends = await _dbService.getFriends();

      setFriends(friends);
    } catch (e) {
      _logger.e(e.toString(), error: e);
    }
  }
}
