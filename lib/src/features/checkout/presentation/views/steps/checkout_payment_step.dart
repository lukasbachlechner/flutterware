import 'package:flutter/material.dart';
import 'package:flutterware/src/features/checkout/presentation/views/steps/checkout_step_wrapper.dart';
import 'package:flutterware/src/features/checkout/presentation/widgets/payment_method/payment_method_select.dart';
import 'package:flutterware/src/common_widgets/heading/heading.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/features/address/presentation/widgets/address_select.dart';
import 'package:shopware6_client/shopware6_client.dart';

class CheckoutPaymentStep extends StatelessWidget {
  const CheckoutPaymentStep({super.key});
  @override
  Widget build(BuildContext context) {
    return CheckoutStepWrapper(builder: (data) {
      final List<Address?> addresses = data.customer?.addresses ?? [];
      addresses.insert(0, data.customer?.defaultBillingAddress);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Heading(
            'Billing Details',
            level: HeadingLevel.h3,
          ),
          gapH40,
          AddressSelect(
            addresses: addresses,
          ),
          gapH40,
          const Heading(
            'Payment Method',
            level: HeadingLevel.h3,
          ),
          gapH40,
          const PaymentMethodSelect(),
        ],
      );
    });
  }
}
