import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'string_extensions.dart';

extension LocaleExtension on Locale {
  String get formatedCode {
    final buffer = StringBuffer(this.languageCode);

    if (this.countryCode.isNotNil) {
      buffer.write("_${this.countryCode}");
    }

    return buffer.toString();
  }

  LocaleType get localeType {
    switch (this.languageCode) {
      case "fr":
        return LocaleType.fr;
      default:
        return LocaleType.en;
    }
  }
}
