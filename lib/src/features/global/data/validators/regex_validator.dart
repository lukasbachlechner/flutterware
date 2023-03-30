import 'validators.dart';

class RegexValidator implements StringValidator {
  final String regexSource;

  RegexValidator({required this.regexSource});

  @override
  bool isValid(String value) {
    try {
      final RegExp regex = RegExp(regexSource);
      final Iterable<Match> matches = regex.allMatches(value);

      for (final match in matches) {
        if (match.start == 0 && match.end == value.length) {
          return true;
        }
      }

      return false;
    } catch (e) {
      // Passed regex is invalid
      assert(false, e.toString());

      return true;
    }
  }
}
