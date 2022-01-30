import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/bottom_sheet_title_bar.dart';
import 'package:yulli/extensions/index.dart';

class YulliPageBottomSheet extends StatefulWidget {
  final Widget child;
  final Color backgroundColor;
  final double topBorderRadius;
  final String title;
  final String subtitle;
  final VoidCallback onClose;
  final VoidCallback onEdit;
  final VoidCallback onCancel;
  final bool loading;
  final bool hideBottomPadding;
  final bool showEditButton;
  final bool showCancel;

  const YulliPageBottomSheet({
    Key key,
    @required this.child,
    this.backgroundColor,
    this.topBorderRadius = 36,
    this.title,
    this.subtitle,
    this.onClose,
    this.loading = false,
    this.hideBottomPadding = false,
    this.showEditButton = false,
    this.onEdit,
    this.showCancel = false,
    this.onCancel,
  })  : assert(child != null),
        assert(loading != null),
        assert(showEditButton != null),
        assert(showCancel != null),
        super(key: key);

  @override
  _YulliPageBottomSheetState createState() => _YulliPageBottomSheetState();
}

class _YulliPageBottomSheetState extends State<YulliPageBottomSheet>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: context.screenHeight -
            context.statusBarHeight -
            AppDimens.smPadding,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(widget.topBorderRadius),
          topRight: Radius.circular(widget.topBorderRadius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          BottomSheetTitleBar(
            title: widget.title,
            subtitle: widget.subtitle,
            onActionPressed: widget.onClose,
            onEditPressed: widget.onEdit,
            loading: widget.loading,
            showEditButton: widget.showEditButton,
            showCancelButton: widget.showCancel,
            onCancelPressed: widget.onCancel,
          ),
          Flexible(
            fit: FlexFit.loose,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: AppDimens.smPadding,
                  ),
                  if (widget.child != null) widget.child,
                  SizedBox(
                    height: AppDimens.padding,
                  ),
                  SizedBox(
                    height: Math.max(
                      MediaQuery.of(context).viewInsets.bottom,
                      widget.hideBottomPadding
                          ? AppDimens.padding
                          : AppDimens.xlPadding,
                    ),
                  )
                ],
              ),
            ),
          ),
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   child: BottomSheetTitleBar(
          //     title: widget.title,
          //     subtitle: widget.subtitle,
          //     onActionPressed: widget.onClose,
          //     onEditPressed: widget.onEdit,
          //     loading: widget.loading,
          //     showEditButton: widget.showEditButton,
          //     showCancelButton: widget.showCancel,
          //     onCancelPressed: widget.onCancel,
          //   ),
          // )
        ],
      ),
    );
  }
}
