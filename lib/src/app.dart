import 'package:flutter/material.dart';

import 'theme/dark_theme.dart';
import 'theme/light_theme.dart';

class FlutterwareApp extends StatelessWidget {
  const FlutterwareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: getDarkTheme(),
      theme: getLightTheme(),
      themeMode: ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Test'),
        ),
        body: const Center(
          child: Text('Home'),
        ),
      ),
    );
  }
}
