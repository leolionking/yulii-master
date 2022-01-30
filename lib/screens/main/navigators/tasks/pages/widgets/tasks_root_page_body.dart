import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/common/enums/filters.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/common/viewmodels/main_components_view_model.dart';
import 'package:yulli/constants/asset_images.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/status.dart';
import 'package:yulli/models/task.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yulli/screens/main/navigators/tasks/pages/viewmodels/tasks_root_page_viewmodel.dart';
import 'package:yulli/services/app_data.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/widgets/centered_circular_progress.dart';
import 'package:yulli/widgets/deal_widget.dart';
import 'package:yulli/widgets/if_else_widget.dart';
import 'package:yulli/widgets/my_collapsed_header.dart';
import 'package:yulli/widgets/my_fixed_header.dart';
import 'package:yulli/widgets/my_sliver_list_builder.dart';
import 'package:yulli/widgets/no_data.dart';
import 'package:yulli/widgets/yulii_sliver_body.dart';
import 'package:yulli/extensions/index.dart';
import 'package:yulli/widgets/yulli_add_task_bottom_sheet.dart';

class TasksRootPageBody extends StatefulWidget {
  TasksRootPageBody({Key key}) : super(key: key);

  @override
  _TasksRootPageBodyState createState() => _TasksRootPageBodyState();
}

class _TasksRootPageBodyState extends State<TasksRootPageBody> {
  final MyLogger logger = MyLogger("TaskRootPageBody");
  final ScrollController _controller = ScrollController();

  List<String> baseLabels = [];

  var silverHeight = 300.0;
  int _currentFilterIndex = 0;

  void _onItemTap(BuildContext context, Task task) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
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

  void _onItemIconTap(BuildContext context, Task task) async {
    final localization = AppLocalization.of(context);
    try {
      if (task.goal != null && task.goal.status.isPending) {
        Fluttertoast.showToast(
          msg: localization.notices.linkedRewardIsStillPending,
          toastLength: Toast.LENGTH_LONG,
        );
        return;
      }
      print('here');
      await Provider.of<DbService>(context, listen: false)
          .updateTaskStatus(task, task.status.next);
    } catch (e) {
      logger.e(e, error: e);
    }
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
      Provider.of<TasksRootViewModel>(context, listen: false).init();
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
    final appData = Provider.of<AppDataService>(context, listen: false);
    final localization = AppLocalization.of(context);

    return Consumer<TasksRootViewModel>(
      builder: (context, _viewModel, child) {
        print('rebuild');
        final friends = _viewModel.friends;

        if (baseLabels.isEmpty) {
          baseLabels = Filter.values
              .map((e) => FilterHelper.name(
                    e,
                    isTask: true,
                    context: context,
                  ))
              .toList();
        }

        final labels = [...baseLabels];
        friends.forEach((user) {
          labels.add(user.firstname);
        });

        final currentUser = appData.currentUser;
        final filteredTasks = _viewModel.tasks.where((task) {
          if (_currentFilterIndex == 0) return true;
          if (_currentFilterIndex == 1) {
            return task.assignees.contains(currentUser.remoteId);
          }
          final friend = friends[_currentFilterIndex - 2];
          return task.assignees.contains(friend.remoteId);
        }).toList();

        return IfElseWidget(
          condition: !_viewModel.loading,
          ifWidget: YuliiSliverBody(
            controller: _controller,
            minHeaderHeight: 64,
            maxHeaderHeight: 276,
            bodyBadgeCount: filteredTasks.length,
            headerBackgroundImage: AssetImage(AssetImages.mozaic),
            headerFixedArea: MyFixedHeader(
              title: localization.screens.deals,
            ),
            headerBackground: MyCollapsedHeader(
              current: _currentFilterIndex,
              onTap: (index) {
                setState(() {
                  _currentFilterIndex = index;
                });
              },
              labels: labels,
              searchHint: localization.actions.searchDeal,
              onSearchValueChanged: _viewModel.search,
            ),
            bodyTitle: labels[_currentFilterIndex],
            body: filteredTasks.isNotEmpty
                ? MySliverListBuilder<Task>(
                    items: filteredTasks,
                    onItemBuilder: (_, currentTask, index) {
                      return DealWidget(
                        key: ValueKey(
                          currentTask.remoteId +
                              currentTask.updatedAt.toString(),
                        ),
                        task: currentTask,
                        onItemTap: (task) => this._onItemTap(context, task),
                        onStatusIconTap: (task) =>
                            this._onItemIconTap(context, task),
                        onCanChangeStatus: (status, task) {
                          return ((status.isOpened &&
                                      task.isUserAssigned(
                                          appData.currentUser.remoteId)) ||
                                  (status.isPending &&
                                      task.isAuthor(
                                          appData.currentUser.remoteId))) &&
                              (task.goal == null ||
                                  !task.goal.status.isPending);
                        },
                        avatarBorderColor: _currentFilterIndex == 0
                            ? currentTask.isUserAssigned(
                                    appData.currentUser.remoteId)
                                ? AppColors.primary
                                : AppColors.secondary
                            : null,
                        avatarBorderWidth: 2,
                      );
                    },
                  )
                : SliverFillRemaining(
                    hasScrollBody: false,
                    child: NoData(
                      text: localization.labels.noDeal,
                    ),
                  ),
          ),
          elseWidget: child,
        );
      },
      child: const CenteredCircularProgress(),
    );
  }
}
