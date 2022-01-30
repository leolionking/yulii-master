import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/models/chat.dart';
import 'package:yulli/services/db_service.dart';

class ChatListScreenViewModel extends ChangeNotifier {
  final MyLogger _logger = MyLogger("ChatListScreenViewModel");

  final DbService dbService;
  List<Chat> _chats = [];
  StreamSubscription _streamSubscription;

  ChatListScreenViewModel({@required this.dbService})
      : assert(dbService != null);

  List<Chat> get chats => _chats;

  void init() async {
    final query = await dbService.getChatsListQuery();

    _streamSubscription = query.snapshots().listen((event) async {
      List<Chat> newChats = [];

      for (var i = 0; i < event.docs.length; i++) {
        final element = event.docs[i];

        final participantsIds =
            (element.data()['participantsIds'] as List).cast<String>();

        final participants = await dbService.getUsersByIds(participantsIds);

        newChats.add(
          Chat.fromJson(element.data()).copyWith(
            remoteId: element.id,
            participants: participants,
          ),
        );
      }

      if (newChats.isNotEmpty) {
        _chats = newChats;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}
