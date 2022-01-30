import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:yulli/localizations.dart';

part 'faq.freezed.dart';
part 'faq.g.dart';

@freezed
abstract class Qa implements _$Qa {
  const Qa._();
  const factory Qa({
    @required Map<String, String> question,
    @required Map<String, String> answer,
  }) = _Qa;

  factory Qa.fromJson(Map<String, dynamic> json) => _$QaFromJson(json);

  @late
  String getQuestionByLanguageCode(String languageCode) {
    if (question.containsKey(languageCode)) {
      return question[languageCode];
    }
    final defaultLocaleCode = AppLocalization.languages.keys.first.languageCode;
    return question.containsKey(defaultLocaleCode)
        ? question[defaultLocaleCode]
        : null;
  }

  @late
  String getAnswerByLanguageCode(String languageCode) {
    if (answer.containsKey(languageCode)) {
      return answer[languageCode];
    }
    final defaultLocaleCode = AppLocalization.languages.keys.first.languageCode;
    return answer.containsKey(defaultLocaleCode)
        ? answer[defaultLocaleCode]
        : null;
  }
}
