import 'package:flutter/material.dart';

abstract class BaseRouter {
  GlobalKey<NavigatorState> get navigatorKey;

  bool canPop() => navigatorKey.currentState.canPop();

  void pop() => navigatorKey.currentState.pop();
}
