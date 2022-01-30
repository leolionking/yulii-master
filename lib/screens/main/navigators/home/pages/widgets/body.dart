import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/status.dart';
import 'package:yulli/screens/main/navigators/home/pages/viewmodels/home_root_page_viewmodel.dart';
import 'package:yulli/services/app_data.dart';
import 'package:yulli/widgets/collapsed_header.dart';
import 'package:yulli/widgets/deals_widget.dart';
import 'package:yulli/widgets/fixed_header.dart';
import 'package:yulli/widgets/if_else_widget.dart';
import 'package:yulli/widgets/my_silver_appbar.dart';

class HomeRootBody extends StatefulWidget {
  HomeRootBody({Key key}) : super(key: key);

  @override
  _HomeRootBodyState createState() => _HomeRootBodyState();
}

class _HomeRootBodyState extends State<HomeRootBody> {
  final MyLogger _logger = MyLogger("HomeRootBody");

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeRootPageViewModel>(context, listen: false).refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Consumer<HomeRootPageViewModel>(
      builder: (context, _viewModel, __) {
        return IfElseWidget(
          condition: !_viewModel.loading,
          ifWidget: MySylverAppbar(
            localization.labels.myLastDeals,
            _viewModel.tasks.length,
            400,
            "assets/images/flower_only.png",
            170,
            Column(
              children: <Widget>[
                FixedHeader(
                  currentUser:
                      Provider.of<AppDataService>(context, listen: false)
                          .currentUser,
                  finishedTasksCount: _viewModel.finishedTasksLength,
                ),
              ],
            ),
            CollapsedHeader(
              goals: _viewModel.goals,
            ),
            Container(
              color: Colors.white,
              child: DealsWidget(
                _viewModel?.tasks,
                hasTranslation: true,
                onTaskItemTap: (task) {
                  _logger.d("on task item tap: $task");
                },
                onTaskItemStatusIconTap: (task) {
                  _viewModel.updateTaskToNextStatus(task);
                },
              ),
            ),
          ),
          elseWidget: const Align(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
