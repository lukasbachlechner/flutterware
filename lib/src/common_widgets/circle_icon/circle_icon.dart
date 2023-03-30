import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';

class CircleIcon extends StatelessWidget {
  final IconData iconData;
  const CircleIcon(this.iconData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.p24,
      height: AppSizes.p24,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        size: AppSizes.iconXXS,
        color: AppColors.white,
      ),
    );
  }

  static Widget placeholder() {
    return const SizedBox.square(
      dimension: AppSizes.p24,
    );
  }
}
