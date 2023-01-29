import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_fonts.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../../utils/currency.dart';

class ProductPrice extends StatelessWidget {
  final CalculatedPrice price;
  const ProductPrice({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (price.listPrice != null) ...[
          Text(
            formatCurrency(price.listPrice?.price ?? 0),
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.displayFont,
              color: AppColors.primaryRed,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          gapW8,
        ],
        Text(
          formatCurrency(price.totalPrice ?? 0),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ],
    );
  }
}
