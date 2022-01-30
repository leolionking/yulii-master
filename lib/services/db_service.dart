import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:yulli/abstracts/disposable.dart';
import 'package:yulli/common/utils/list_utils.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/common/viewmodels/app_language_viewmodel.dart';
import 'package:yulli/constants/firebase_collections.dart';
import 'package:yulli/models/chat.dart';
import 'package:yulli/models/chat_message.dart';
import 'package:yulli/models/claim.dart';
import 'package:yulli/models/credit_transaction.dart';
import 'package:yulli/models/faq.dart';
import 'package:yulli/models/friend_invitation.dart';
import 'package:yulli/models/goal.dart';
import 'package:yulli/models/invitation.dart';
import 'package:yulli/models/my_tasks_by_friend.dart';
import 'package:yulli/models/notification.dart' as model;
import 'package:yulli/models/status.dart';
import 'package:yulli/models/task.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/services/device_info.dart';
import 'package:yulli/services/notification_service.dart';
import 'package:yulli/utils/cache_utils.dart';
import 'package:yulli/utils/models_utils.dart';
import 'package:yulli/services/connectivity_service.dart';
import 'package:yulli/extensions/index.dart';

class DbService extends Disposable {
  final NotificationService notificationService;
  final DeviceInfo deviceInfo;
  final ConnectivityService connectivityService;
  final AppLanguageViewModel appLanguageViewModel;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final MyLogger _logger = MyLogger('DbService');
  static final Uuid _uuid = Uuid();
  SharedPreferences _preferences;
  StreamSubscription _onFcmTokenRefreshSubscription;

  static const String APP_INSTANCE_ID_KEY = "yulli.app_instance_id";
  static const String USER_REMOTE_ID_KEY = "yulli.user_remote_id";
  static const String USER_FIRSTNAME_KEY = "yulli.user_firstname";
  static const String USER_LASTNAME_KEY = "yulli.user_lastname";
  static const String USER_EMAIL_KEY = "yulli.user_email";
  static const String USER_IS_VERIFIED_KEY = "yulli.user_is_verified";
  static const String USER_AVATAR_KEY = "yulli.user_avatar";
  static const String HAS_ALREADY_SEEN_ONBOARDING =
      "yulli.has_already_seen_onboarding";

  DbService({
    @required this.notificationService,
    @required this.deviceInfo,
    @required this.connectivityService,
    @required this.appLanguageViewModel,
  })  : assert(notificationService != null),
        assert(deviceInfo != null),
        assert(connectivityService != null);

  Future<void> init() async {
    _onFcmTokenRefreshSubscription ??=
        notificationService.onFcmTokenRefresh.listen((fcmToken) {
      _saveNewFcmToken(fcmToken);
    });
    final fcmToken = await notificationService.fcmToken;
    await _saveNewFcmToken(fcmToken);
  }

  Future<void> launchInit() async {
    _logger.i("Init...");

    await Future.wait([
      _setAppInstanceIdIfNecessary(),
    ]);
    final appInstanceId = await _getAppInstanceId();
    _logger.i("app instance id: $appInstanceId");
  }

  Source get source =>
      connectivityService.connected ? Source.server : Source.serverAndCache;

  Future<void> changeFirstname(String firstname) async {
    var currentUser = await getCurrentUser();
    currentUser = currentUser.copyWith(firstname: firstname);

    await _db
        .collection(FirebaseCollections.users)
        .doc(currentUser.remoteId)
        .set({'firstname': firstname}, SetOptions(merge: true));

    return saveUserInPreferences(currentUser);
  }

  Future<void> changeLastname(String lastname) async {
    var currentUser = await getCurrentUser();
    currentUser = currentUser.copyWith(lastname: lastname);

    await _db
        .collection(FirebaseCollections.users)
        .doc(currentUser.remoteId)
        .set({'lastname': lastname}, SetOptions(merge: true));

    return saveUserInPreferences(currentUser);
  }

  Future<void> _saveNewFcmToken(String fcmToken) async {
    final _ = await Future.wait([getCurrentUser(), _getAppInstanceId()]);
    var currentUser = _[0] as User;
    var appInstanceId = _[1] as String;

    if (currentUser.isValid && appInstanceId != null) {
      final appClientsQueryResult = await _db
          .collection(FirebaseCollections.users)
          .doc(currentUser.remoteId)
          .collection(FirebaseCollections.clients)
          .where('appInstanceId', isEqualTo: appInstanceId)
          .get();

      if (appClientsQueryResult.docs.length > 0) {
        final futures = appClientsQueryResult.docs.map((document) {
          return _db
              .collection(FirebaseCollections.users)
              .doc(currentUser.remoteId)
              .collection(FirebaseCollections.clients)
              .doc(document.id)
              .update({
            'token': fcmToken,
            'updatedAt': FieldValue.serverTimestamp(),
            'language': this.appLanguageViewModel.locale.languageCode,
          });
        }).toList();

        return Future.wait(futures);
      }
    }
  }

  Future<SharedPreferences> get preferences => SharedPreferences.getInstance();

  Future<bool> _clearPreferences({bool preserveSeenOnboarding = false}) async {
    final hasSeenOnboarding = await hasAlreadySeenOnboarding();
    final prefs = await preferences;
    final result = await prefs.clear();

    if (preserveSeenOnboarding && hasSeenOnboarding) {
      await setHasAlreadySeenOnboarding();
    }
    return result;
  }

  Future<void> deleteCurrentClient() async {
    _logger.d("deleting client...");
    final _ = await Future.wait([getCurrentUser(), _getAppInstanceId()]);
    var currentUser = _[0] as User;
    var appInstanceId = _[1] as String;

    print(currentUser);

    _logger.d('deleting clients with appInstanceId equal to: $appInstanceId');

    if (currentUser.isValid && appInstanceId != null) {
      final appClientsQueryResult = await _db
          .collection(FirebaseCollections.users)
          .doc(currentUser.remoteId)
          .collection(FirebaseCollections.clients)
          .where('appInstanceId', isEqualTo: appInstanceId)
          .get();

      final futures = appClientsQueryResult.docs.map((document) {
        _logger.d("deleting client ${document.id}");
        return _db
            .collection(FirebaseCollections.users)
            .doc(currentUser.remoteId)
            .collection(FirebaseCollections.clients)
            .doc(document.id)
            .delete();
      }).toList();

      return Future.wait(futures);
    }
  }

  Future<void> clear(
      {bool reloadAppInstanceId = false,
      bool preserveSeenOnboarding = false}) async {
    await Future.wait([
      deleteCurrentClient(),
      _clearPreferences(preserveSeenOnboarding: preserveSeenOnboarding),
    ]);
    if (reloadAppInstanceId) return _setAppInstanceIdIfNecessary();
  }

  Future<String> _getAppInstanceId() async {
    final prefs = await preferences;

    try {
      final appInstanceId = prefs.getString(APP_INSTANCE_ID_KEY);
      return appInstanceId;
    } catch (e) {
      _logger.e(e, error: e);
      throw e;
    }
  }

  Future<bool> hasAppInstanceId() async {
    var instanceId = await _getAppInstanceId();
    return instanceId != null && instanceId.isNotEmpty;
  }

  Future<bool> _setAppInstanceIdIfNecessary() async {
    if (await hasAppInstanceId()) return true;
    _logger.i("Generating app instance...");
    final prefs = await preferences;
    await prefs.setString(APP_INSTANCE_ID_KEY, _uuid.v4());

    _logger.d("generated app instance id ${await _getAppInstanceId()}");
    return true;
  }

  Future<void> createUser(User user) async {
    final userDoc =
        _db.collection(FirebaseCollections.users).doc(user.remoteId);
    await userDoc.set(user.toJson());

    await saveAppClient(user.remoteId, isNewUser: true);
  }

  Future<void> saveAppClient(String userId, {bool isNewUser = false}) async {
    try {
      final appInstanceId = await _getAppInstanceId();
      final data = {
        'token': await notificationService.fcmToken,
        'platform': Platform.operatingSystem,
        'platformVersion': Platform.operatingSystemVersion,
        'updatedAt': FieldValue.serverTimestamp(),
        'model': await deviceInfo.model,
        'appVersion': await deviceInfo.appVersion,
        'appBuildNumber': await deviceInfo.appBuildNumber,
        'appInstanceId': appInstanceId,
        'language': this.appLanguageViewModel.locale.languageCode,
      };
      if (isNewUser) {
        data['createdAt'] = FieldValue.serverTimestamp();
      }
      _logger.d("save app data: $data");
      await _db
          .collection(FirebaseCollections.users)
          .doc(userId)
          .collection(FirebaseCollections.clients)
          .doc()
          .set(data);
    } catch (e, s) {
      _logger.e(e, error: e, stackTrace: s);
      throw e;
    }
  }

  Future<void> saveUserInPreferences(User user) async {
    final prefs = await preferences;
    return Future.wait<void>([
      prefs.setString(USER_REMOTE_ID_KEY, user.remoteId),
      prefs.setString(USER_EMAIL_KEY, user.email),
      prefs.setString(USER_FIRSTNAME_KEY, user.firstname),
      prefs.setString(USER_LASTNAME_KEY, user.lastname),
      prefs.setString(USER_AVATAR_KEY, user.avatarUrl ?? ""),
      prefs.setBool(USER_IS_VERIFIED_KEY, user.isEmailVerified),
    ]);
  }

  Future<void> setHasAlreadySeenOnboarding() async {
    final prefs = await preferences;
    await prefs.setBool(HAS_ALREADY_SEEN_ONBOARDING, true);
  }

  Future<bool> hasAlreadySeenOnboarding() async {
    final prefs = await preferences;
    return prefs.containsKey(HAS_ALREADY_SEEN_ONBOARDING)
        ? prefs.getBool(HAS_ALREADY_SEEN_ONBOARDING)
        : false;
  }

  Future<User> getCurrentUser() async {
    final prefs = await preferences;
    try {
      final avatarUrl = prefs.getString(USER_AVATAR_KEY);
      final user = User(
        email: prefs.getString(USER_EMAIL_KEY),
        firstname: prefs.getString(USER_FIRSTNAME_KEY),
        lastname: prefs.getString(USER_LASTNAME_KEY),
        isEmailVerified: prefs.getBool(USER_IS_VERIFIED_KEY),
        remoteId: prefs.getString(USER_REMOTE_ID_KEY),
        avatarUrl: (avatarUrl?.isEmpty ?? true) ? null : avatarUrl,
      );
      return user;
    } catch (e, s) {
      _logger.e(e, error: e, stackTrace: s);
      return null;
    }
  }

  Future<void> saveAvatarInPrefs(String avatarUrl) async {
    final prefs = await preferences;
    await prefs.setString(USER_AVATAR_KEY, avatarUrl);
  }

  Future<void> deleteAvatarInPrefs() async {
    final prefs = await preferences;
    await prefs.setString(USER_AVATAR_KEY, "");
  }

  Future<bool> hasUser({bool isVerified = false}) async {
    final user = await getCurrentUser();

    if (isVerified) {
      return user.isValid && user.isEmailVerified;
    }
    return user.isValid;
  }

  Future<User> getRemoteUser(String userId) async {
    final snapshot = await CacheUtils.getDocumentFromCacheFirst(
        _db.collection(FirebaseCollections.users).doc(userId));
    return User.fromJson(snapshot.data());
  }

  Future<void> saveRemoteUser(String userId) async {
    final user = await getRemoteUser(userId);
    return saveUserInPreferences(user);
  }

  Future<void> updateAvatarUrl(String avatarUrl) async {
    final currentUser = await getCurrentUser();

    return _db
        .collection(FirebaseCollections.users)
        .doc(currentUser.remoteId)
        .update({'avatarUrl': avatarUrl});
  }

  Future<void> setRemoteUserVerified(String userId) async {
    return _db.collection(FirebaseCollections.users).doc(userId).set(
      {'isEmailVerified': true},
      SetOptions(merge: true),
    );
  }

  Future<bool> sendFriendInvitation(String email) async {
    try {
      final currentUser =
          await getRemoteUser((await getCurrentUser()).remoteId);

      final invitationResults = await _db
          .collection(FirebaseCollections.invitations)
          .where('receiver', isEqualTo: email)
          .where('sender', isEqualTo: currentUser.remoteId)
          .where('status', isEqualTo: StatusValue.pending)
          .limit(1)
          .get(GetOptions(source: Source.server));

      // if there is already an invitation notification in pending status stop here
      if (invitationResults.docs.isNotEmpty) return true;

      // check if user has at least one friend
      if (currentUser.hasFriends) {
        // get any user with the same email
        final friendsResults = await _db
            .collection(FirebaseCollections.users)
            .where('email', isEqualTo: email)
            .limit(1)
            .get(GetOptions(source: Source.server));

        if (friendsResults.docs.isNotEmpty &&
            currentUser.friendsIds.contains(friendsResults.docs.first.id)) {
          return false;
        }
      }

      await _db
          .collection(FirebaseCollections.invitations)
          .doc()
          .set(FriendInvitation(
            sender: currentUser.remoteId,
            receiver: email,
            status: Status.pending,
            createdAt: DateTime.now().toUtc(),
            updatedAt: DateTime.now().toUtc(),
          ).toJson());

      return true;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> _sendFriendInvitation(String email) async {
    try {
      // get remote user
      final currentUser =
          await getRemoteUser((await getCurrentUser()).remoteId);
      // get already sent invitation notification in pending status for the same email
      final invitationsResults = await _db
          .collection(FirebaseCollections.notifications)
          .where('receiver', isEqualTo: email)
          .where('data.sender', isEqualTo: currentUser.remoteId)
          .where('type', isEqualTo: model.NotificationTypeValue.invitation)
          .where('status', isEqualTo: StatusValue.pending)
          .limit(1)
          .get(GetOptions(source: Source.server));

      // if there is already an invitation notification in pending status stop here
      if (invitationsResults.docs.isNotEmpty) return true;

      // check if user has at least one friend
      if (currentUser.hasFriends) {
        // get any user with the same email
        final friendsResults = await _db
            .collection(FirebaseCollections.users)
            .where('email', isEqualTo: email)
            .limit(1)
            .get(GetOptions(source: Source.server));

        if (friendsResults.docs.isNotEmpty &&
            currentUser.friendsIds.contains(friendsResults.docs.first.id)) {
          return false;
        }
      }

      await _db.collection(FirebaseCollections.notifications).doc().set(
            model.Notification(
              receiver: email,
              type: model.NotificationType.invitation,
              data: Invitation(
                sender: currentUser.remoteId,
                senderName: currentUser.displayName,
              ).toJson(),
              createdAt: DateTime.now().toUtc(),
              updatedAt: DateTime.now().toUtc(),
              status: Status.pending,
              read: false,
            ).toJson(),
          );
      return true;
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateNotificationStatus(
      model.Notification notification, Status status) async {
    final currentUser = await getCurrentUser();
    final data = notification.data;

    data.putIfAbsent("receiverName", () => currentUser.displayName);
    return _db
        .collection(FirebaseCollections.notifications)
        .doc(notification.remoteId)
        .update(
          notification
              .copyWith(
                status: status,
                updatedAt: DateTime.now(),
                data: data,
              )
              .toJson(),
        );
  }

  Future<void> sendInvitationResponse(
      String invitationId, Status status) async {
    return _db
        .collection(FirebaseCollections.invitations)
        .doc(invitationId)
        .update({
      'status': ModelUtils.statusEnumToValue(status),
    });
  }

  Future<void> _sendInvitationResponse(
      model.Notification notification, Status status) async {
    final currentUser = await getCurrentUser();
    final data = notification.data;

    data.putIfAbsent("receiverName", () => currentUser.displayName);
    return _db
        .collection(FirebaseCollections.notifications)
        .doc(notification.remoteId)
        .update(
          notification
              .copyWith(
                status: status,
                updatedAt: DateTime.now(),
                data: data,
              )
              .toJson(),
        );
  }

  Future<void> setAllNotificationsAsRead(
      List<model.Notification> notifications) async {
    if (notifications != null && notifications.isNotEmpty) {
      final unreadNotifications =
          notifications.where((element) => !element.read);

      if (unreadNotifications.isNotEmpty) {
        final batch = _db.batch();
        unreadNotifications.forEach((element) {
          batch.update(
            _db
                .collection(FirebaseCollections.notifications)
                .doc(element.remoteId),
            element
                .copyWith(
                  read: true,
                )
                .toJson(),
          );
        });
        return batch.commit();
      }
    }
  }

  Future<void> createGoals(Goal goal) async {
    return _db.collection(FirebaseCollections.goals).doc().set(goal.toJson());
  }

  Future<void> updateGoal(Goal goal) async {
    return _db.collection(FirebaseCollections.goals).doc(goal.remoteId).set(
          goal
              .copyWith(
                updatedAt: DateTime.now(),
                refererUsers: null,
                assigneesUsers: null,
              )
              .toJson(),
          SetOptions(merge: true),
        );
  }

  Future<bool> isMysteryGoal(String goalId) async {
    try {
      final goal =
          await _db.collection(FirebaseCollections.goals).doc(goalId).get();

      if (goal.exists) {
        return goal.data()['isMystery'] != null &&
            goal.data()['isMystery'] == true;
      }
      return false;
    } catch (e, s) {
      _logger.e(e, error: e, stackTrace: s);
      throw e;
    }
  }

  Future<void> createTask(Task task) async {
    return _db.collection(FirebaseCollections.tasks).doc().set(task.toJson());
  }

  Future<void> updateTask(Task task) async {
    try {
      _db.collection(FirebaseCollections.tasks).doc(task.remoteId).update(
            task
                .copyWith(
                  assigneesUsers: null,
                  goal: null,
                  updatedAt: DateTime.now(),
                )
                .toJson(),
          );
    } catch (e, s) {
      _logger.e(e, error: e, stackTrace: s);
      _logger.d(task.toJson());
    }
  }

  Future<Chat> createChat(String participantId) async {
    final currentUser = await getCurrentUser();
    final now = DateTime.now();
    final participants = [currentUser.remoteId, participantId];

    final Chat chat = Chat(
      participantsIds: participants,
      createdAt: now,
      updatedAt: now,
    );

    final result =
        await _db.collection(FirebaseCollections.chats).add(chat.toJson());

    if (result != null) {
      return chat.copyWith(remoteId: result.id);
    }
    return null;
  }

  Future<bool> isFriend(String friendId) async {
    try {
      final localCurrentUser = await getCurrentUser();
      final currentUser = await getRemoteUser(localCurrentUser.remoteId);

      return currentUser.friendsIds.firstWhere(
            (element) => element == friendId,
            orElse: () => null,
          ) !=
          null;
    } catch (e, s) {
      _logger.e(e, error: e, stackTrace: s);
      return false;
    }
  }

  Future<void> addChatMessage(
      String chatId, String participantId, ChatMessage chatMessage) async {
    final currentUser = await getCurrentUser();

    final participants = [participantId, currentUser.remoteId];
    return _db
        .collection(FirebaseCollections.chatMessages)
        .doc()
        .set(chatMessage
            .copyWith(
              chatId: chatId,
              participantsIds: participants,
              senderId: currentUser.remoteId,
              receiverId: participantId,
            )
            .toJson());
  }

  Future<List<Chat>> getChatsList() async {
    List<Chat> chats = [];
    final query = await getChatsListQuery();

    final result = await query.get();

    if (result.docs.isNotEmpty) {
      result.docs.forEach((element) {
        chats.add(
          Chat.fromJson(element.data()).copyWith(remoteId: element.id),
        );
      });
    }

    return chats;
  }

  Future<Query> getChatsListQuery() async {
    final currentUser = await getCurrentUser();

    return _db
        .collection(FirebaseCollections.chats)
        .where('participantsIds', arrayContains: currentUser.remoteId)
        .orderBy('updatedAt', descending: true);
  }

  Future<Chat> findChatByParticipant(String participantId) async {
    final currentUser = await getCurrentUser();

    final result = await _db
        .collection(FirebaseCollections.chats)
        .where('participantsIds', arrayContains: participantId)
        .get();

    final result2 = await _db
        .collection(FirebaseCollections.chats)
        .where('participantsIds', arrayContains: currentUser.remoteId)
        .get();

    if (result.docs.isEmpty || result2.docs.isEmpty) {
      return null;
    }

    final document = result.docs.firstWhere(
      (element) {
        return result2.docs.firstWhere(
              (element2) => const ListEquality().equals(
                  element.data()['participantsIds'],
                  element2.data()['participantsIds']),
              orElse: () => null,
            ) !=
            null;
      },
      orElse: () => null,
    );

    if (document != null) {
      return Chat.fromJson(document.data()).copyWith(remoteId: document.id);
    }

    return null;
  }

  Query getChatMessagesByChatIdQuery(String chatId) {
    return _db
        .collection(FirebaseCollections.chatMessages)
        .where('chatId', isEqualTo: chatId)
        .orderBy('createdAt', descending: true);
  }

  Future<Query> get countUnreadReceivedMessages async {
    final currentUser = await getCurrentUser();

    return _db
        .collection(FirebaseCollections.chatMessages)
        .where('receiverId', isEqualTo: currentUser.remoteId)
        .where('read', isEqualTo: false);
  }

  Future<List<ChatMessage>> getChatMessagesByChatId(String chatId) async {
    List<ChatMessage> messages = [];

    final result = await getChatMessagesByChatIdQuery(chatId).get();

    if (result.docs.isNotEmpty) {
      result.docs.forEach((element) {
        messages.add(
          ChatMessage.fromJson(element.data()).copyWith(remoteId: element.id),
        );
      });
    }

    return messages;
  }

  Future<void> markSentChatMessagesAsRead(List<String> chatMessagesIds) {
    final WriteBatch writeBatch = _db.batch();

    chatMessagesIds.forEach((element) {
      writeBatch.update(
          _db.collection(FirebaseCollections.chatMessages).doc(element), {
        'read': true,
      });
    });

    return writeBatch.commit();
  }

  Future<List<User>> getFriends() async {
    final currentUser = await getCurrentUser();
    final List<User> friends = [];

    final snapshot = await _db
        .collection(FirebaseCollections.users)
        .doc(currentUser.remoteId)
        .get();

    if (!snapshot.exists) return [];

    final List<dynamic> friendsIds = snapshot.data()['friends'] ?? [];

    if (friendsIds.isEmpty) {
      return [];
    }

    final docs = await friendsIds.doAtEachRangeSizeAsync(
      10,
      (ids) async {
        final query = _db
            .collection(FirebaseCollections.users)
            .where('remoteId', whereIn: ids);

        final querySnapshot = await query.get();

        return querySnapshot.docs;
      },
    );

    // final query = _db
    //     .collection(FirebaseCollections.users)
    //     .where('remoteId', whereIn: friendsIds);

    // final querySnapshot = await query.get();

    docs.forEach((snapshot) {
      friends.add(User.fromJson(snapshot.data()));
    });

    return friends;
  }

  Future<void> removeFriend(String friendId) async {
    try {
      final currentUser = await getCurrentUser();
      await _db
          .collection(FirebaseCollections.users)
          .doc(currentUser.remoteId)
          .update({
        'friends': FieldValue.arrayRemove([friendId]),
      });
      await saveRemoteUser(currentUser.remoteId);
    } catch (e, s) {
      _logger.e(e, error: e, stackTrace: s);
    }
  }

  Future<List<MyTasksByFriend>> getMyTasksByFriends() async {
    List<MyTasksByFriend> results = [];

    var friends = await getFriends();

    if (friends.isEmpty) return results;

    print(friends);

    final myTasks = await getMyAssignedTasks();

    friends.forEach((friend) {
      var tasksAssignedByFriend =
          myTasks.where((task) => task.isAuthor(friend.remoteId)).toList();

      results.add(
        MyTasksByFriend(
          friend: friend,
          tasks: tasksAssignedByFriend,
        ),
      );
    });

    results = results.where((element) => element.totalTasks > 0).toList();

    return results;
  }

  Future<List<User>> getFriendsAndTheirStats() async {
    var friends = await getFriends();

    if (friends.isEmpty) return [];

    final friendsIds = friends.map((e) => e.remoteId).toList();

    try {
      final friendsCredits = await Future.wait(
          friends.map((e) => getLastCredits(user: e)).toList());

      final friendsTasks = await _getAssignedTasksByIds(friendsIds);

      _logger.d("friends tasks: $friendsTasks");

      friends = friends.map((friend) {
        List<Task> tasks = friendsTasks
            .where((task) => task.isUserAssigned(friend.remoteId))
            .toList();
        int totalTasks = tasks.length;
        int finishedTasks =
            tasks.where((task) => task.status.isDone).toList().length;
        CreditTransaction credits = friendsCredits.firstWhere(
          (element) => element.ownerId == friend.remoteId,
          orElse: () => CreditTransaction.createDefault(friend.remoteId),
        );

        return friend.copyWith(
          totalTasks: totalTasks,
          finishedTasks: finishedTasks,
          lastCredits: credits,
        );
      }).toList();

      friends.sort((a, b) => b.displayName.compareTo(a.displayName));

      return friends;
    } catch (e) {
      throw e;
    }
  }

  Future<CreditTransaction> getLastCredits({User user}) async {
    final currentUser = user ?? await getCurrentUser();

    final querySnapshot = await _db
        .collection(FirebaseCollections.creditTransaction)
        .where('ownerId', isEqualTo: currentUser.remoteId)
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      return CreditTransaction.createDefault(currentUser.remoteId);
    }

    return CreditTransaction.fromJson(querySnapshot.docs.first.data())
        .copyWith(remoteId: querySnapshot.docs.first.id);
  }

  Future<List<User>> getUsersByIds(List<String> usersIds) async {
    if (usersIds.isEmpty) return [];

    final docs = await usersIds.doAtEachRangeSizeAsync(
      10,
      (ids) async {
        final query = _db
            .collection(FirebaseCollections.users)
            .where('remoteId', whereIn: ids);

        final results = await query.get();
        return results.docs;
      },
    );
    // final query = _db
    //     .collection(FirebaseCollections.users)
    //     .where('remoteId', whereIn: usersIds);

    // final results = await query.get();

    return docs
        .map((document) =>
            User.fromJson(document.data()).copyWith(remoteId: document.id))
        .toList();
  }

  Future<List<Task>> _setUsersToTasks(List<Task> tasks) async {
    if (tasks == null || tasks.isEmpty) return [];

    final usersIds =
        tasks.expand((task) => task.assignees).toList().distinct<String>();

    final users = await getUsersByIds(usersIds);

    return tasks
        .map((task) => task.copyWith(
              assigneesUsers: users
                  .where((user) => task.isUserAssigned(user.remoteId))
                  .toList(),
            ))
        .toList();
  }

  Future<List<Task>> _setGoalToLinkedTasks(List<Task> tasks) async {
    if (tasks == null || tasks.isEmpty) return [];

    final goalsIds = tasks
        .where((task) => task.isLinkedToGoal)
        .map((task) => task.goalId)
        .toList();

    if (goalsIds.isEmpty) {
      return tasks;
    }

    final goals = await getGoalsByIds(goalsIds);

    if (goals.isNotEmpty) {
      tasks = tasks.map((task) {
        if (!task.isLinkedToGoal) {
          return task;
        }
        return task.copyWith(
          goal: goals.firstWhere(
            (element) => element.remoteId == task.goalId,
            orElse: () => null,
          ),
        );
      }).toList();
    }

    return tasks;
  }

  Future<List<Goal>> _setUsersToGoals(List<Goal> goals) async {
    final usersIds = goals
        .expand((goal) => [...goal.assignees, ...goal.referer])
        .toList()
        .distinct<String>();

    final users = await getUsersByIds(usersIds);

    return goals
        .map(
          (goal) => goal.copyWith(
            refererUsers: users
                .where(
                  (user) => goal.referer.contains(user.remoteId),
                )
                .toList(),
            assigneesUsers: users
                .where(
                  (user) => goal.assignees.contains(user.remoteId),
                )
                .toList(),
          ),
        )
        .toList();
  }

  Future<List<Qa>> getQA() async {
    List<Qa> qas = [];
    final resuls = await _db
        .collection(FirebaseCollections.faq)
        .orderBy('order', descending: false)
        .get();

    resuls.docs.forEach((document) {
      qas.add(Qa.fromJson(document.data()));
    });

    return qas;
  }

  Future<List<Goal>> getAllGoals() async {
    List<Goal> goals = [];
    final currentUser = await getCurrentUser();
    final query1 = _db
        .collection(FirebaseCollections.goals)
        .where('assignees', arrayContains: currentUser.remoteId);
    final query2 = _db
        .collection(FirebaseCollections.goals)
        .where('referer', arrayContains: currentUser.remoteId);

    final futures = [
      query1.get(),
      query2.get(),
    ];

    final results = await Future.wait(futures);
    final documents = [...results[0].docs, ...results[1].docs];

    goals = await getGoalsFromDocumentSnapshots(documents);

    goals.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

    return goals;
  }

  Future<List<Task>> getAllTasks() async {
    List<Task> tasks = [];
    final currentUser = await getCurrentUser();
    final query1 = _db
        .collection(FirebaseCollections.tasks)
        .where('authorId', isEqualTo: currentUser.remoteId)
        .orderBy('updatedAt', descending: true);

    final query2 = _db
        .collection(FirebaseCollections.tasks)
        .where('assignees', arrayContains: currentUser.remoteId)
        // .where('status', whereIn: [
        //   StatusValue.opened,
        //   StatusValue.done,
        //   StatusValue.pending,
        //   StatusValue.declined])
        .orderBy('updatedAt', descending: true);

    try {
      final results = await Future.wait<QuerySnapshot>([
        query1.get(),
        query2.get(),
      ]);

      final documentsSnapshots = ListUtils.distinct<DocumentSnapshot, String>(
        [...results[0].docs, ...results[1].docs],
        (document) => document.id,
      );

      tasks = await getTasksFromDocumentSnapshots(documentsSnapshots);

      return tasks..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    } catch (e) {
      _logger.e(e, error: e);
      return [];
    }
  }

  Future<List<Goal>> getAuthoredGoals({Status status = Status.opened}) async {
    List<Goal> goals = [];
    final currentUser = await getCurrentUser();

    final results = await _db
        .collection(FirebaseCollections.goals)
        .where('authorId', isEqualTo: currentUser.remoteId)
        .where('status', isEqualTo: ModelUtils.statusEnumToValue(status))
        .orderBy('updatedAt', descending: true)
        .get();

    results.docs.forEach((element) {
      goals.add(Goal.fromJson(element.data()).copyWith(
        remoteId: element.id,
      ));
    });

    goals = await _setUsersToGoals(goals);

    return goals;
  }

  Future<List<Task>> getAuthoredTasks({
    List<Status> statuses = const [Status.opened],
    List<String> assigneesIds = const [],
  }) async {
    List<Task> tasks = [];
    final currentUser = await getCurrentUser();

    var query = _db
        .collection(FirebaseCollections.tasks)
        .where('authorId', isEqualTo: currentUser.remoteId)
        .orderBy('updatedAt', descending: true);

    if (assigneesIds.isNotEmpty) {
      query = query.where('assignees', arrayContainsAny: assigneesIds);
    }

    if (statuses != null && statuses.isNotEmpty) {
      List<Future<QuerySnapshot>> futures = [];

      for (var status in statuses) {
        var q = query;
        q = q.where('status', isEqualTo: ModelUtils.statusEnumToValue(status));

        futures.add(q.get());
      }
      List<QuerySnapshot> snapshots = await Future.wait<QuerySnapshot>(futures);

      snapshots.forEach((snapshot) {
        _logger.d('snapshot documents length: ${snapshot.docs.length}');
        snapshot.docs.forEach((element) {
          tasks.add(Task.fromJson(element.data()).copyWith(
            remoteId: element.id,
          ));
        });
      });

      tasks.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    } else {
      final results = await query.get();

      results.docs.forEach((element) {
        tasks.add(Task.fromJson(element.data()).copyWith(
          remoteId: element.id,
        ));
      });
    }

    _logger.d("getAuthoredTasks results: $tasks");

    tasks = await _setUsersToTasks(tasks);

    return tasks;
  }

  Future<void> unlinkTask(String taskId) async {
    try {
      await _db.collection(FirebaseCollections.tasks).doc(taskId).update({
        'goalId': null,
      });
    } on Exception {}
  }

  Future<List<Task>> getMyAssignedTasks({
    List<Status> statuses,
    String authorId,
  }) async {
    List<Task> tasks = [];
    final currentUser = await getCurrentUser();
    print(currentUser.toString());

    var query = _db
        .collection(FirebaseCollections.tasks)
        .where('assignees', arrayContains: currentUser.remoteId);

    if (authorId != null) {
      query = query.where('authorId', isEqualTo: authorId);
    }

    if (statuses != null && statuses.isNotEmpty) {
      query = query.where(
        'status',
        whereIn: statuses
            .map((status) => ModelUtils.statusEnumToValue(status))
            .toList(),
      );
    }

    final results = await query.orderBy('updatedAt', descending: true).get();

    results.docs.forEach((element) {
      tasks.add(Task.fromJson(element.data()).copyWith(
        remoteId: element.id,
      ));
    });

    tasks = await _setUsersToTasks(tasks);

    return tasks;
  }

  Future<List<Task>> _getAssignedTasksByIds(List<String> ids) async {
    final List<Task> tasks = [];

    final query = _db
        .collection(FirebaseCollections.tasks)
        .where('assignees', arrayContainsAny: ids);

    final results = await query.get();

    results.docs.forEach((element) {
      tasks.add(Task.fromJson(element.data()).copyWith(
        remoteId: element.id,
      ));
    });

    return tasks;
  }

  Future<void> claimGoal(Goal goal) async {
    assert(goal != null);
    final currentUser = await getCurrentUser();
    Claim claim = Claim(
      goalId: goal.remoteId,
      authorId: currentUser.remoteId,
      createdAt: DateTime.now(),
      goalType: goal.goalType,
      points: goal.points,
    );

    try {
      await _db
          .collection(FirebaseCollections.claims)
          .doc()
          .set(claim.toJson());
      await updateGoal(goal);
    } catch (e, s) {
      _logger.e(e, error: e, stackTrace: s);
      throw e;
    }
  }

  Future<Claim> getLastUserClaim(String goalId) async {
    assert(goalId != null);
    final currentUser = await getCurrentUser();

    final query = _db
        .collection(FirebaseCollections.claims)
        .where('goalId', isEqualTo: goalId)
        .where('authorId', isEqualTo: currentUser.remoteId)
        .orderBy('createdAt', descending: true)
        .limit(1);

    final result = await query.get();

    if (result.docs.length > 0) {
      return Claim.fromJson(result.docs.first.data());
    }
    return null;
  }

  Future<List<Goal>> getGoalsByIds(List<String> goalsIds) async {
    List<Goal> goals = [];

    if (goalsIds != null && goalsIds.isNotEmpty) {
      final docs = await goalsIds.doAtEachRangeSizeAsync<QueryDocumentSnapshot>(
        10,
        (ids) async {
          final results = await _db
              .collection(FirebaseCollections.goals)
              .where(FieldPath.documentId, whereIn: ids)
              .get();

          return results.docs;
        },
      );
      // final results = await _db
      //     .collection(FirebaseCollections.goals)
      //     .where(FieldPath.documentId, whereIn: goalsIds)
      //     .get();

      _logger.d("docs length ${docs.length}");

      docs.forEach((element) {
        goals.add(Goal.fromJson(element.data()).copyWith(
          remoteId: element.id,
        ));
      });
    }

    return goals;
  }

  Future<List<Task>> getTasksByIds(List<String> tasksIds) async {
    _logger.d('getTasksByIds');
    List<Task> tasks = [];

    if (tasksIds != null && tasksIds.isNotEmpty) {
      if (tasksIds.length == 1) {
        final result = await _db
            .collection(FirebaseCollections.tasks)
            .doc(tasksIds.first)
            .get();

        tasks.add(Task.fromJson(result.data()).copyWith(
          remoteId: result.id,
        ));
      } else {
        final docs = await tasksIds.doAtEachRangeSizeAsync(
          10,
          (ids) async {
            final results = await _db
                .collection(FirebaseCollections.tasks)
                .where(FieldPath.documentId, whereIn: ids)
                .get();

            return results.docs;
          },
        );
        // final results = await _db
        //     .collection(FirebaseCollections.tasks)
        //     .where(FieldPath.documentId, whereIn: tasksIds)
        //     .get();

        _logger.d("results ${docs.length}");

        docs.forEach((element) {
          tasks.add(Task.fromJson(element.data()).copyWith(
            remoteId: element.id,
          ));
        });
      }
    }

    _logger.d("tasks $tasks");
    _logger.d("tasksIds $tasksIds");

    tasks = await _setUsersToTasks(tasks);

    return tasks;
  }

  Future<List<Goal>> getMyAssignedGoals({Status status}) async {
    final currentUser = await getCurrentUser();

    var query = _db
        .collection(FirebaseCollections.goals)
        .where('assignees', arrayContains: currentUser.remoteId);

    if (status != null) {
      query = query.where(
        'status',
        isEqualTo: ModelUtils.statusEnumToValue(status),
      );
    }

    final results = await query
        .orderBy(
          'updatedAt',
          descending: true,
        )
        .get();

    return getGoalsFromQuerySnapshot(results);
  }

  Future<List<Task>> getTasksFromDocumentSnapshots(
      List<DocumentSnapshot> documentSnapshots) async {
    List<Task> tasks = [];

    documentSnapshots.forEach((element) {
      tasks.add(Task.fromJson(element.data()).copyWith(
        remoteId: element.id,
      ));
    });

    tasks = await _setUsersToTasks(tasks);
    tasks = await _setGoalToLinkedTasks(tasks);

    return tasks;
  }

  Future<void> openGoal(String goalId) async {
    try {
      await _db.collection(FirebaseCollections.goals).doc(goalId).update({
        'status': ModelUtils.statusEnumToValue(Status.opened),
      });
    } on Exception {}
  }

  Future<List<Goal>> getGoalsFromQuerySnapshot(
      QuerySnapshot querySnapshot) async {
    return getGoalsFromDocumentSnapshots(querySnapshot.docs);
  }

  Future<List<Goal>> getGoalsFromDocumentSnapshots(
      List<DocumentSnapshot> documentSnapshots) async {
    List<Goal> goals = [];

    documentSnapshots.forEach((element) {
      goals.add(Goal.fromJson(element.data()).copyWith(
        remoteId: element.id,
      ));
    });

    goals = await _setUsersToGoals(goals);

    return goals;
  }

  Future<void> updateTaskStatus(Task task, Status status) async {
    final data = task
        .copyWith(
          status: status,
          updatedAt: DateTime.now().toUtc(),
          assigneesUsers: null,
          goal: null,
        )
        .toJson();

    _logger.d("updateTaskStatus data: $data");
    try {
      await _db
          .collection(FirebaseCollections.tasks)
          .doc(task.remoteId)
          .update(data);
    } catch (e, s) {
      _logger.e(e, error: e, stackTrace: s);
    }
  }

  Future<void> updateTaskStatusByTaskId(String taskId, Status status) async {
    final result =
        await _db.collection(FirebaseCollections.tasks).doc(taskId).get();
    final task = Task.fromJson(result.data()).copyWith(remoteId: result.id);

    if (!task.status.isUpgrade(status)) return;

    return updateTaskStatus(task, status);
  }

  Future<Query> get getLastCreditsQuery async {
    final currentUser = await getCurrentUser();

    return _db
        .collection(FirebaseCollections.creditTransaction)
        .where('ownerId', isEqualTo: currentUser.remoteId)
        .orderBy('createdAt', descending: true)
        .limit(1);
  }

  Future<List<Query>> get getAllTasksQueries async {
    final currentUser = await getCurrentUser();
    final query1 = _db
        .collection(FirebaseCollections.tasks)
        .where('authorId', isEqualTo: currentUser.remoteId)
        .orderBy('updatedAt', descending: true);

    final query2 = _db
        .collection(FirebaseCollections.tasks)
        .where('assignees', arrayContains: currentUser.remoteId)
        .orderBy('updatedAt', descending: true);

    return [query1, query2];
  }

  Future<List<Query>> get getAllGoalsQueries async {
    final currentUser = await getCurrentUser();
    final query1 = _db
        .collection(FirebaseCollections.goals)
        .where('assignees', arrayContains: currentUser.remoteId)
        .orderBy(
          'updatedAt',
          descending: true,
        );
    final query2 = _db
        .collection(FirebaseCollections.goals)
        .where('referer', arrayContains: currentUser.remoteId)
        .orderBy(
          'updatedAt',
          descending: true,
        );

    return [query1, query2];
  }

  Future<Query> get myAssignedGoalsQuery async {
    final currentUser = await getCurrentUser();

    return _db
        .collection(FirebaseCollections.goals)
        .where('assignees', arrayContains: currentUser.remoteId)
        .orderBy(
          'updatedAt',
          descending: true,
        );
  }

  Future<Query> get pendingNotificationsQuery async {
    final currentUser = await getCurrentUser();
    return _db
        .collection(FirebaseCollections.notifications)
        .where(
          'receiver',
          isEqualTo: currentUser.email,
        )
        .where(
          'status',
          isEqualTo: ModelUtils.statusEnumToValue(Status.pending),
        )
        .orderBy(
          "updatedAt",
          descending: true,
        );
  }

  Future<Query> get sentNotificationsQuery async {
    final currentUser = await getCurrentUser();
    return _db
        .collection(FirebaseCollections.notifications)
        .where(
          'data.sender',
          isEqualTo: currentUser.remoteId,
        )
        .where(
          'status',
          isEqualTo: ModelUtils.statusEnumToValue(Status.done),
        )
        .orderBy(
          "updatedAt",
          descending: true,
        );
  }

  Future<Query> get notClosedNotificationsQuery async {
    final currentUser = await getCurrentUser();
    return _db
        .collection(FirebaseCollections.notifications)
        .where('receiver', isEqualTo: currentUser.email)
        .orderBy(
          "updatedAt",
          descending: true,
        );
  }

  Future<Query> get lastCreditsQuery async {
    final currentUser = await getCurrentUser();

    return _db
        .collection(FirebaseCollections.creditTransaction)
        .where('ownerId', isEqualTo: currentUser.remoteId)
        .orderBy('createdAt', descending: true)
        .limit(1);
  }

  @override
  void dispose() {
    _onFcmTokenRefreshSubscription?.cancel();
  }
}
