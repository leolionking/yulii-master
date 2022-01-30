import 'package:flutter/cupertino.dart';

import '../../localizations.dart';

enum Filter {
  all,
  mine,
}

class FilterHelper {
  static String name(Filter filter,
      {bool isTask = true, BuildContext context}) {
    final localization = AppLocalization.of(context);

    switch (filter) {
      case Filter.all:
        return localization.labels.all;
      case Filter.mine:
        return isTask
            ? localization.labels.myDeals
            : localization.labels.myGoals;
    }
    return null;
  }
}
