import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

extension DateTimeExtension on DateTime {
  String format(String format) {
    final formatter = DateFormat(format);

    return formatter.format(this);
  }

  bool get isNil => this == null;
  bool get isNotNil => !this.isNil;

  String timeOfDay(BuildContext context) =>
      TimeOfDay.fromDateTime(this).format(context);
}
