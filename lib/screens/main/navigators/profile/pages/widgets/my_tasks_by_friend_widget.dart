import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:yulli/constants/asset_images.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/my_tasks_by_friend.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/my_avatar.dart';

class MyTasksByFriendWidget extends StatelessWidget {
  final MyTasksByFriend tasksByFriend;

  const MyTasksByFriendWidget({
    Key key,
    @required this.tasksByFriend,
  })  : assert(tasksByFriend != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultTextTheme = Theme.of(context).textTheme.bodyText2.copyWith(
          color: const Color(0xFF4A5061),
          fontWeight: FontWeight.bold,
          fontSize: 15,
        );
    final pointTextStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          color: AppColors.secondary,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        );
    final localization = AppLocalization.of(context);

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        MyAvatar(
          user: tasksByFriend.friend,
          size: 64,
          borderWidth: .5,
        ),
        SizedBox(
          width: AppDimens.nsmPadding,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                tasksByFriend.friend.displayName,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(height: AppDimens.xsPadding),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.sort,
                    size: 16,
                    color: AppColors.myFriendWidgetIconColor,
                  ),
                  SizedBox(
                    width: AppDimens.nsmPadding,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: AppColors.dividerColorOpaque,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: LinearPercentIndicator(
                        lineHeight: 10,
                        percent: tasksByFriend.totalTasks != 0
                            ? tasksByFriend.finishedTasksCount /
                                tasksByFriend.totalTasks
                            : 0,
                        animation: true,
                        animationDuration: 400,
                        curve: Curves.linear,
                        animateFromLastPercent: true,
                        progressColor: AppColors.primary,
                        fillColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AppDimens.smPadding,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    AssetImages.trophy,
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(
                    width: AppDimens.smPadding,
                  ),
                  Text.rich(
                    TextSpan(
                      text: tasksByFriend.finishedTasksPoints.toString(),
                      style: pointTextStyle,
                      children: [
                        TextSpan(text: " "),
                        TextSpan(
                          text: localization.labels.points.toLowerCase(),
                          style: pointTextStyle.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          width: AppDimens.nsmPadding,
        ),
        Transform.translate(
          offset: Offset(0, -10),
          child: Text.rich(
            TextSpan(
              text: tasksByFriend.finishedTasksCount.toString() ?? "0",
              style: defaultTextTheme.copyWith(
                fontSize: 20,
              ),
              children: [
                TextSpan(
                  text: "/",
                  style: defaultTextTheme.copyWith(
                    fontSize: 14,
                  ),
                ),
                TextSpan(
                  text: tasksByFriend.totalTasks?.toString() ?? "0",
                  style: defaultTextTheme,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
