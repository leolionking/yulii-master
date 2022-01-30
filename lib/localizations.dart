import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sheet_localization/flutter_sheet_localization.dart';

import 'localization_google_sheet_info.dart';

part 'localizations.g.dart';

Plural plural(int count) {
  if (count == 0) return Plural.zero;
  if (count == 1) return Plural.one;
  return Plural.multiple;
}

@SheetLocalization(
  LocalizationGoogleSheetInfo.docId,
  LocalizationGoogleSheetInfo.sheetId,
  LocalizationGoogleSheetInfo.version,
)
class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationDelegate();
  @override
  bool isSupported(Locale locale) =>
      AppLocalization.languages.containsKey(locale);

  @override
  Future<AppLocalization> load(Locale locale) =>
      SynchronousFuture<AppLocalization>(AppLocalization(locale));

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;
}
