import 'package:fluro_fork/fluro_fork.dart';
import 'package:yulli/screens/main/navigators/tasks/pages/tasks_root_page.dart';

class TasksRoutesHandlers {
  static final tasksRootPage = Handler(
    handlerFunc: (_, __) => TasksRootPage(),
  );
}
