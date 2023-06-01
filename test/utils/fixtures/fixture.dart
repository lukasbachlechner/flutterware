import 'dart:io';

import 'package:flutter/services.dart';

class Fixture {
  final String requestPath;

  const Fixture(this.requestPath);

  static const fixturesBasePath = 'test/utils/fixtures/';
  static const fixturesTestFile = '__fixtures__';

  bool shouldUseRootBundle() {
    final testFile = File('$fixturesBasePath$fixturesTestFile');
    return !testFile.existsSync();
  }

  String get _fixturePath {
    String cleanPath = requestPath.replaceAll('store-api/', '');
    String fullPath = "$fixturesBasePath$cleanPath";

    final isDirectory = Directory(fullPath).existsSync();
    if (isDirectory) {
      return '$fullPath/_index.json';
    }

    return '$fullPath.json';
  }

  Future<String> get() async {
    if (shouldUseRootBundle()) {
      return await rootBundle.loadString(_fixturePath);
    }
    return File(_fixturePath).readAsStringSync();
  }
}
