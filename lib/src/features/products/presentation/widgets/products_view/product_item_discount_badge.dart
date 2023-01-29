import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_fonts.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:shopware6_client/shopware6_client.dart';

class ProductItemDiscountBadge extends StatelessWidget {
  final CalculatedPrice price;
  const ProductItemDiscountBadge({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    if (price.listPrice?.percentage == null) {
      return const SizedBox.shrink();
    }

    final formattedDiscount = "-${price.listPrice!.percentage!.round()}%";

    return Container(
      color: AppColors.primaryRed,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.p8,
        vertical: AppSizes.p4,
      ),
      child: Text(
        formattedDiscount,
        style: const TextStyle(
          fontFamily: AppFonts.displayFont,
          color: AppColors.white,
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
