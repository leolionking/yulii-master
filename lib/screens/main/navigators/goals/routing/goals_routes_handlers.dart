import 'package:fluro_fork/fluro_fork.dart';
import 'package:yulli/screens/main/navigators/goals/pages/goals_root_page.dart';

class GoalsRoutesHandler {
  static final goalsRootPage = Handler(
    handlerFunc: (_, __) => GoalsRootPage(),
  );
}
