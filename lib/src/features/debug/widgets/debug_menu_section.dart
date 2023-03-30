import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_sizes.dart';

class DebugMenuSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const DebugMenuSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        gapH8,
        ...children,
        gapH16,
      ],
    );
  }
}
