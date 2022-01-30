import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/screens/main/navigators/tasks/pages/viewmodels/tasks_root_page_viewmodel.dart';
import 'package:yulli/screens/main/navigators/tasks/pages/widgets/tasks_root_page_body.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/services/tasks_service.dart';

class TasksRootPage extends StatelessWidget {
  const TasksRootPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TasksRootViewModel>(
      create: (_) => TasksRootViewModel(
        Provider.of<DbService>(context, listen: false),
        Provider.of<TasksService>(context, listen: false),
      ),
      child: TasksRootPageBody(),
    );
  }
}
