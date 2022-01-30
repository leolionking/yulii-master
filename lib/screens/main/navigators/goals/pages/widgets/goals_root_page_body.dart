import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/common/enums/filters.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/common/viewmodels/main_components_view_model.dart';
import 'package:yulli/constants/asset_images.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/goal.dart';
import 'package:yulli/screens/main/navigators/goals/pages/viewmodels/goals_root_page_viewmodel.dart';
import 'package:yulli/screens/main/navigators/goals/pages/widgets/goals_list_filter_bottom_sheet.dart';
import 'package:yulli/services/app_data.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/centered_circular_progress.dart';
import 'package:yulli/widgets/goal_widget.dart';
import 'package:yulli/widgets/if_else_widget.dart';
import 'package:yulli/widgets/my_collapsed_header.dart';
import 'package:yulli/widgets/my_fixed_header.dart';
import 'package:yulli/widgets/my_sliver_list_builder.dart';
import 'package:yulli/widgets/no_data.dart';
import 'package:yulli/widgets/yulii_sliver_body.dart';
import 'package:yulli/extensions/index.dart';
import 'package:yulli/widgets/yulli_add_goal_bottom_sheet.dart';

class GoalsRootPageBody extends StatefulWidget {
  GoalsRootPageBody({Key key}) : super(key: key);

  @override
  _GoalsRootPageBodyState createState() => _GoalsRootPageBodyState();
}

class _GoalsRootPageBodyState extends State<GoalsRootPageBody> {
  final MyLogger _logger = MyLogger("GoalsRootPageBody");
  final List<String> baseLabels = [];
  final ScrollController _controller = ScrollController();
  int _currentFilterIndex = 0;

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

  void _onGoalItemTap(BuildContext context, Goal goal, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
      ),
      builder: (_) => YuliiAddGoalBottomSheet(
        goal: goal,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(this._onScrollControllerListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GoalsRootPageViewModel>(context, listen: false).init();
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

    return Consumer<GoalsRootPageViewModel>(
      builder: (context, _viewModel, child) {
        final friends = _viewModel.friends;

        if (baseLabels.isEmpty) {
          baseLabels.addAll(Filter.values
              .map((e) => FilterHelper.name(
                    e,
                    isTask: false,
                    context: context,
                  ))
              .toList());
        }

        final labels = [...baseLabels];
        friends.forEach((user) {
          labels.add(user.firstname);
        });

        final currentUser = appData.currentUser;

        final filteredGoals = _viewModel.allGoals.where((goal) {
          if (_currentFilterIndex == 0) return true;
          if (_currentFilterIndex == 1) {
            return goal.assignees.contains(currentUser.remoteId);
          }
          final friend = friends[_currentFilterIndex - 2];
          return goal.assignees.contains(friend.remoteId);
        }).toList();

        return IfElseWidget(
          condition: !_viewModel.loading,
          ifWidget: YuliiSliverBody(
            controller: _controller,
            minHeaderHeight: 64,
            maxHeaderHeight: 276,
            bodyBadgeCount: filteredGoals.length,
            headerBackgroundImage: AssetImage(AssetImages.mozaic),
            headerFixedArea: MyFixedHeader(
              title: localization.screens.goals,
            ),
            headerBackground: MyCollapsedHeader(
              current: _currentFilterIndex,
              onTap: (index) {
                setState(() {
                  _currentFilterIndex = index;
                });
              },
              labels: labels,
              searchHint: localization.actions.searchGoal,
              additionalWidget: GestureDetector(
                // behavior: HitTestBehavior.opaque,
                onTap: () async {
                  final result = await showModalBottomSheet<GoalsListFilter>(
                    context: context,
                    isScrollControlled: true,
                    useRootNavigator: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36),
                      ),
                    ),
                    builder: (_) => GoalsListFilterBottomSheet(
                      currentFilter: _viewModel.currentFilter,
                    ),
                  );

                  switch (result) {
                    case GoalsListFilter.claimed:
                      _viewModel.sortClaimedFirst();
                      break;
                    case GoalsListFilter.notClaimed:
                      _viewModel.sortMostRecentFirst();
                      break;
                    case GoalsListFilter.idle:
                      break;
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimens.padding,
                  ),
                  constraints: BoxConstraints(
                    minWidth: 100,
                  ),
                  margin: EdgeInsets.only(
                    left: AppDimens.lgPadding,
                    right: AppDimens.smPadding,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FeatherIcons.sliders,
                        color: AppColors.secondary,
                        size: 18,
                      ),
                      SizedBox(
                        width: AppDimens.nxsPadding,
                      ),
                      Text(
                        localization.labels.filter,
                        style: Theme.of(context).textTheme.button.copyWith(
                              color: AppColors.secondary,
                            ),
                      )
                    ],
                  ),
                ),
              ),
              onSearchValueChanged: _viewModel.search,
            ),
            bodyTitle: labels[_currentFilterIndex],
            body: filteredGoals.isNotEmpty
                ? MySliverListBuilder<Goal>(
                    items: filteredGoals,
                    onItemBuilder: (_, currentGoal, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimens.padding,
                        ),
                        child: GoalWidget(
                          key: ValueKey(currentGoal.remoteId +
                              currentGoal.updatedAt.toString()),
                          goal: currentGoal,
                          onItemTap: (goal) =>
                              this._onGoalItemTap(context, goal, index),
                          width: MediaQuery.of(context).size.width -
                              AppDimens.xxlPadding,
                        ),
                      );
                    },
                  )
                : SliverFillRemaining(
                    hasScrollBody: false,
                    child: NoData(
                      text: localization.labels.noReward,
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
