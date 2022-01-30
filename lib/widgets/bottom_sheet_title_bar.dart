import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/if_else_widget.dart';

class BottomSheetTitleBar extends StatefulWidget {
  final String title;
  final String subtitle;
  final VoidCallback onActionPressed;
  final VoidCallback onEditPressed;
  final VoidCallback onCancelPressed;
  final bool loading;
  final bool showEditButton;
  final bool showCancelButton;

  const BottomSheetTitleBar({
    Key key,
    @required this.title,
    @required this.onActionPressed,
    this.loading = false,
    this.showEditButton = false,
    this.onEditPressed,
    this.showCancelButton,
    this.onCancelPressed,
    this.subtitle,
  })  : assert(loading != null),
        assert(showEditButton != null),
        assert(showCancelButton != null),
        super(key: key);

  @override
  _BottomSheetTitleBarState createState() => _BottomSheetTitleBarState();
}

class _BottomSheetTitleBarState extends State<BottomSheetTitleBar>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    return Material(
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(
              left: AppDimens.mdPadding,
              right: AppDimens.padding,
              top: AppDimens.smPadding,
              bottom: AppDimens.smPadding,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      if (widget.subtitle != null) ...[
                        SizedBox(
                          height: AppDimens.xsPadding,
                        ),
                        Text(
                          widget.subtitle,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(
                  width: AppDimens.smPadding,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AnimatedSize(
                      duration: Duration(milliseconds: 300),
                      reverseDuration: Duration(milliseconds: 200),
                      curve: Curves.linearToEaseOut,
                      vsync: this,
                      child: IfElseWidget(
                        condition: widget.showEditButton,
                        ifWidget: IconButton(
                          icon: Icon(FeatherIcons.edit3),
                          onPressed: this.widget.onEditPressed,
                        ),
                        elseIfCondition: widget.showCancelButton,
                        elseIfWidget: FlatButton(
                          onPressed: this.widget.onCancelPressed,
                          child: Text(localization.labels.cancel),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(FeatherIcons.x),
                      onPressed: this.widget.onActionPressed,
                    ),
                  ],
                ),
              ],
            ),
          ),
          IfElseWidget(
            condition: widget.loading,
            ifWidget: LinearProgressIndicator(),
            elseWidget: Divider(
              height: 1,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
