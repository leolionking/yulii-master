import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/yulii_page_bottom_sheet.dart';
import 'package:yulli/extensions/index.dart';

enum GoalsListFilter {
  claimed,
  notClaimed,
  idle,
}

class GoalsListFilterBottomSheet extends StatelessWidget {
  const GoalsListFilterBottomSheet({
    Key key,
    @required this.currentFilter,
  })  : assert(currentFilter != null),
        super(key: key);

  final GoalsListFilter currentFilter;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return YulliPageBottomSheet(
      title: localization.labels.filter,
      onClose: () => context.pop(),
      hideBottomPadding: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.padding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: currentFilter == GoalsListFilter.notClaimed
                  ? AppColors.secondary.withOpacity(.5)
                  : Colors.transparent,
              child: ListTile(
                leading: Icon(
                  FeatherIcons.arrowRight,
                  size: 20,
                ),
                title: Align(
                  alignment: Alignment(-1.4, 0),
                  child: Text(localization.labels.ongoingRewards),
                ),
                onTap: () {
                  context.pop(GoalsListFilter.notClaimed);
                },
                // contentPadding: EdgeInsets.zero,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.padding,
              ),
              child: Divider(
                height: 1,
              ),
            ),
            Container(
              color: currentFilter == GoalsListFilter.claimed
                  ? AppColors.secondary.withOpacity(.5)
                  : Colors.transparent,
              child: ListTile(
                leading: Icon(
                  FeatherIcons.arrowRight,
                  size: 20,
                ),
                title: Align(
                  alignment: Alignment(-1.4, 0),
                  child: Text(localization.labels.claimedRewards),
                ),
                onTap: () {
                  context.pop(GoalsListFilter.claimed);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
