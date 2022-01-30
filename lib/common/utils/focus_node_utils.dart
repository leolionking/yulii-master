import 'package:flutter/cupertino.dart';

class FocusNodeUtils {
  static void changeFocus(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    if (currentFocus != null && currentFocus.hasFocus) {
      currentFocus.unfocus();
    }
    if (nextFocus != null) {
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }

  static void unfocusAll() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }
}
