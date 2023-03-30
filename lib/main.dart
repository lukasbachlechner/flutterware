import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterware/src/app.dart';
import 'package:flutterware/src/features/global/data/local_storage_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
    };

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    await Hive.initFlutter();
    await Hive.openBox(LocalStorageRepository.defaultBoxName);

    runApp(
      const ProviderScope(
        child: FlutterwareApp(),
      ),
    );

    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('An error occured'),
        ),
        body: Center(
          child: Text(
            details.toString(),
          ),
        ),
      );
    };
  }, (error, stack) {
    debugPrint(error.toString());
  });
}
