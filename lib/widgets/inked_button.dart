import 'package:flutter/material.dart';

class InkedButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final ShapeBorder shapeBorder;

  const InkedButton({
    Key key,
    @required this.child,
    @required this.onTap,
    this.shapeBorder = const CircleBorder(),
  })  : assert(child != null),
        assert(onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        enableFeedback: true,
        customBorder: shapeBorder,
        onTap: onTap,
        child: child,
      ),
    );
  }
}
