import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/checkout_notifier.dart';
import 'checkout_steps_progress_indicator.dart';
import 'checkout_steps_rail_item.dart';

class CheckoutStepsRail extends ConsumerWidget {
  const CheckoutStepsRail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkoutState = ref.watch(checkoutNotifierProvider);
    final checkoutNotifier = ref.watch(checkoutNotifierProvider.notifier);
    return SizedBox(
      height: 50,
      child: Stack(
        children: [
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: checkoutNotifier.steps
                  .map(
                    (step) => Expanded(
                      child: CheckoutStepsRailItem(
                        state: step,
                        isActive: checkoutNotifier.isStepDone(step),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CheckoutStepsProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
