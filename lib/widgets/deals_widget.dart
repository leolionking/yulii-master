import 'package:flutter/material.dart';
import 'package:yulli/models/deal_obj.dart';
import 'package:yulli/models/task.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/themes/yulli_themes.dart';
import 'package:yulli/widgets/deal_widget.dart';

class DealsWidget extends StatelessWidget {
  final List<Task> deals;
  final bool hasTranslation;
  final Function(Task) onTaskItemTap;
  final Function(Task) onTaskItemStatusIconTap;

  const DealsWidget(
    this.deals, {
    @required this.onTaskItemTap,
    @required this.onTaskItemStatusIconTap,
    this.hasTranslation = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(
        0,
        hasTranslation ? -AppDimens.padding : 0,
        0,
      ),
      child: ListView.separated(
        separatorBuilder: (_, index) => Divider(
          color: YulliColors.grey,
          thickness: 0,
          indent: AppDimens.lgPadding,
          endIndent: AppDimens.lgPadding,
        ),
        itemCount: deals.length,
        itemBuilder: (BuildContext context, index) {
          return DealWidget(
            task: deals[index],
            onItemTap: onTaskItemTap,
            onStatusIconTap: onTaskItemStatusIconTap,
          );
        },
      ),
    );
  }
}
