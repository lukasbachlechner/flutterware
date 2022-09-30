import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';

class WidgetbookFrameWrapper extends StatelessWidget {
  const WidgetbookFrameWrapper({
    super.key,
    required this.title,
    required this.child,
    this.withPadding = true,
  });

  final String title;
  final bool withPadding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppColors.primaryBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.p20),
        child: child,
      ),
    );
  }
}
