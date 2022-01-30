import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yulli/exceptions/unexpected_error.dart';
import 'package:yulli/localizations.dart';

enum FormValidationState {
  idle,
  invalid,
  valid,
}

extension FormValidationStateValue on FormValidationState {
  bool get isValid => this == FormValidationState.valid;
  bool get isInvalid => this == FormValidationState.invalid;
  bool get isIdle => this == FormValidationState.idle;
  bool get isIdleOrValid => this.isValid || this.isIdle;
}

abstract class FormViewModel extends ChangeNotifier {
  final AppLocalization_Labels localization;

  GlobalKey<FormState> _formStateKey;
  bool _autoValidate = false;
  FormValidationState _validationState = FormValidationState.idle;
  BehaviorSubject<bool> _submittingStreamController =
      BehaviorSubject.seeded(false);
  BehaviorSubject<bool> _hasUnexpectedExceptionStreamController =
      BehaviorSubject();
  BehaviorSubject<UnexpectedException> _unexpectedExceptionStreamController =
      BehaviorSubject();
  bool _submitting = false;

  FormViewModel(this.localization) : assert(localization != null);

  bool get autoValidate => _autoValidate;
  FormState get formState => _formStateKey.currentState;
  FormValidationState get validationState => _validationState;
  Stream<bool> get submittingStream => _submittingStreamController.distinct();
  Stream<bool> get hasUnexpectedException =>
      _hasUnexpectedExceptionStreamController.distinct();
  Stream<UnexpectedException> get unexpectedExceptionStream =>
      _unexpectedExceptionStreamController.stream;

  bool get submitting => _submitting;

  void setSubmitting(bool submitting) {
    _submittingStreamController.sink.add(submitting);
    _submitting = submitting;
    notifyListeners();
  }

  void setAutoValidate(bool autoValidate) {
    _autoValidate = autoValidate;
    notifyListeners();
  }

  void setValidationState(FormValidationState validationState) {
    _validationState = validationState;
    notifyListeners();
  }

  void init(GlobalKey<FormState> formStateKey) {
    _formStateKey = formStateKey;
    if (!kReleaseMode) {
      addListener(this._innerListener);
    }
  }

  void clearErrors();

  void validateAllInputs();

  Future<bool> validate();

  void handleUnexpectedException(UnexpectedException exception) {
    _hasUnexpectedExceptionStreamController.add(true);
    _unexpectedExceptionStreamController.add(exception);
  }

  void _innerListener() {
    print(this);
  }

  @override
  void dispose() {
    if (!kReleaseMode) {
      removeListener(this._innerListener);
    }
    _submittingStreamController.close();
    _hasUnexpectedExceptionStreamController.close();
    _unexpectedExceptionStreamController.close();
    super.dispose();
  }
}
