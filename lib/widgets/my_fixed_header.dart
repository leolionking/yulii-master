import 'package:flutter/material.dart';
import 'package:yulli/widgets/notification_badge.dart';

class MyFixedHeader extends StatelessWidget {
  final String title;

  const MyFixedHeader({
    Key key,
    @required this.title,
  })  : assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        NotificationBadge(),
      ],
    );
  }
}
