import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/status.dart';
import 'package:yulli/models/task.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/if_else_widget.dart';

class MyTasksDialog extends StatefulWidget {
  final User user;
  final bool isAssigned;

  MyTasksDialog({
    Key key,
    @required this.user,
    @required this.isAssigned,
  })  : assert(isAssigned != null),
        assert(user != null),
        super(key: key);

  @override
  _MyTasksDialogState createState() => _MyTasksDialogState();
}

class _MyTasksDialogState extends State<MyTasksDialog> {
  TextEditingController _searchInputController;

  @override
  void initState() {
    super.initState();
    _searchInputController = TextEditingController()..addListener(() {});
  }

  @override
  void dispose() {
    _searchInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dbService = Provider.of<DbService>(context, listen: false);

    final defaultInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(
        color: Colors.transparent,
        width: .5,
        style: BorderStyle.none,
      ),
    );
    final localization = AppLocalization.of(context);
    return Dialog(
      backgroundColor: AppColors.primary,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: FractionallySizedBox(
        heightFactor: 2 / 5,
        child: FutureBuilder<List<Task>>(
          future: widget.isAssigned
              ? dbService.getAuthoredTasks(
                  assigneesIds: [widget.user.remoteId],
                  statuses: [Status.opened, Status.pending],
                )
              : dbService.getMyAssignedTasks(
                  statuses: [Status.opened, Status.pending],
                  authorId: widget.user.remoteId,
                ),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: const CircularProgressIndicator(),
              );
            }

            final tasks =
                snapshot.data.where((task) => !task.isLinkedToGoal).toList();

            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 38,
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: <Widget>[
                      SizedBox.expand(
                        child: Center(
                          child: Text(
                            // localization.labels.relatedDeals,
                            widget.isAssigned
                                ? localization.labels.tasksAssignedTo(
                                    username: widget.user.firstname)
                                : localization.labels.tasksSuggeredBy(
                                    username: widget.user.firstname),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: Container(
                          width: 38,
                          height: 38,
                          alignment: Alignment.center,
                          padding: EdgeInsets.zero,
                          child: Icon(
                            FeatherIcons.x,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.mdPadding,
                    vertical: AppDimens.padding,
                  ),
                  child: TextField(
                    controller: _searchInputController,
                    cursorColor: Colors.white,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: Colors.white,
                        ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: AppDimens.smPadding,
                        horizontal: AppDimens.padding,
                      ),
                      enabledBorder: defaultInputBorder,
                      focusedBorder: defaultInputBorder,
                      border: defaultInputBorder,
                      isDense: true,
                      filled: true,
                      fillColor: const Color(0xFF7DBDF1),
                      hintText: localization.labels.dealName,
                      hintStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: Colors.white.withOpacity(.7),
                            fontSize: 14,
                          ),
                    ),
                  ),
                ),
                Expanded(
                  child: IfElseWidget(
                    condition: tasks.isNotEmpty,
                    ifWidget: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];

                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppDimens.mdPadding,
                            vertical: AppDimens.smPadding,
                          ),
                          child: Ink(
                            child: InkWell(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Text(
                                    task.name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    task.points.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop(task);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    elseWidget: const Center(
                      child: Text("Aucune donnée"),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
