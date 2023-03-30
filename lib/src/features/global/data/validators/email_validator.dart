import 'validators.dart';

/// Validator to use while editing email.
/// Less strict to not bother the user too much.
class EmailEditingRegexValidator extends RegexValidator {
  EmailEditingRegexValidator() : super(regexSource: '^(|\\S)+\$');
}

/// Validator to use before submitting to thorougly check the email.
class EmailSubmitRegexValidator extends RegexValidator {
  EmailSubmitRegexValidator() : super(regexSource: '^\\S+@\\S+\\.\\S+\$');
}
