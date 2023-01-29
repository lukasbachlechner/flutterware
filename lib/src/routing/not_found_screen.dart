import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/button/button.dart';
import 'package:flutterware/src/features/home/presentation/home_screen.dart';
import 'package:go_router/go_router.dart';

class NotFoundScreen extends StatelessWidget {
  final Exception? error;
  const NotFoundScreen({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Not found'),
            if (error != null) Text(error.toString()),
            Button(
              label: 'Go home',
              onPressed: () => context.go(HomeScreen.path),
            ),
          ],
        ),
      ),
    );
  }
}
