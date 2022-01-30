import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yulli/screens/main/ui/bottom_navigation.dart';

class BottomNavigationRoutesObserver extends RouteObserver<PageRoute<dynamic>> {
  final BehaviorSubject<BottomNavigationTab> _currentTabItem =
      BehaviorSubject();

  Stream<BottomNavigationTab> get tabItem => _currentTabItem.distinct();
  Future<BottomNavigationTab> get currentTabItem => _currentTabItem.first;

  @override
  void didPush(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);
    if (route is PageRoute) {
      final item = TabHelper.itemFromRoute(route.settings.name);

      if (item != null) {
        _currentTabItem.add(item);
      }
    }
  }

  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);

    if (previousRoute is PageRoute) {
      final item = TabHelper.itemFromRoute(previousRoute.settings.name);

      if (item != null) {
        _currentTabItem.add(item);
      }
    }
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);

    if (newRoute is PageRoute) {
      final item = TabHelper.itemFromRoute(newRoute.settings.name);

      if (item != null) {
        _currentTabItem.add(item);
      }
    }
  }

  void dispose() {
    _currentTabItem.close();
  }
}
