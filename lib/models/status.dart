import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/themes/app_colors.dart';

class StatusValue {
  static const pending = "Pending";
  static const opened = "Opened";
  static const closed = "Closed";
  static const done = "Done";
  static const declined = "Declined";

  static const List<String> values = [
    StatusValue.pending,
    StatusValue.opened,
    StatusValue.closed,
    StatusValue.done,
    StatusValue.declined,
  ];
}

enum Status {
  pending,
  opened,
  closed,
  done,
  declined,
}

extension StatusExtension on Status {
  bool get hasNext => this.next != null;

  Status get next {
    switch (this) {
      case Status.pending:
        return Status.done;
      case Status.opened:
        return Status.pending;
      case Status.done:
        return Status.closed;
      default:
        return null;
    }
  }

  Color get color {
    switch (this) {
      case Status.opened:
        return AppColors.darkGrey;
      case Status.pending:
        return AppColors.secondary;
      case Status.done:
        return AppColors.success;
      case Status.declined:
        return AppColors.errorColor;
      default:
        return Colors.transparent;
    }
  }

  Widget get widget {
    switch (this) {
      case Status.opened:
        return Icon(
          Icons.play_arrow,
          color: this.color,
          size: 22,
        );
      case Status.pending:
        return SizedBox(
          height: 16,
          width: 16,
          child: Image.asset("assets/images/shape.png"),
        );
      case Status.done:
        return Icon(
          Icons.check,
          color: this.color,
          size: 22,
        );
      case Status.declined:
        return Icon(
          Icons.close,
          color: this.color,
          size: 22,
        );
      default:
        return const SizedBox();
    }
  }

  String textValue(BuildContext context) {
    final localization = AppLocalization.of(context);
    switch (this) {
      case Status.opened:
        return localization.labels.opened;
      case Status.pending:
        return localization.labels.pending;
      case Status.done:
        return localization.labels.done;
      case Status.declined:
        return localization.labels.declined;
      default:
        return null;
    }
  }

  bool isUpgrade(Status upgrade) {
    switch (upgrade) {
      case Status.closed:
        return !this.isClosed;
      case Status.declined:
        return !this.isDeclined;
      case Status.done:
        return this.isPending;
      case Status.pending:
        return this.isOpened;
      default:
        return false;
    }
  }

  bool get isDone => this == Status.done;
  bool get isOpened => this == Status.opened;
  bool get isClosed => this == Status.closed;
  bool get isPending => this == Status.pending;
  bool get isDeclined => this == Status.declined;
}
