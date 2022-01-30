import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:yulli/constants/asset_images.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/deal_obj.dart';
import 'package:yulli/models/status.dart';
import 'package:yulli/models/task.dart';
import 'package:yulli/services/app_data.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/themes/yulli_themes.dart';
import 'package:yulli/widgets/avatar.dart';
import 'package:yulli/widgets/if_else_widget.dart';
import 'package:yulli/widgets/inked_button.dart';
import 'package:yulli/widgets/label.dart';
import 'package:yulli/widgets/status_indicator.dart';
import 'package:yulli/widgets/tag_bubble.dart';
import 'package:yulli/widgets/text_in_grey.dart';
import 'package:yulli/extensions/index.dart';

import 'my_avatar.dart';

class DealWidget extends StatefulWidget {
  final Task task;
  final Function(Task) onItemTap;
  final Function(Task) onStatusIconTap;
  final bool Function(Status, Task task) onCanChangeStatus;
  final Color avatarBorderColor;
  final double avatarBorderWidth;

  const DealWidget({
    Key key,
    @required this.task,
    @required this.onItemTap,
    @required this.onStatusIconTap,
    @required this.onCanChangeStatus,
    this.avatarBorderColor,
    this.avatarBorderWidth = 1,
  })  : assert(task != null),
        super(key: key);

  @override
  _DealWidgetState createState() => _DealWidgetState();
}

class _DealWidgetState extends State<DealWidget> {
  Status _nextStatus;
  Status _currentStatus;

  Task get task => widget.task;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.task.status;
  }

  void _onStatusIconTap(BuildContext context) {
    if (widget.onCanChangeStatus != null &&
        !widget.onCanChangeStatus(_currentStatus, widget.task)) return;
    if (_currentStatus.hasNext) {
      setState(() {
        _nextStatus = _currentStatus.next;
      });
    }
    widget.onStatusIconTap?.call(widget.task);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final appData = Provider.of<AppDataService>(context, listen: false);

    return InkedButton(
      shapeBorder: RoundedRectangleBorder(),
      onTap: () => widget.onItemTap(widget.task),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.lgPadding,
          vertical: AppDimens.smPadding,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
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
                    user: task.assigneesUsers?.first,
                    borderWidth: widget.avatarBorderWidth,
                    borderColor:
                        AppColors.avatarDefaultBorderColor.withOpacity(.2),
                    isSquared: true,
                  ),
                ),
                if (task.isNew) TagBubble(tagType: TagType.newElement),
              ],
            ),
            // Avatar(
            //   null,
            //   imageProvider: AssetImage(AssetImages.avatarPlaceholder),
            //   borderColor: widget.avatarBorderColor,
            //   borderWidth: widget.avatarBorderWidth,
            // ),
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
                    label: widget.task.name,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextInGrey(
                        label: localization.labels.pointsPlaceholder(
                          points: widget.task.points.toString(),
                        ),
                      ),
                      if (widget.task.dueDate != null)
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: SizedBox(
                            height: 18,
                            width: 18,
                            child: SvgPicture.asset(
                              AssetImages.clock,
                            ),
                          ),
                        ),
                      SizedBox(
                        width: AppDimens.smPadding,
                      ),
                      if (widget.task.goalId != null)
                        SizedBox(
                          height: 18,
                          width: 18,
                          child: SvgPicture.asset(
                            AssetImages.questionmarkSVG,
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              width: AppDimens.xsPadding,
            ),
            InkedButton(
              onTap: () => this._onStatusIconTap(context),
              child: StatusIndicator(
                status: _currentStatus,
                animateTo: widget.onCanChangeStatus != null &&
                        widget.onCanChangeStatus(_currentStatus, widget.task)
                    ? _nextStatus
                    : null,
                onAnimationComplete: (prev, next) {
                  setState(() {
                    _nextStatus = null;

                    if (next != null) _currentStatus = next;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
