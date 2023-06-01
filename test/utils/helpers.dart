import 'package:flutter/cupertino.dart';
import 'package:flutterware/src/features/global/data/local_storage_repository.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';

void Function(FlutterErrorDetails) disableOverflowErrors() {
  final originalOnError = FlutterError.onError!;
  FlutterError.onError = (FlutterErrorDetails details) {
    final exception = details.exception;
    final isOverflowError = exception is FlutterError &&
        !exception.diagnostics.any(
            (e) => e.value.toString().startsWith("A RenderFlex overflowed by"));

    if (isOverflowError) {
      print('Notice: Overflow error.');
    } else {
      FlutterError.presentError(details);
    }
  };
  return originalOnError;
}

Future<void> setUpHive() async {
  await setUpTestHive();
  await Hive.openBox(LocalStorageRepository.defaultBoxName);
}

Future<void> tearDownHive() async {
  await tearDownTestHive();
}
