import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:yulli/abstracts/base_sign_form_viewmodel.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/constants/firebase_auth_error_codes.dart';
import 'package:yulli/exceptions/app_auth_exception.dart';
import 'package:yulli/exceptions/network_connection_error.dart';
import 'package:yulli/exceptions/unexpected_error.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/services/notification_service.dart';

class AuthService {
  final DbService dbService;
  final NotificationService notificationService;
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final MyLogger logger = MyLogger("AuthService");

  AuthService({
    @required this.dbService,
    @required this.notificationService,
  }) : assert(dbService != null);

  Future<void> signOut() {
    return Future.wait([
      dbService.clear(preserveSeenOnboarding: true),
      _auth.signOut(),
      notificationService.logout(),
    ]);
  }

  Future<User> register(
    String email,
    String password,
    String lastname,
    String firstname,
  ) async {
    try {
      // register user
      final authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      var user = User(
        email: email,
        firstname: firstname,
        lastname: lastname,
        isEmailVerified: authResult.user.emailVerified,
        remoteId: authResult.user.uid,
      );

      await Future.wait([
        dbService.saveUserInPreferences(user),
        // create user in firestore
        dbService.createUser(user),
        // update firebase auth's user profile info
        authResult.user.updateProfile(displayName: user.displayName),
        // send verification email
        authResult.user.sendEmailVerification(),
      ]);

      return user;
    } on PlatformException catch (error) {
      if (error.code == FirebaseAuthErrorCodes.networkRequestFailed) {
        throw new NetworkConnectionException(error.message);
      } // TODO: check for too many requests
      throw firebase_auth.FirebaseAuthException(
          message: error.message, code: error.code);
    } on firebase_auth.FirebaseAuthException catch (error) {
      throw error;
    } catch (error) {
      throw UnexpectedException(error.message);
    }
  }

  Future<User> login(String email, String password) async {
    try {
      final authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      final user = await dbService.getRemoteUser(authResult.user.uid);

      if (!user.isValid) {
        throw firebase_auth.FirebaseAuthException(
            message: null, code: FirebaseAuthErrorCodes.userNotFound);
      }

      await dbService.saveAppClient(user.remoteId);

      await dbService.saveUserInPreferences(user);

      return user;
    } on PlatformException catch (error) {
      print(error);
      if (error.code == FirebaseAuthErrorCodes.networkRequestFailed) {
        throw new NetworkConnectionException(error.message);
      } // TODO: check for too many requests
      throw new firebase_auth.FirebaseAuthException(
          message: error.message, code: error.code);
    } on firebase_auth.FirebaseAuthException catch (error) {
      throw error;
    } catch (error, s) {
      logger.e(error.message, error: error, stackTrace: s);
      throw new UnexpectedException(error.message);
    }
  }

  Future<void> sendPasswordRecoverRequest(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on PlatformException catch (e) {
      if (e.code == FirebaseAuthErrorCodes.networkRequestFailed) {
        throw new NetworkConnectionException(e.message);
      }
      throw new firebase_auth.FirebaseAuthException(
          message: e.message, code: e.code);
    } on firebase_auth.FirebaseAuthException catch (e) {
      logger.e(e.message, error: e);
      throw new UnexpectedException(e.message);
    } catch (e) {
      logger.e(e.message, error: e);
      throw new UnexpectedException(e.message);
    }
  }

  Future<firebase_auth.User> getAuthUser({bool reload = true}) async {
    final user = await _auth.currentUser;
    if (user == null) return null;
    try {
      if (reload) {
        await user.reload();
        return _auth.currentUser;
      }
      return user;
    } catch (e, s) {
      logger.e(e, error: e, stackTrace: s);
      await signOut();
      return null;
    }
  }

  Future<void> sendEmailVerification() async {
    final user = await getAuthUser(reload: false);
    return user.sendEmailVerification();
  }
}
