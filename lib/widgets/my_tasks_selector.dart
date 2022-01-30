import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:yulli/common/utils/focus_node_utils.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/task.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/my_dotted_button.dart';
import 'package:yulli/widgets/my_tasks_dialog.dart';
import 'package:yulli/widgets/my_text_widget.dart';
import 'package:yulli/widgets/small_text.dart';
import 'package:yulli/widgets/status_indicator.dart';
import 'package:yulli/extensions/index.dart';

class MyTasksSelector extends StatelessWidget {
  final String title;
  final List<Task> tasks;
  final Function(Task) onSelected;
  final Function(Task, int) onDeleted;
  final bool Function() canOpenSelector;
  final User user;
  final bool isAssigned;
  final bool disabled;

  const MyTasksSelector({
    Key key,
    @required this.onSelected,
    @required this.title,
    this.tasks = const [],
    this.onDeleted,
    this.canOpenSelector,
    this.user,
    this.isAssigned = false,
    this.disabled = false,
  })  : assert(tasks != null),
        assert(title != null),
        assert(disabled != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.lgPadding,
          ),
          child: SmallText(title),
        ),
        SizedBox(
          height: AppDimens.nsmPadding,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.lgPadding,
          ),
          child: !disabled
              ? MyDottedButton(
                  onTap: () async {
                    FocusNodeUtils.unfocusAll();

                    if (canOpenSelector != null && !canOpenSelector()) return;

                    final selectedTask = await showDialog<Task>(
                      context: context,
                      barrierDismissible: true,
                      builder: (_) => MyTasksDialog(
                        user: user,
                        isAssigned: isAssigned,
                      ),
                    );

                    if (selectedTask != null) {
                      onSelected?.call(selectedTask);
                    }
                  },
                )
              : SizedBox(),
        ),
        SizedBox(
          height: AppDimens.nsmPadding,
        ),
        SizedBox(
          width: double.maxFinite,
          height: 76,
          child: ListView.builder(
            itemCount: tasks.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
              horizontal: AppDimens.mdPadding,
              vertical: AppDimens.xsPadding,
            ),
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Card(
                margin: EdgeInsets.symmetric(
                  horizontal: AppDimens.smPadding,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: AppColors.primary,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: context.screenWidth * .5,
                  ),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            FeatherIcons.x,
                            size: 20,
                            color: Colors.white,
                          ),
                          onPressed: () => onDeleted?.call(task, index),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              MyText(
                                task.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                maxLines: 2,
                                minLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                localization.labels.pointsPlaceholder(
                                    points: task.points.toString()),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                      fontSize: 13,
                                      color: Colors.white70,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StatusIndicator(
                            status: task.status,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
