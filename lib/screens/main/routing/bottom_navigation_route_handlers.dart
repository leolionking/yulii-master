import 'package:fluro_fork/fluro_fork.dart';
import 'package:yulli/screens/main/navigators/goals/goals_navigator.dart';
import 'package:yulli/screens/main/navigators/home/home_navigator.dart';
import 'package:yulli/screens/main/navigators/profile/user_profile_navigator.dart';
import 'package:yulli/screens/main/navigators/tasks/tasks_navigator.dart';

class BottomNavigationRouteHandlers {
  static final homeNavigator = Handler(
    handlerFunc: (_, __) => HomeNavigator(),
  );

  static final tasksNavigator = Handler(
    handlerFunc: (_, __) => TasksNavigator(),
  );

  static final goalsNavigator = Handler(
    handlerFunc: (_, __) => GoalsNavigator(),
  );

  static final profileNavigator = Handler(
    handlerFunc: (_, __) => UserProfileNavigator(),
  );
}
