import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class OpacityButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final double opacity;
  final bool enabled;

  OpacityButton({
    Key key,
    @required this.child,
    @required this.onTap,
    this.opacity = .7,
    this.enabled = true,
  })  : assert(child != null),
        assert(onTap != null),
        assert(opacity != null),
        assert(opacity >= 0),
        assert(opacity <= 1),
        assert(enabled != null),
        super(key: key);

  @override
  _OpacityButtonState createState() => _OpacityButtonState();
}

class _OpacityButtonState extends State<OpacityButton> {
  bool _isTouching = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.enabled ? widget.onTap : () => null,
      onTapDown: (_) {
        setState(() {
          _isTouching = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isTouching = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isTouching = false;
        });
      },
      child: AnimatedOpacity(
        opacity: _isTouching ? widget.opacity : 1,
        duration: Duration(milliseconds: 100),
        child: widget.child,
      ),
    );
  }
}
