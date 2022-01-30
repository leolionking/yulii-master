import 'package:flutter/material.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';

class YulliPillsTabBar extends StatefulWidget {
  final List<String> labels;
  final ValueChanged<int> onSelectedTabChanged;
  final int currentIndex;
  final Widget additionalWidget;

  const YulliPillsTabBar({
    Key key,
    @required this.labels,
    @required this.onSelectedTabChanged,
    this.currentIndex = 0,
    this.additionalWidget,
  })  : assert(labels != null),
        assert(currentIndex != null),
        super(key: key);

  @override
  _YulliPillsTabBarState createState() => _YulliPillsTabBarState();
}

class _YulliPillsTabBarState extends State<YulliPillsTabBar>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  // int _selectedTabIndex = 0;

  @override
  void initState() {
    _controller = TabController(
      length: widget.additionalWidget != null
          ? widget.labels.length + 1
          : widget.labels.length,
      vsync: this,
    )..addListener(() {
        // setState(() {
        //   _selectedTabIndex = _controller.index;
        // });
        widget.onSelectedTabChanged?.call(
            widget.additionalWidget != null && _controller.index != 0
                ? _controller.index - 1
                : _controller.index);
      });
    // _selectedTabIndex = _controller.index;
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: SizedBox(
        height: 40,
        child: TabBar(
          controller: _controller,
          labelPadding: EdgeInsets.zero,
          isScrollable: true,
          unselectedLabelColor: Colors.white,
          labelColor: Colors.white,
          indicator: BoxDecoration(
            color: Colors.transparent,
          ),
          indicatorPadding: EdgeInsets.zero,
          tabs: List.generate(
              widget.labels.length + (widget.additionalWidget != null ? 1 : 0),
              (index) {
            if (widget.additionalWidget != null && index == 0) {
              return Tab(
                child: widget.additionalWidget,
              );
            }
            var i = widget.additionalWidget != null ? index - 1 : index;
            return Tab(
              child: Container(
                alignment: Alignment.center,
                height: 40,
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimens.padding,
                ),
                constraints: BoxConstraints(
                  minWidth: 100,
                ),
                margin: EdgeInsets.only(
                  left: i == 0 && widget.additionalWidget == null
                      ? AppDimens.lgPadding
                      : 0,
                  right: AppDimens.smPadding,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: widget.currentIndex == i
                        ? AppColors.secondary
                        : Colors.white,
                    width: 1,
                  ),
                  color: widget.currentIndex == i
                      ? AppColors.secondary
                      : Colors.transparent,
                ),
                child: Text(
                  widget.labels[i],
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
