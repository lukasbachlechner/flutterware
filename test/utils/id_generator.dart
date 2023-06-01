import 'dart:math';

import 'package:shopware6_client/shopware6_client.dart';

class IDGenerator {
  static ID generate() {
    final r = Random();
    const allowedChars = "abcdef";
    const length = 32;
    final randomString = String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => allowedChars.codeUnitAt(
          r.nextInt(allowedChars.length),
        ),
      ),
    );
    return ID(randomString);
  }
}
