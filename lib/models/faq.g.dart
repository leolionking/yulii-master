// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Qa _$_$_QaFromJson(Map<String, dynamic> json) {
  return _$_Qa(
    question: (json['question'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    answer: (json['answer'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  );
}

Map<String, dynamic> _$_$_QaToJson(_$_Qa instance) => <String, dynamic>{
      'question': instance.question,
      'answer': instance.answer,
    };
