import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:yulli/abstracts/base_sign_form_viewmodel.dart';
import 'package:yulli/abstracts/form_viewmodel.dart';
import 'package:yulli/constants/firebase_auth_error_codes.dart';
import 'package:yulli/constants/form_constraints.dart';
import 'package:yulli/exceptions/network_connection_error.dart';
import 'package:yulli/exceptions/unexpected_error.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/services/auth_service.dart';
import 'package:string_validator/string_validator.dart' as Validators;

enum SignUpInputType {
  firstname,
  lastname,
}

class SignUpFormViewModel extends BaseSignFormViewModel {
  SignUpFormViewModel(
    AppLocalization_Labels localization,
    AuthService authService,
  ) : super(localization, authService);

  String _firstname;
  String _lastname;
  String _firstnameError;
  String _lastnameError;

  String get firstnameError => _firstnameError;
  String get lastnameError => _lastnameError;

  void setFirstName(String value) {
    _firstname = value;
    _firstnameError = _validateInput(value, SignUpInputType.firstname);
    notifyListeners();
  }

  void setLastName(String value) {
    _lastname = value;
    _lastnameError = _validateInput(value, SignUpInputType.lastname);
    notifyListeners();
  }

  @override
  void clearErrors({bool notify = true}) {
    _firstnameError = null;
    _lastnameError = null;
    super.clearErrors(notify: notify);
  }

  String _validateInput(String value, SignUpInputType type) {
    String valueToReturn;
    switch (type) {
      case SignUpInputType.firstname:
        if (value == null ||
            !Validators.isLength(
              value,
              FormConstraints.namesMinLength,
              FormConstraints.namesMaxLength,
            )) {
          valueToReturn = localization.errors.validations.length(
            field: localization.labels.firstname,
            min: FormConstraints.namesMinLength.toString(),
            max: FormConstraints.namesMaxLength.toString(),
          );
        }
        break;
      case SignUpInputType.lastname:
        if (value == null ||
            !Validators.isLength(
              value,
              FormConstraints.namesMinLength,
              FormConstraints.namesMaxLength,
            )) {
          valueToReturn = localization.errors.validations.length(
            field: localization.labels.lastname,
            min: FormConstraints.namesMinLength.toString(),
            max: FormConstraints.namesMaxLength.toString(),
          );
        }
        break;
    }
    if (autoValidate) {
      if (formState.validate() && !validationState.isValid) {
        setValidationState(FormValidationState.valid);
      } else if (!formState.validate() && !validationState.isInvalid) {
        setValidationState(FormValidationState.invalid);
      }
    }
    return valueToReturn;
  }

  @override
  String baseValidateInput(String value, BaseSignInputType inputType) {
    String error;
    switch (inputType) {
      case BaseSignInputType.email:
        if (value == null || !EmailValidator.validate(value)) {
          error = localization.errors.validations.invalidEmail;
        }
        break;
      case BaseSignInputType.password:
        if (value == null || value.length < FormConstraints.passwordMinLength) {
          error = localization.errors.validations.passwordLength(
              min: FormConstraints.passwordMinLength.toString());
        } else if (!RegexValidation.hasMatch(
          value,
          RegexPattern.passwordNormal1AllowedWhitespace,
        )) {
          error = localization.errors.validations.passwordRegex;
        }
        break;
    }
    if (autoValidate) {
      if (formState.validate() && !validationState.isValid) {
        setValidationState(FormValidationState.valid);
      } else if (!formState.validate() && !validationState.isInvalid) {
        setValidationState(FormValidationState.invalid);
      }
    }
    return error;
  }

  @override
  void validateAllInputs({bool notify = true}) {
    assert(notify != null);

    _firstnameError = _validateInput(_firstname, SignUpInputType.firstname);
    _lastnameError = _validateInput(_lastname, SignUpInputType.lastname);

    super.validateAllInputs(notify: notify);
  }

  @override
  Future<bool> validate() async {
    print(this);
    setSubmitting(true);
    if (formState.validate()) {
      setValidationState(FormValidationState.valid);

      try {
        final user = await authService.register(
          email,
          password,
          _lastname,
          _firstname,
        );
        setSubmitting(false);
        return true;
      } on FirebaseAuthException catch (e) {
        handleAuthException(e);
      } on UnexpectedException catch (e) {
        handleUnexpectedException(e);
      } on NetworkConnectionException {
        handleUnexpectedException(new UnexpectedException(
            localization.errors.exceptions.networkConnectionFailed));
      }
    } else {
      setAutoValidate(true);
      setValidationState(FormValidationState.invalid);
    }
    setSubmitting(false);
    return false;
  }

  @override
  String toString() => """
    firstname: $_firstname,
    lastname: $_lastname,
    email: $email,
    password: $password,

    submitting: $submitting,

    firstnameError: $firstnameError,
    lastnameError: $lastnameError,
    emailError: $emailError,
    passwordError: $passwordError,

    autoValidate: $autoValidate,

    validationState: $validationState,
  """;

  @override
  void handleAuthException(FirebaseAuthException exception) {
    switch (exception.code) {
      case FirebaseAuthErrorCodes.emailAlreadyInUse:
        setEmailError(localization.errors.validations.alreadyInUseEmail);
        break;
      case FirebaseAuthErrorCodes.invalidEmail:
        setEmailError(localization.errors.validations.invalidEmail);
        break;
      case FirebaseAuthErrorCodes.weakPassword:
        setPasswordError(
          localization.errors.validations.passwordLength(
              min: FormConstraints.passwordMinLength.toString()),
        );
        break;
      default:
        handleUnexpectedException(UnexpectedException(null));
    }
  }
}
