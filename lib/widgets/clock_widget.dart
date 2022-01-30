import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class ClockWidget extends StatelessWidget {
  const ClockWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF4B5161),
      ),
      child: Icon(
        FeatherIcons.clock,
        size: 13,
        color: Colors.white,
      ),
    );
  }
}
