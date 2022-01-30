import 'package:firebase_auth/firebase_auth.dart';
import 'package:yulli/abstracts/form_viewmodel.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/services/auth_service.dart';

enum BaseSignInputType {
  email,
  password,
}

abstract class BaseSignFormViewModel extends FormViewModel {
  final AuthService authService;

  BaseSignFormViewModel(AppLocalization_Labels localization, this.authService)
      : assert(authService != null),
        super(localization);

  String _email;
  String _password;
  String _emailError;
  String _passwordError;

  String get email => _email;
  String get password => _password;
  String get emailError => _emailError;
  String get passwordError => _passwordError;

  void setEmail(String value) async {
    clearErrors(notify: true);
    await Future.delayed(Duration(milliseconds: 100));
    setAutoValidate(false);
    _email = value;
    _emailError = baseValidateInput(value, BaseSignInputType.email);
    notifyListeners();
  }

  void setPassword(String value) async {
    clearErrors(notify: true);
    await Future.delayed(Duration(milliseconds: 100));
    setAutoValidate(false);
    _password = value;
    _passwordError = baseValidateInput(value, BaseSignInputType.password);
    notifyListeners();
  }

  void setEmailError(String error) {
    _emailError = error;
    notifyListeners();
  }

  void setPasswordError(String error) {
    _passwordError = error;
    notifyListeners();
  }

  String baseValidateInput(String value, BaseSignInputType inputType);

  void handleAuthException(FirebaseAuthException exception);

  @override
  void clearErrors({bool notify = true}) {
    _passwordError = null;
    _emailError = null;
    if (notify) {
      notifyListeners();
    }
  }

  @override
  void validateAllInputs({bool notify = true}) {
    _emailError = baseValidateInput(_email, BaseSignInputType.email);
    _passwordError = baseValidateInput(_password, BaseSignInputType.password);

    if (notify) {
      notifyListeners();
    }

    print(this);
  }
}
