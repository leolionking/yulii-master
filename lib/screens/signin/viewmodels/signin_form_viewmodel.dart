import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:yulli/abstracts/base_sign_form_viewmodel.dart';
import 'package:yulli/abstracts/form_viewmodel.dart';
import 'package:yulli/constants/firebase_auth_error_codes.dart';
import 'package:yulli/exceptions/network_connection_error.dart';
import 'package:yulli/exceptions/unexpected_error.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/services/auth_service.dart';

class SignInFormViewModel extends BaseSignFormViewModel {
  SignInFormViewModel(
      AppLocalization_Labels localization, AuthService authService)
      : super(localization, authService);

  @override
  String baseValidateInput(String value, BaseSignInputType inputType) {
    switch (inputType) {
      case BaseSignInputType.email:
        if (value == null || value.isEmpty) {
          return localization.errors.validations
              .fieldRequired(field: localization.labels.email);
        }
        break;
      case BaseSignInputType.password:
        if (value == null || value.isEmpty) {
          return localization.errors.validations
              .fieldRequired(field: localization.labels.password);
        }
        break;
    }
    return null;
  }

  @override
  void handleAuthException(FirebaseAuthException exception) {
    switch (exception.code) {
      case FirebaseAuthErrorCodes.invalidEmail:
        setEmailError(localization.errors.validations.invalidEmail);
        break;
      case FirebaseAuthErrorCodes.wrongPassword:
        setEmailError(localization.errors.validations.invalidCredentials);
        break;
      case FirebaseAuthErrorCodes.userNotFound:
        setEmailError(localization.errors.validations.invalidCredentials);
        break;
      case FirebaseAuthErrorCodes.userDisabled:
        setEmailError(localization.errors.validations.disabledUser);
        break;
      case FirebaseAuthErrorCodes.tooManyRequests:
        handleUnexpectedException(
          new UnexpectedException(
            localization.errors.exceptions.tooManyRequests,
          ),
        );
        break;
      case FirebaseAuthErrorCodes.operationNotAllowed:
        handleUnexpectedException(
          new UnexpectedException(
            localization.errors.exceptions.operationNotAllowed,
          ),
        );
        break;
      default:
        handleUnexpectedException(new UnexpectedException(null));
    }
    setAutoValidate(true);
  }

  @override
  Future<bool> validate() async {
    print(this);
    setSubmitting(true);

    if (formState.validate()) {
      setValidationState(FormValidationState.valid);

      try {
        await authService.login(email, password);

        setSubmitting(false);
        return true;
      } on FirebaseAuthException catch (e) {
        print(e);
        handleAuthException(e);
      } on UnexpectedException catch (e) {
        print(e);
        handleUnexpectedException(e);
      } on NetworkConnectionException {
        print('network exception');

        handleUnexpectedException(
          new UnexpectedException(
              localization.errors.exceptions.networkConnectionFailed),
        );
      }
    } else {
      setAutoValidate(true);
      setValidationState(FormValidationState.invalid);
    }
    setSubmitting(false);
    print(this);
    return false;
  }

  @override
  String toString() => """
    email: $email,
    password: $password,

    submitting: $submitting,

    emailError: $emailError,
    passwordError: $passwordError,

    autoValidate: $autoValidate,

    validationState: $validationState,
  """;
}
