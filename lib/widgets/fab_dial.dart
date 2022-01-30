import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/themes/app_colors.dart';

enum DialItem {
  friend,
  task,
  goal,
}

class FabDial extends StatelessWidget {
  final bool visible;
  final Function(DialItem dialItem) onItemTap;

  const FabDial({
    Key key,
    @required this.onItemTap,
    @required this.visible,
  })  : assert(visible != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      visible: visible,
      children: [
        SpeedDialChild(
          label: localization.actions.addDeal,
          child: Icon(FeatherIcons.checkSquare),
          onTap: () => this.onItemTap(DialItem.task),
        ),
        SpeedDialChild(
          label: localization.actions.addGoal,
          child: Icon(FeatherIcons.gift),
          onTap: () => this.onItemTap(DialItem.goal),
        ),
        SpeedDialChild(
          label: localization.actions.addFriend,
          child: Icon(FeatherIcons.userPlus),
          onTap: () => this.onItemTap(DialItem.friend),
        ),
      ],
    );
  }
}
