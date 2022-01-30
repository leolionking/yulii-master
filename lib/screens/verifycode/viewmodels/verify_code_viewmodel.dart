import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yulli/exceptions/throttling_exception.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/services/auth_service.dart';
import 'package:yulli/services/db_service.dart';

class VerifyCodeViewModel extends ChangeNotifier {
  final AuthService authService;
  final DbService dbService;

  static const THROTTLE_IN_SECONDS = 60;

  bool _checking = false;
  bool _resending = false;
  BehaviorSubject<bool> _submitting = BehaviorSubject.seeded(false);
  DateTime _throttleTime;
  int _throttleIncrement = 0;

  VerifyCodeViewModel(this.authService, this.dbService);

  bool get checking => _checking;
  bool get resending => _resending;
  Stream<bool> get submitting => _submitting.distinct();
  DateTime get throttleTime => _throttleTime;
  int get throttleDiff =>
      _throttleTime
          ?.add(Duration(
            seconds: THROTTLE_IN_SECONDS * pow(2, _throttleIncrement),
          ))
          ?.difference(DateTime.now())
          ?.inSeconds ??
      0;

  bool _throttleCan() {
    if (_throttleTime == null) return true;
    final now = DateTime.now();

    return _throttleTime
        .add(
          Duration(
            seconds: THROTTLE_IN_SECONDS * pow(2, _throttleIncrement),
          ),
        )
        .isBefore(now);
  }

  void setChecking(bool checking) {
    _checking = checking;
    setSubmitting(checking);
    notifyListeners();
  }

  void setResending(bool sending) {
    _resending = sending;
    setSubmitting(sending);
    notifyListeners();
  }

  void setSubmitting(bool submitting) {
    _submitting.add(submitting);
  }

  void setThrottle() {
    _throttleTime = DateTime.now();
    _throttleIncrement = _throttleIncrement + 1;
    notifyListeners();
  }

  Future<void> resendVerfification() async {
    if (!_throttleCan()) {
      throw new ThrottlingException();
    }
    setResending(true);
    try {
      await authService.sendEmailVerification();
      setThrottle();
    } catch (e) {
      setResending(false);
      throw e;
    }
    setResending(false);
  }

  Future<bool> checkVerification() async {
    setChecking(true);
    try {
      final authUser = await authService.getAuthUser();

      if (!authUser.emailVerified) {
        setChecking(false);
        return false;
      }
      await Future.wait([
        dbService.setRemoteUserVerified(authUser.uid),
        dbService.saveRemoteUser(authUser.uid)
      ]);
      setChecking(false);
    } catch (e) {
      setChecking(false);
      throw e;
    }
    return true;
  }

  @override
  void dispose() {
    _submitting.close();
    super.dispose();
  }
}
