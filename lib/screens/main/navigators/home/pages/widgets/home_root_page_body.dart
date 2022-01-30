import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/common/viewmodels/main_components_view_model.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/status.dart';
import 'package:yulli/models/task.dart';
import 'package:yulli/routing/app_router.dart';
import 'package:yulli/screens/main/navigators/home/pages/viewmodels/home_root_page_viewmodel.dart';
import 'package:yulli/screens/main/routing/bottom_navigation_router.dart';
import 'package:yulli/services/app_data.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/services/goals_service.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/collapsed_header.dart';
import 'package:yulli/widgets/deal_widget.dart';
import 'package:yulli/widgets/fixed_header.dart';
import 'package:yulli/widgets/if_else_widget.dart';
import 'package:yulli/widgets/my_sliver_list_builder.dart';
import 'package:yulli/widgets/yulii_sliver_body.dart';
import 'package:yulli/extensions/index.dart';
import 'package:yulli/widgets/yulli_add_task_bottom_sheet.dart';

class HomeRootPageBody extends StatefulWidget {
  const HomeRootPageBody({Key key}) : super(key: key);

  @override
  _HomeRootPageBodyState createState() => _HomeRootPageBodyState();
}

class _HomeRootPageBodyState extends State<HomeRootPageBody> {
  final MyLogger _logger = MyLogger('HomeRootPageBody');
  final ScrollController _controller = ScrollController();

  void _onItemTap(BuildContext context, Task task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
      ),
      builder: (_) => YulliAddTaskBottomSheet(
        task: task,
      ),
    );
  }

  void _onItemIconTap(BuildContext context, Task task) {
    Provider.of<DbService>(context, listen: false)
        .updateTaskStatus(task, task.status.next);
  }

  void _onScrollControllerListener() {
    final mainComponentViewModel =
        Provider.of<MainComponentViewModel>(context, listen: false);

    if (_controller.position.userScrollDirection.isForward) {
      mainComponentViewModel.setDialVisible(true);
    } else if (_controller.position.userScrollDirection.isReverse &&
        _controller.offset >= 120) {
      mainComponentViewModel.setDialVisible(false);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(this._onScrollControllerListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeRootPageViewModel>(context, listen: false).init();
    });
  }

  @override
  void dispose() {
    _controller.removeListener(this._onScrollControllerListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final appData = Provider.of<AppDataService>(context, listen: false);

    return Consumer<HomeRootPageViewModel>(
      builder: (context, _viewModel, child) {
        return IfElseWidget(
          condition: !_viewModel.loading,
          ifWidget: YuliiSliverBody(
            controller: _controller,
            minHeaderHeight: 152,
            maxHeaderHeight: 400,
            bodyBadgeCount: _viewModel.tasks.length,
            headerBackgroundImage: AssetImage("assets/images/flower_only.png"),
            headerFixedArea: FixedHeader(
              currentUser: appData.currentUser,
              finishedTasksCount: _viewModel.finishedTasksLength,
            ),
            headerBackground: StreamBuilder(
              stream: Provider.of<GoalsService>(context).assignedGoals,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return CollapsedHeader(
                  goals: snapshot.hasData ? snapshot.data : [],
                );
              },
            ),
            bodyTitle: localization.labels.myLastDeals,
            body: MySliverListBuilder<Task>(
              items: _viewModel.tasks,
              onItemBuilder: (_, currentTask, index) {
                return DealWidget(
                  key: ValueKey(
                    currentTask.remoteId + currentTask.updatedAt.toString(),
                  ),
                  task: currentTask,
                  onItemTap: (task) => this._onItemTap(context, task),
                  onStatusIconTap: (task) => this._onItemIconTap(context, task),
                  onCanChangeStatus: (status, _) => status.isOpened,
                );
              },
            ),
          ),
          elseWidget: child,
        );
      },
      child: const Align(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
