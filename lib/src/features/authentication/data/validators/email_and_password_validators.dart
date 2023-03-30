import 'package:flutterware/src/features/global/data/validators/validators.dart';

mixin EmailAndPasswordValidators {
  final StringValidator emailSubmitValidator = EmailSubmitRegexValidator();
  final StringValidator passwordRegisterSubmitValidator =
      MinLengthStringValidator(8);
  final StringValidator passwordLoginSubmitValidator =
      NonEmptyStringValidator();

  bool canSubmitEmail(String email) {
    return emailSubmitValidator.isValid(email);
  }

  bool canSubmitPasswordLogin(String password) {
    return passwordLoginSubmitValidator.isValid(password);
  }

  bool canSubmitPasswordRegister(String password) {
    return passwordRegisterSubmitValidator.isValid(password);
  }

  String? emailErrorText(String email) {
    final bool showErrorText = !canSubmitEmail(email);

    return showErrorText ? 'Invalid email.' : null;
  }

  String? passwordLoginErrorText(String password) {
    final bool showErrorText = !canSubmitPasswordLogin(password);

    return showErrorText ? 'Password can\'t be empty.' : null;
  }

  String? passwordRegisterErrorText(String password) {
    final bool showErrorText = !canSubmitPasswordRegister(password);

    return showErrorText ? 'Password is too short.' : null;
  }
}
