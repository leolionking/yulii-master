import 'package:flutter/foundation.dart';
import 'package:yulli/abstracts/form_viewmodel.dart';
import 'package:yulli/localizations.dart';

enum FormMode {
  create,
  read,
  update,
}

extension FormModeExtension on FormMode {
  bool get isCreating => this == FormMode.create;
  bool get isReading => this == FormMode.read;
  bool get isUpdating => this == FormMode.update;
}

abstract class FormModeViewModel extends FormViewModel {
  final FormMode baseMode;
  final Map<String, dynamic> _cache = {};
  FormMode _currentMode;
  ValueNotifier<bool> _onRestoring = ValueNotifier(false);
  ValueNotifier<bool> get onRestore => _onRestoring;

  FormModeViewModel(
    AppLocalization_Labels localization,
    this.baseMode,
  )   : assert(baseMode != null),
        _currentMode = baseMode,
        super(localization);

  FormMode get mode => _currentMode;

  void setMode(FormMode mode) {
    // si on sort du mode d'édition
    if (_currentMode.isUpdating && !mode.isUpdating) {
      // restaurer le cache
      onCacheRestore();
      _onRestoring.value = true;
    }
    // si on entre dans le mode d'édition
    if (mode.isUpdating) {
      // initier le cache
      onCacheInit();
      _onRestoring.value = false;
    }
    _currentMode = mode;

    notifyListeners();
  }

  @protected
  void addToCache(String key, dynamic value) {
    _cache[key] = value;
  }

  @protected
  dynamic getFromCache(String key) {
    if (_cache.containsKey(key)) {
      return _cache[key];
    }
    return null;
  }

  @protected
  void onCacheInit();

  @protected
  void onCacheRestore();

  @override
  void dispose() {
    _onRestoring.dispose();
    super.dispose();
  }
}
