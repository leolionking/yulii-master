import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/constants/asset_images.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/goal.dart';
import 'package:yulli/models/goal_obj.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/services/app_data.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/if_else_widget.dart';
import 'package:yulli/widgets/label.dart';
import 'package:yulli/widgets/my_avatar.dart';
import 'package:yulli/widgets/rectangle.dart';
import 'package:yulli/widgets/tag_bubble.dart';
import 'package:yulli/widgets/text_in_grey.dart';

class GoalWidget extends StatelessWidget {
  final Goal goal;
  final bool hideUserName;
  final double width;
  final Image icon;
  final Function(Goal) onItemTap;

  GoalWidget({
    Key key,
    @required this.goal,
    this.width,
    this.icon,
    this.hideUserName = false,
    this.onItemTap,
  })  : assert(goal != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final appData = Provider.of<AppDataService>(context, listen: false);

    return Rectangle(
      onTap: () => onItemTap?.call(goal),
      color: Colors.white,
      background:
          goal.isMystery ? const AssetImage(AssetImages.question) : null,
      child: Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16,
                          left: 8,
                        ),
                        child: MyAvatar(
                          user: goal.assigneesUsers.first,
                          borderWidth: 1,
                          borderColor: AppColors.avatarDefaultBorderColor
                              .withOpacity(.2),
                          isSquared: true,
                        ),
                      ),
                      if (goal.isNew && !goal.hasBeenClaimAtLeastOnce)
                        TagBubble(
                          tagType: TagType.newElement,
                        ),
                      if (goal.hasBeenClaimAtLeastOnce)
                        TagBubble(
                          tagType: TagType.claimed,
                        ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 6,
                    ),
                  ),
                  if (!hideUserName)
                    Text(
                      goal.assigneesUsers.first.firstname,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.unselectedTab,
                            fontSize: 12,
                          ),
                    ),
                ],
              ),
              SizedBox(
                width: AppDimens.padding,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Label(
                      label: goal.isMystery &&
                              !goal.isAuthor(appData.currentUser.remoteId)
                          ? localization.labels.mysteryGift
                          : goal.name,
                    ),
                    SizedBox(
                      height: AppDimens.xsPadding,
                    ),
                    if (!(goal.isMystery &&
                        !goal.isAuthor(appData.currentUser.remoteId)))
                      TextInGrey(
                        label: goal.description ?? "",
                        maxLines: 2,
                        minLines: 2,
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            top: AppDimens.smPadding,
                          ),
                          child: IfElseWidget(
                            condition: goal.goalType.isPro,
                            ifWidget: Text(
                              localization.labels.dealCountPlaceholder(
                                plural(goal.tasksIds?.length ?? 0),
                                count: (goal.tasksIds?.length ?? 0).toString(),
                              ),
                              style: TextStyle(
                                color: goal.isMystery
                                    ? AppColors.primary
                                    : AppColors.secondary,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            elseWidget: Text(
                              localization.labels.pointsPlaceholder(
                                points: goal.points.toString(),
                              ),
                              style: TextStyle(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 32,
              child: Image.asset(
                AssetImages.goalHand,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
