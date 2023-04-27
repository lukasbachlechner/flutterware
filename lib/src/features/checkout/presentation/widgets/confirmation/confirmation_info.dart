import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_sizes.dart';

import '../../../../../common_widgets/heading/heading.dart';

class ConfirmationInfo extends StatelessWidget {
  const ConfirmationInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: AppColors.greyLightAccent,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.p16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          gapH24,
          Heading(
            'Your Purchase',
            level: HeadingLevel.h3,
          ),
          gapH24,
          Text(
            "You have successfuly placed the order. You can check status of your order by using our delivery status feature. You will receive an order confirmation e-mail with details of your order and a link to track its progress.",
          ),
          gapH24,
        ],
      ),
    );
  }
}
