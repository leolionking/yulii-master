import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class ConnectivityService extends ChangeNotifier {
  StreamSubscription _connectivityListenerSubscription;
  BehaviorSubject<bool> _connectivityStreamController =
      BehaviorSubject.seeded(false);

  bool _isConnected;

  bool get connected => _isConnected;

  void init() {
    _connectivityListenerSubscription ??=
        Connectivity().onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none) {
        _setConnectivity(false);
      } else {
        _setConnectivity(true);
      }
    });
  }

  void _setConnectivity(bool connected) {
    _connectivityStreamController.add(connected);
    _isConnected = connected;
    notifyListeners();
  }

  @override
  void dispose() {
    _connectivityStreamController.close();
    _connectivityListenerSubscription?.cancel();
    super.dispose();
  }
}
