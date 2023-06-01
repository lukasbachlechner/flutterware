import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/features/authentication/data/validators/email_and_password_validators.dart';

class _Validator with EmailAndPasswordValidators {}

final _validator = _Validator();

void main() {
  group('EmailAndPasswordValidators', () {
    test('can validate emails', () {
      const correctEmail = 'a@b.com';
      final incorrectEmails = [
        '',
        'a',
        'a@',
        'a@b',
        'a@b.',
        'a@.com',
        '@b.com',
      ];

      expect(_validator.canSubmitEmail(correctEmail), isTrue);
      for (final email in incorrectEmails) {
        expect(_validator.canSubmitEmail(email), isFalse);
      }
    });

    test('can validate password (submit)', () {
      const correctPassword = 'password';
      const incorrectPassword = 'passwo';

      expect(_validator.canSubmitPasswordRegister(correctPassword), isTrue);
      expect(_validator.canSubmitPasswordRegister(incorrectPassword), isFalse);
    });

    test('can validate password (login)', () {
      const correctPassword = 'password';
      const incorrectPassword = '';

      expect(_validator.canSubmitPasswordLogin(correctPassword), isTrue);
      expect(_validator.canSubmitPasswordLogin(incorrectPassword), isFalse);
    });

    test('can return error text for email', () {
      const correctEmail = 'a@b.com';
      const incorrectEmail = 'a@b';

      expect(_validator.emailErrorText(correctEmail), isNull);
      expect(_validator.emailErrorText(incorrectEmail), isNotNull);
    });

    test('can return error text for password (submit)', () {
      const correctPassword = 'password';
      const incorrectPassword = 'passwo';

      expect(_validator.passwordRegisterErrorText(correctPassword), isNull);
      expect(
        _validator.passwordRegisterErrorText(incorrectPassword),
        isNotNull,
      );
    });

    test('can return error text for password (login)', () {
      const correctPassword = 'password';
      const incorrectPassword = '';

      expect(_validator.passwordLoginErrorText(correctPassword), isNull);
      expect(_validator.passwordLoginErrorText(incorrectPassword), isNotNull);
    });
  });
}
