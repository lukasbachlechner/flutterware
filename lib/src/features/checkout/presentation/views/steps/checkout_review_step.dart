import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/features/checkout/presentation/views/steps/checkout_step_wrapper.dart';
import 'package:flutterware/src/features/checkout/presentation/widgets/review/review_products_table.dart';

import '../../../../../common_widgets/heading/heading.dart';
import '../../widgets/review/review_details.dart';

class CheckoutReviewStep extends StatelessWidget {
  const CheckoutReviewStep({super.key});
  @override
  Widget build(BuildContext context) {
    return CheckoutStepWrapper(
      showPriceDetails: false,
      withPadding: false,
      builder: (data) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Heading(
              'Order Overview',
              level: HeadingLevel.h3,
              inContainer: true,
            ),
            gapH40,
            ReviewProductsTable(),
            gapH40,
            ReviewDetails(),
            // CartDetails(),
          ],
        );
      },
    );
  }
}
