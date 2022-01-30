import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/models/chat.dart';
import 'package:yulli/models/chat_message.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/services/db_service.dart';

class ChatMessagesViewModel extends ChangeNotifier {
  final MyLogger _logger = MyLogger("ChatMessagesViewModel");

  final DbService dbService;
  final User participant;

  StreamSubscription _chatMessagesStreamSubscription;
  bool _loading = true;
  bool _initialized = false;
  Chat _currentChat;
  List<ChatMessage> _messages = [];
  bool _isFriend;

  ChatMessagesViewModel({
    @required this.dbService,
    @required this.participant,
  })  : assert(dbService != null),
        assert(participant != null);

  bool get loading => _loading;
  Chat get currentChat => _currentChat;
  bool get currentChatExists => _initialized && _currentChat != null;
  List<ChatMessage> get messages => _messages;
  bool get isFriend => _isFriend;

  void init() async {
    _logger.d('init');
    await _refreshCurrentChatIfNeeded(notify: false);
    await _refreshChatMessages(notify: false);
    await _checkIfFriend(notify: false);
    setLoading(false, notify: false);
    _initialized = true;
    notifyListeners();
  }

  void addMessage(ChatMessage message) async {
    setLoading(true);

    if (!currentChatExists) {
      await dbService.createChat(participant.remoteId);
      await _refreshCurrentChatIfNeeded(notify: false);
    }
    await dbService.addChatMessage(
      _currentChat.remoteId,
      participant.remoteId,
      message,
    );

    setLoading(false);
  }

  Future _checkIfFriend({bool notify = true}) async {
    _isFriend = await dbService.isFriend(participant.remoteId);
    if (notify) {
      notifyListeners();
    }
  }

  Future<void> _refreshCurrentChatIfNeeded({bool notify = true}) async {
    if (_currentChat == null) {
      final chat = await dbService.findChatByParticipant(participant.remoteId);
      _currentChat = chat;

      _listenMessageStream();

      if (notify) {
        notifyListeners();
      }
    }
  }

  void setLoading(bool loading, {bool notify = true}) {
    _loading = loading;
    if (notify) {
      notifyListeners();
    }
  }

  Future<void> _refreshChatMessages({bool notify = true}) async {
    if (_currentChat != null) {
      _logger.d("refreshing messages");
      setLoading(true, notify: notify);
      _messages =
          await dbService.getChatMessagesByChatId(_currentChat.remoteId);
      setLoading(false, notify: notify);
    }
  }

  void _listenMessageStream() {
    if (_currentChat != null && _chatMessagesStreamSubscription == null) {
      _chatMessagesStreamSubscription = dbService
          .getChatMessagesByChatIdQuery(_currentChat.remoteId)
          .snapshots()
          .listen((event) {
        _logger.d('events changes : ${event.docChanges.length}');
        List<ChatMessage> newMessages = [];

        event.docChanges.forEach((element) {
          final document = element.doc;

          newMessages.add(
            ChatMessage.fromJson(document.data())
                .copyWith(remoteId: document.id),
          );
        });

        if (newMessages.isNotEmpty) {
          newMessages.forEach((newMessage) {
            if (_messages.firstWhere(
                    (element) => element.remoteId == newMessage.remoteId,
                    orElse: () => null) ==
                null) {
              _messages.add(newMessage);
            }
          });

          _messages.sort((b, a) => a.createdAt.compareTo(b.createdAt));
          notifyListeners();
          _setReceivedMessagesAsRead();
        }
      });
    }
  }

  void _setReceivedMessagesAsRead() async {
    _logger.d("marking received messages as read...");
    final unreadReceivedMessages = _messages
        .where((element) =>
            !element.read && element.senderId == participant.remoteId)
        .toList();

    if (unreadReceivedMessages.isNotEmpty) {
      final messagesIds =
          unreadReceivedMessages.map((e) => e.remoteId).toList();
      await dbService.markSentChatMessagesAsRead(messagesIds);
    }
  }

  @override
  void dispose() {
    _chatMessagesStreamSubscription?.cancel();
    super.dispose();
  }
}
