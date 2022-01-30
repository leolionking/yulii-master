import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yulli/abstracts/form_viewmodel.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/constants/firebase_auth_error_codes.dart';
import 'package:yulli/exceptions/network_connection_error.dart';
import 'package:yulli/exceptions/unexpected_error.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/services/auth_service.dart';

class ForgotPasswordFormViewModel extends FormViewModel {
  final AuthService authService;
  final MyLogger logger = MyLogger("ForgotPasswordFormViewModel");

  String _email;
  String _emailError;

  ForgotPasswordFormViewModel(
      AppLocalization_Labels localization, this.authService)
      : super(localization);

  String get email => _email;
  String get emailError => _emailError;

  void setEmail(String value) {
    _email = value;
    _emailError = _validateEmail(value);
    notifyListeners();
  }

  void setEmailError(String error) {
    _emailError = error;
    notifyListeners();
  }

  String _validateEmail(String email) {
    if (email == null || !EmailValidator.validate(email)) {
      return localization.errors.validations.invalidEmail;
    }
    return null;
  }

  @override
  void clearErrors({bool notify = true}) {
    _emailError = null;
    if (notify) {
      notifyListeners();
    }
  }

  @override
  Future<bool> validate() async {
    logger.d(this.toString());
    setSubmitting(true);

    if (formState.validate()) {
      setValidationState(FormValidationState.valid);

      try {
        await authService.sendPasswordRecoverRequest(email);
        setSubmitting(false);
        return true;
      } on FirebaseAuthException catch (e) {
        handleAuthException(e);
      } on UnexpectedException catch (e) {
        handleUnexpectedException(e);
      } on NetworkConnectionException {
        handleUnexpectedException(
          new UnexpectedException(
            localization.errors.exceptions.networkConnectionFailed,
          ),
        );
      }
    } else {
      setAutoValidate(true);
      setValidationState(FormValidationState.invalid);
    }
    setSubmitting(false);
    return false;
  }

  @override
  void validateAllInputs({bool notify = true}) {
    _emailError = _validateEmail(_email);

    if (notify) {
      notifyListeners();
    }
  }

  void handleAuthException(FirebaseAuthException exception) {
    switch (exception.code) {
      case FirebaseAuthErrorCodes.invalidEmail:
        setEmailError(localization.errors.validations.invalidEmail);
        break;
      case FirebaseAuthErrorCodes.userNotFound:
        setEmailError(localization.errors.validations.notRegisteredEmail);
        break;
      default:
        handleUnexpectedException(UnexpectedException(null));
    }
  }
}
