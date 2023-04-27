import 'package:flutter/material.dart';

class PageWrap extends StatelessWidget {
  final Widget child;
  final Color? color;
  const PageWrap({
    super.key,
    this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      child: child,
    );
  }
}
