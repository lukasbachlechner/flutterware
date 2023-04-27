import 'package:flutter/material.dart';

import '../../../../../constants/app_colors.dart';
import '../../../data/checkout_state.dart';

class CheckoutStepsRailItem extends StatelessWidget {
  final CheckoutState state;
  final bool isActive;

  const CheckoutStepsRailItem({
    super.key,
    required this.state,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      state.title,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            fontSize: 14.0,
            color: isActive ? AppColors.primaryColor : AppColors.blackPrimary,
          ),
    );
  }
}
