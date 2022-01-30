import 'package:flutter/material.dart';

class IfElseWidget extends StatelessWidget {
  final bool condition;
  final bool elseIfCondition;
  final Widget ifWidget;
  final Widget elseIfWidget;
  final Widget elseWidget;

  const IfElseWidget({
    Key key,
    @required this.condition,
    @required this.ifWidget,
    this.elseIfWidget = const SizedBox(),
    this.elseWidget = const SizedBox(),
    this.elseIfCondition = false,
  })  : assert(condition != null),
        assert(ifWidget != null),
        assert(elseWidget != null),
        assert(elseIfCondition != null),
        assert(elseIfWidget != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: condition ? ifWidget : elseIfCondition ? elseIfWidget : elseWidget,
    );
  }
}
