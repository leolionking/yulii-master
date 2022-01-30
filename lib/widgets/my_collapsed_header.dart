import 'package:flutter/material.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/filter_options.dart';
import 'package:yulli/widgets/searcg_input.dart';
import 'package:yulli/widgets/yulli_pills_tabbar.dart';

class MyCollapsedHeader extends StatelessWidget {
  final ValueChanged<int> onTap;
  final List<String> labels;
  final String searchHint;
  final int current;
  final Widget additionalWidget;
  final ValueChanged<String> onSearchValueChanged;

  const MyCollapsedHeader({
    Key key,
    @required this.searchHint,
    @required this.onTap,
    @required this.current,
    @required this.onSearchValueChanged,
    this.labels = const [],
    this.additionalWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 30, left: 30),
          child: SearchInputWidget(
            hintText: searchHint,
            onSearch: onSearchValueChanged,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 30),
        ),
        YulliPillsTabBar(
          labels: labels,
          onSelectedTabChanged: onTap,
          currentIndex: current,
          additionalWidget: additionalWidget,
        ),
        SizedBox(
          height: AppDimens.smPadding,
        ),
        // FilterOptions(
        //   labels,
        //   current: current,
        //   onTap: onTap,
        // ),
      ],
    );
  }
}
