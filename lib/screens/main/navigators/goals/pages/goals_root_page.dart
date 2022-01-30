import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/common/enums/filters.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/constants/asset_images.dart';
import 'package:yulli/models/goal.dart';
import 'package:yulli/models/goal_obj.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/screens/main/navigators/goals/pages/viewmodels/goals_root_page_viewmodel.dart';
import 'package:yulli/screens/main/navigators/goals/pages/widgets/goals_root_page_body.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/services/goals_service.dart';
import 'package:yulli/themes/yulli_themes.dart';
import 'package:yulli/widgets/goal_widget.dart';
import 'package:yulli/widgets/my_collapsed_header.dart';
import 'package:yulli/widgets/my_fixed_header.dart';
import 'package:yulli/widgets/my_silver_appbar.dart';

import '../../../../../localizations.dart';

class GoalsRootPage extends StatefulWidget {
  GoalsRootPage({Key key}) : super(key: key);

  @override
  _GoalsRootPageState createState() => _GoalsRootPageState();
}

class _GoalsRootPageState extends State<GoalsRootPage> {
  final MyLogger logger = MyLogger("_GoalsRootPageState");

  List<String> baseLabels = [];
  List<String> labels = [];
  List<User> friends = [];
  int _currentFilterIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GoalsRootPageViewModel>(
      create: (_) => GoalsRootPageViewModel(
        Provider.of<DbService>(context, listen: false),
        Provider.of<GoalsService>(context, listen: false),
      ),
      child: GoalsRootPageBody(),
    );
  }
}
