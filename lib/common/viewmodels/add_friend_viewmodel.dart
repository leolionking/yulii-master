import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:yulli/abstracts/form_viewmodel.dart';
import 'package:yulli/exceptions/unexpected_error.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/services/db_service.dart';

class AddFriendViewModel extends FormViewModel {
  DbService _dbService;

  AddFriendViewModel(AppLocalization_Labels localization) : super(localization);

  String _email;
  String _emailError;
  String _additionalMessage;

  String get emailError => _emailError;
  String get additionalMessage => _additionalMessage;

  void setDependencies({@required DbService dbService}) {
    _dbService = dbService;
  }

  void setEmail(String email) async {
    clearErrors(notify: true);
    setAutoValidate(false);
    _email = email;
    validateAllInputs();
  }

  void _setEmailError(String error) {
    _emailError = error;
    notifyListeners();
  }

  void setAdditionalMessage(String message, {bool notify = true}) {
    _additionalMessage = message;
    if (notify) notifyListeners();
  }

  @override
  void clearErrors({bool notify = true}) {
    _emailError = null;
    if (notify) notifyListeners();
  }

  @override
  Future<bool> validate() async {
    setAdditionalMessage(null, notify: false);
    setSubmitting(true);

    if (formState.validate()) {
      setValidationState(FormValidationState.valid);

      try {
        final result = await _dbService.sendFriendInvitation(_email);

        if (!result) {
          _setEmailError(localization.errors.validations.alreadyFriend);
          setSubmitting(false);
          return false;
        }
        setSubmitting(false);
        return true;
      } on PlatformException catch (e) {
        handleUnexpectedException(
          UnexpectedException(
            localization.errors.exceptions.networkConnectionFailed,
          ),
        );
      } catch (e) {
        print(e);
        handleUnexpectedException(
          UnexpectedException(
            localization.errors.exceptions.unexpected,
          ),
        );
      }
    } else {
      setValidationState(FormValidationState.invalid);
    }
    setSubmitting(false);
    return false;
  }

  @override
  void validateAllInputs({bool notify = true}) {
    if (_email == null || !EmailValidator.validate(_email)) {
      _emailError = localization.errors.validations.invalidEmail;
    } else {
      _emailError = null;
    }
    if (notify) notifyListeners();
  }
}
