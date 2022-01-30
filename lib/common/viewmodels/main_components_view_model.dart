import 'package:flutter/cupertino.dart';

class MainComponentViewModel extends ChangeNotifier {
  bool _fabDialVisible = true;

  bool get fabDialVisible => _fabDialVisible;

  void setDialVisible(bool visible) {
    _fabDialVisible = visible;
    notifyListeners();
  }
}
