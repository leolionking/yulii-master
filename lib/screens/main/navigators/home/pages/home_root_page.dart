import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/screens/main/navigators/home/pages/viewmodels/home_root_page_viewmodel.dart';
import 'package:yulli/screens/main/navigators/home/pages/widgets/home_root_page_body.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/services/tasks_service.dart';

class HomeRootPage extends StatelessWidget {
  HomeRootPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeRootPageViewModel>(
      create: (_) => HomeRootPageViewModel(
          Provider.of<DbService>(context, listen: false),
          Provider.of<TasksService>(context, listen: false)),
      child: HomeRootPageBody(),
    );
  }
}
