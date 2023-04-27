import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/utils/currency.dart';

void main() {
  test('formatCurrency formats a number', () {
    final result = formatCurrency(42);
    expect(result, isA<String>());
    expect(result, equals('€\u00a042,00'));
  });

  test('formatCurrency formats 0', () {
    final result = formatCurrency(0);
    expect(result, isA<String>());
    expect(result, equals('Free'));
  });

  test('formatCurrency formats a negative number', () {
    final result = formatCurrency(-42);
    expect(result, isA<String>());
    expect(result, equals('-€\u00a042,00'));
  });

  test('formatCurrency formats a double', () {
    final result = formatCurrency(42.42);
    expect(result, isA<String>());
    expect(result, equals('€\u00a042,42'));
  });

  test('formatCurrency formats a negative double', () {
    final result = formatCurrency(-42.42);
    expect(result, isA<String>());
    expect(result, equals('-€\u00a042,42'));
  });

  test('formatCurrency formats a double with more than 2 decimals', () {
    final result = formatCurrency(42.4242);
    expect(result, isA<String>());
    expect(result, equals('€\u00a042,42'));
  });

  test('formatCurrency formats a negative double with more than 2 decimals',
      () {
    final result = formatCurrency(-42.4242);
    expect(result, isA<String>());
    expect(result, equals('-€\u00a042,42'));
  });

  test('formatCurrency formats a double with less than 2 decimals', () {
    final result = formatCurrency(42.4);
    expect(result, isA<String>());
    expect(result, equals('€\u00a042,40'));
  });
}
