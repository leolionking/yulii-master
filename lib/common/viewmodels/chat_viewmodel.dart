import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/services/db_service.dart';

class ChatViewModel extends ChangeNotifier {
  final MyLogger _logger = MyLogger('ChatViewModel');
  DbService _dbService;
  StreamSubscription _streamSubscription;
  int _unreadMessagesCount = 0;

  int get unreadMessagesCount => _unreadMessagesCount;

  void setDependencies({@required DbService dbService}) {
    _dbService = dbService;
    notifyListeners();
  }

  void init() {
    _listenToUnreadReceivedMessages();
  }

  void _listenToUnreadReceivedMessages() async {
    assert(_dbService != null);

    final query = await _dbService.countUnreadReceivedMessages;

    _streamSubscription = query.snapshots().listen((event) {
      _logger.d('updating received read messages count...');
      _unreadMessagesCount = event.docs.length;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}
