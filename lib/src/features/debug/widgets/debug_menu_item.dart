import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_sizes.dart';

class DebugMenuItem extends StatelessWidget {
  final String title;
  final String value;
  const DebugMenuItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: AppSizes.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
