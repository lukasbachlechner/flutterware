import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';

import '../../../../constants/app_fonts.dart';

class ProductVariantSelectItem extends StatelessWidget {
  final bool isSelected;
  final bool isAvailable;
  final VoidCallback onPressed;
  final String label;

  const ProductVariantSelectItem({
    super.key,
    this.isAvailable = true,
    this.isSelected = false,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isAvailable ? onPressed : null,
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(AppSizes.p20),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.greyLightAccent,
            ),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: AppFonts.displayFont,
              fontWeight: FontWeight.w600,
              fontSize: AppSizes.p16,
              color: _getColor(),
            ),
          ),
        ),
      ),
    );
  }

  Color _getColor() {
    if (isSelected) {
      return AppColors.primaryColor;
    }

    if (isAvailable) {
      return AppColors.blackPrimary;
    }

    return AppColors.greyDarkAccent;
  }
}
