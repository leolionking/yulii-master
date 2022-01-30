import 'package:flutter/material.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/goal.dart';
import 'package:yulli/models/goal_obj.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/themes/yulli_themes.dart';
import 'package:yulli/widgets/goal_widget.dart';
import 'package:yulli/widgets/my_title.dart';
import 'package:yulli/widgets/no_data.dart';
import 'package:yulli/widgets/yulli_add_goal_bottom_sheet.dart';

import 'opacity_button.dart';

class CollapsedHeader extends StatelessWidget {
  final List<Goal> goals;

  const CollapsedHeader({
    Key key,
    this.goals = const [],
  }) : super(key: key);

  void _onGoalItemTap(BuildContext context, Goal goal) {
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
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            bottom: AppDimens.padding,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: AppDimens.lgPadding,
            ),
            child: MyTitle(
              localization.labels.myGoals,
              YulliColors.yellow[500],
              Colors.white,
              isBold: false,
            ),
          ),
        ),
        ConstrainedBox(
          child: goals.isNotEmpty
              ? LayoutBuilder(
                  builder: (context, constraints) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: goals.length,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimens.lgPadding,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            right: AppDimens.padding,
                          ),
                          child: SizedBox(
                            width: constraints.maxWidth -
                                AppDimens.xlPaddingDouble,
                            child: GoalWidget(
                              goal: goals[index],
                              hideUserName: true,
                              onItemTap: (goal) {
                                _onGoalItemTap(context, goal);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
              : NoData(
                  size: 72,
                  iconSize: 36,
                  separationHeight: AppDimens.smPadding,
                  text: localization.labels.noReward,
                  textStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Colors.white,
                      ),
                ),
          constraints: BoxConstraints.loose(
            new Size(
              MediaQuery.of(context).size.width,
              124,
            ),
          ),
        ),
        SizedBox(
          height: AppDimens.smPadding,
        ),
      ],
    );
  }
}
