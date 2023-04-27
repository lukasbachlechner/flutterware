import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/heading/heading.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/features/address/presentation/widgets/address_select.dart';
import 'package:flutterware/src/features/checkout/presentation/views/steps/checkout_step_wrapper.dart';
import 'package:flutterware/src/features/checkout/presentation/widgets/shipping_method/shipping_method_select.dart';
import 'package:flutterware/src/features/global/data/global_data_notifier.dart';
import 'package:shopware6_client/shopware6_client.dart';

class CheckoutShippingStep extends StatelessWidget {
  const CheckoutShippingStep({super.key});
  @override
  Widget build(BuildContext context) {
    return CheckoutStepWrapper(builder: (GlobalData data) {
      final List<Address?> addresses = data.customer?.addresses ?? [];
      addresses.insert(0, data.customer?.defaultShippingAddress);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Heading(
            'Shipping Details',
            level: HeadingLevel.h3,
          ),
          gapH40,
          AddressSelect(
            addresses: addresses,
          ),
          gapH40,
          const Heading(
            'Shipping Method',
            level: HeadingLevel.h3,
          ),
          gapH40,
          const ShippingMethodSelect()
        ],
      );
    });
  }
}
