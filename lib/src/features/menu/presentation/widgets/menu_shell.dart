import 'package:flutter/material.dart';

class MenuShell extends StatelessWidget {
  final Widget child;
  const MenuShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Text('search bar here'),
          Expanded(child: child),
        ],
      ),
    );
  }
}
