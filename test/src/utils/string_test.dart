import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/utils/string.dart';

void main() {
  group('limitToThreshold', () {
    const lowInput = 42;
    const highInput = 142;
    const threshold = 100;
    test('correctly formats a input below the threshold', () {
      final result = limitToThreshold(lowInput, threshold: threshold);
      expect(result, isA<String>());
      expect(result, equals(lowInput.toString()));
    });

    test('correctly formats a input above the threshold', () {
      final result = limitToThreshold(highInput, threshold: threshold);
      expect(result, isA<String>());
      expect(result, equals('99+'));
    });

    test('correctly formats a input equal to the threshold', () {
      final result = limitToThreshold(threshold, threshold: threshold);
      expect(result, isA<String>());
      expect(result, equals('99+'));
    });

    test('correctly displays an alternative overflow character', () {
      final result = limitToThreshold(
        threshold,
        threshold: threshold,
        overflowCharacter: '#',
      );
      expect(result, isA<String>());
      expect(result, equals('99#'));
    });
  });
}
