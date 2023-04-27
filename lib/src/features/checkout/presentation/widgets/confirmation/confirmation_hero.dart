import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';

class ConfirmationHero extends StatelessWidget {
  final String orderNumber;

  const ConfirmationHero({
    super.key,
    required this.orderNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.p32,
        vertical: AppSizes.p20,
      ),
      color: AppColors.greyLightAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Thank you for \nyour order!',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          gapH20,
          const Text(
            'Order No.',
            style: TextStyle(
              color: AppColors.blackPrimary,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            orderNumber,
            style: const TextStyle(
              color: AppColors.blackPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
