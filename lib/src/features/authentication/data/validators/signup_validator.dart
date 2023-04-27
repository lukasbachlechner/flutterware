import 'package:flutterware/src/features/global/data/validators/validators.dart';

class SignupValidator {
  late final StringValidator zipcodeValidator;

  SignupValidator({
    required String zipcodePattern,
  }) {
    zipcodeValidator = RegexValidator(regexSource: zipcodePattern);
  }

  // Personal details
  final StringValidator emailSubmitValidator = EmailSubmitRegexValidator();
  final StringValidator passwordRegisterSubmitValidator =
      MinLengthStringValidator(8);
  final StringValidator firstNameValidator = NonEmptyStringValidator();
  final StringValidator lastNameValidator = NonEmptyStringValidator();
  final StringValidator streetValidator = NonEmptyStringValidator();
  final StringValidator cityValidator = NonEmptyStringValidator();

  bool canSubmitEmail(String email) {
    return emailSubmitValidator.isValid(email);
  }

  bool canSubmitPasswordRegister(String password) {
    return passwordRegisterSubmitValidator.isValid(password);
  }

  bool canSubmitFirstName(String firstName) {
    return firstNameValidator.isValid(firstName);
  }

  bool canSubmitLastName(String lastName) {
    return lastNameValidator.isValid(lastName);
  }

  String? emailErrorText(String email) {
    final bool showErrorText = !canSubmitEmail(email);

    return showErrorText ? 'Invalid email.' : null;
  }

  String? passwordRegisterErrorText(String password) {
    final bool showErrorText = !canSubmitPasswordRegister(password);

    return showErrorText ? 'Password is too short.' : null;
  }

  String? firstNameErrorText(String firstName) {
    final bool showErrorText = !canSubmitFirstName(firstName);

    return showErrorText ? 'First name can\'t be empty.' : null;
  }

  String? lastNameErrorText(String lastName) {
    final bool showErrorText = !canSubmitLastName(lastName);

    return showErrorText ? 'Last name can\'t be empty.' : null;
  }

  String? streetErrorText(String street) {
    final bool showErrorText = !streetValidator.isValid(street);

    return showErrorText ? 'Street can\'t be empty.' : null;
  }

  String? cityErrorText(String city) {
    final bool showErrorText = !cityValidator.isValid(city);

    return showErrorText ? 'City can\'t be empty.' : null;
  }

  String? zipcodeErrorText(String zipcode) {
    final bool showErrorText = !zipcodeValidator.isValid(zipcode);

    return showErrorText ? 'Zipcode is invalid.' : null;
  }
}
