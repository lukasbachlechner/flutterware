import 'package:flutter/material.dart';
import 'package:flutterware/src/features/checkout/data/checkout_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../constants/app_colors.dart';

class CheckoutStepsProgressIndicator extends HookConsumerWidget {
  const CheckoutStepsProgressIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Quick and dirty solution to rerender on state changes, because this value exists only in the notifier.
    ref.watch(checkoutNotifierProvider);

    final cartNotifier = ref.read(checkoutNotifierProvider.notifier);

    return LinearProgressIndicator(
      minHeight: 2,
      backgroundColor: Colors.transparent,
      color: AppColors.primaryColor,
      value: cartNotifier.progress,
    );
  }
}
