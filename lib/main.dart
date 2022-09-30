import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterware/src/app.dart';

void main() async {
  await runZonedGuarded(() async {
    runApp(const FlutterwareApp());

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
    };

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
