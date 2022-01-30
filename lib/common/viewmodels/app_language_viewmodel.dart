import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/extensions/index.dart';

class AppLanguageViewModel extends ChangeNotifier {
  static const TAG = "AppLanguageViewModel";

  static final _logger = MyLogger(TAG);

  Locale _locale = AppLocalization.languages.keys.first;

  Locale get locale => _locale;

  Future<void> init() async {
    String localeCode = await Devicelocale.currentLocale;
    Locale newLocale = Locale(localeCode.substring(0, 2));
    _logger.d("current locale : $locale");
    _logger.d("next locale : $newLocale");
    if (newLocale != this.locale) {
      changeLocale(newLocale, setIntl: false);
    }
    _setIntlDefaultLocale(newLocale);
  }

  void changeLocale(Locale locale, {bool setIntl = true}) async {
    _logger.d("Changing locale: ${locale.languageCode}");
    _locale = locale;

    if (setIntl) {
      _setIntlDefaultLocale(locale);
    }
    notifyListeners();
  }

  void _setIntlDefaultLocale(Locale locale) {
    Intl.defaultLocale = locale.formatedCode;
  }

  @override
  String toString() => """
    locale: $locale,
  """;
}
