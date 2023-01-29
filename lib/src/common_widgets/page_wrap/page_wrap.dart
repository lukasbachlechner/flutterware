import 'package:flutter/material.dart';

class PageWrap extends StatelessWidget {
  final Widget child;
  const PageWrap({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(child: child);
  }
}
