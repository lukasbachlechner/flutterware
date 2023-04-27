import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';

class FwRadioButtonIcon extends StatelessWidget {
  final bool selected;
  const FwRadioButtonIcon({
    super.key,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final unselectedBorder = Border.all(
      color: AppColors.blackSecondary,
      width: 1,
    );

    final selectedBorder = Border.all(
      color: AppColors.primaryColor,
      width: 9,
    );

    final borderToUse = selected ? selectedBorder : unselectedBorder;

    return Container(
      width: AppSizes.p24,
      height: AppSizes.p24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: borderToUse,
      ),
    );
  }
}
