import 'package:flutter/material.dart';

class TestWrapper extends StatelessWidget {
  const TestWrapper({
    super.key,
    required this.child,
    this.withScaffold = true,
  });

  final Widget child;
  final bool withScaffold;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: withScaffold
          ? Scaffold(
              body: child,
            )
          : child,
    );
  }
}
