import 'package:flutter/material.dart';
import 'package:yulli/models/status.dart';
import 'package:yulli/widgets/status_indicator.dart';

class StatusView extends StatelessWidget {
  final Status status;
  final double heigth;
  final Function(Status) onTap;

  const StatusView({
    Key key,
    @required this.status,
    this.heigth = 40,
    this.onTap,
  })  : assert(status != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call(status);
      },
      child: SizedBox(
        height: heigth,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                vertical: 4,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: status.color,
              ),
              child: Text(
                status.textValue(context),
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
              ),
            ),
            StatusIndicator(
              status: status,
              animated: false,
            ),
          ],
        ),
      ),
    );
  }
}
