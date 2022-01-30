import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/models/status.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/if_else_widget.dart';
import 'package:yulli/widgets/status_indicator.dart';
import 'package:yulli/widgets/status_view.dart';

class StatusSelector extends StatelessWidget {
  final Status initialStatus;
  final Function(Status) onStatusSelected;
  final bool canSelectStatus;
  final List<Status> selectableStatuses;

  List<Status> get statusOnCreation => const [
        Status.done,
        Status.declined,
        Status.pending,
        Status.opened,
      ];

  List<Status> get selectables {
    if (selectableStatuses?.isEmpty ?? true) {
      return statusOnCreation;
    }
    return statusOnCreation
        .where((element) => selectableStatuses.contains(element))
        .toList();
  }

  const StatusSelector({
    Key key,
    @required this.onStatusSelected,
    this.initialStatus = Status.opened,
    this.canSelectStatus = true,
    this.selectableStatuses = const [],
  })  : assert(initialStatus != null),
        super(key: key);

  void _onTap(BuildContext context) {
    if (!(canSelectStatus ?? false)) {
      return;
    }
    final localization = AppLocalization.of(context);
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: FractionallySizedBox(
          heightFactor: 2 / 6,
          widthFactor: .6,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primary,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 38,
                  width: double.maxFinite,
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: <Widget>[
                      SizedBox.expand(
                        child: Center(
                          child: Text(
                            localization.labels.status,
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
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
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      vertical: AppDimens.smPadding,
                      horizontal: AppDimens.padding,
                    ),
                    itemCount: selectables.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppDimens.xsPadding,
                        ),
                        child: StatusView(
                          status: selectables[index],
                          onTap: (status) {
                            onStatusSelected?.call(status);
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StatusView(
      status: initialStatus,
      onTap: (_) => _onTap(context),
    );
  }
}
