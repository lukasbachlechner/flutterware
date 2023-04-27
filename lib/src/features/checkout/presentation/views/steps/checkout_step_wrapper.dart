import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/async_value_widget/async_value_widget.dart';
import 'package:flutterware/src/features/cart/widgets/cart_price_details.dart';
import 'package:flutterware/src/features/global/data/global_data_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../constants/app_sizes.dart';

class CheckoutStepWrapper extends HookConsumerWidget {
  final Widget Function(GlobalData data) builder;
  final bool showPriceDetails;
  final bool withPadding;

  const CheckoutStepWrapper({
    super.key,
    required this.builder,
    this.showPriceDetails = true,
    this.withPadding = true,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: withPadding
              ? const EdgeInsets.symmetric(
                  horizontal: AppSizes.p16,
                )
              : EdgeInsets.zero,
          child: AsyncValueWidget(
            data: (data) {
              return builder(data);
            },
            value: ref.watch(globalDataNotifierProvider),
          ),
        ),
        if (showPriceDetails) ...[
          gapH40,
          const CartPriceDetails(),
        ]
      ],
    );
  }
}
