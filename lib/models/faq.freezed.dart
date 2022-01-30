// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'faq.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Qa _$QaFromJson(Map<String, dynamic> json) {
  return _Qa.fromJson(json);
}

/// @nodoc
class _$QaTearOff {
  const _$QaTearOff();

// ignore: unused_element
  _Qa call(
      {@required Map<String, String> question,
      @required Map<String, String> answer}) {
    return _Qa(
      question: question,
      answer: answer,
    );
  }

// ignore: unused_element
  Qa fromJson(Map<String, Object> json) {
    return Qa.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Qa = _$QaTearOff();

/// @nodoc
mixin _$Qa {
  Map<String, String> get question;
  Map<String, String> get answer;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $QaCopyWith<Qa> get copyWith;
}

/// @nodoc
abstract class $QaCopyWith<$Res> {
  factory $QaCopyWith(Qa value, $Res Function(Qa) then) =
      _$QaCopyWithImpl<$Res>;
  $Res call({Map<String, String> question, Map<String, String> answer});
}

/// @nodoc
class _$QaCopyWithImpl<$Res> implements $QaCopyWith<$Res> {
  _$QaCopyWithImpl(this._value, this._then);

  final Qa _value;
  // ignore: unused_field
  final $Res Function(Qa) _then;

  @override
  $Res call({
    Object question = freezed,
    Object answer = freezed,
  }) {
    return _then(_value.copyWith(
      question: question == freezed
          ? _value.question
          : question as Map<String, String>,
      answer: answer == freezed ? _value.answer : answer as Map<String, String>,
    ));
  }
}

/// @nodoc
abstract class _$QaCopyWith<$Res> implements $QaCopyWith<$Res> {
  factory _$QaCopyWith(_Qa value, $Res Function(_Qa) then) =
      __$QaCopyWithImpl<$Res>;
  @override
  $Res call({Map<String, String> question, Map<String, String> answer});
}

/// @nodoc
class __$QaCopyWithImpl<$Res> extends _$QaCopyWithImpl<$Res>
    implements _$QaCopyWith<$Res> {
  __$QaCopyWithImpl(_Qa _value, $Res Function(_Qa) _then)
      : super(_value, (v) => _then(v as _Qa));

  @override
  _Qa get _value => super._value as _Qa;

  @override
  $Res call({
    Object question = freezed,
    Object answer = freezed,
  }) {
    return _then(_Qa(
      question: question == freezed
          ? _value.question
          : question as Map<String, String>,
      answer: answer == freezed ? _value.answer : answer as Map<String, String>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Qa extends _Qa with DiagnosticableTreeMixin {
  const _$_Qa({@required this.question, @required this.answer})
      : assert(question != null),
        assert(answer != null),
        super._();

  factory _$_Qa.fromJson(Map<String, dynamic> json) => _$_$_QaFromJson(json);

  @override
  final Map<String, String> question;
  @override
  final Map<String, String> answer;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Qa(question: $question, answer: $answer)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Qa'))
      ..add(DiagnosticsProperty('question', question))
      ..add(DiagnosticsProperty('answer', answer));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Qa &&
            (identical(other.question, question) ||
                const DeepCollectionEquality()
                    .equals(other.question, question)) &&
            (identical(other.answer, answer) ||
                const DeepCollectionEquality().equals(other.answer, answer)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(question) ^
      const DeepCollectionEquality().hash(answer);

  @JsonKey(ignore: true)
  @override
  _$QaCopyWith<_Qa> get copyWith => __$QaCopyWithImpl<_Qa>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_QaToJson(this);
  }
}

abstract class _Qa extends Qa {
  const _Qa._() : super._();
  const factory _Qa(
      {@required Map<String, String> question,
      @required Map<String, String> answer}) = _$_Qa;

  factory _Qa.fromJson(Map<String, dynamic> json) = _$_Qa.fromJson;

  @override
  Map<String, String> get question;
  @override
  Map<String, String> get answer;
  @override
  @JsonKey(ignore: true)
  _$QaCopyWith<_Qa> get copyWith;
}
