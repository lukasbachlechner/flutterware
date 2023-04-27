import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/button/button.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/features/checkout/data/checkout_notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CheckoutFooter extends ConsumerWidget {
  const CheckoutFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkoutState = ref.watch(checkoutNotifierProvider);
    final checkoutNotifier = ref.watch(checkoutNotifierProvider.notifier);
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.p16,
          vertical: AppSizes.p16,
        ),
        color: AppColors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Button(
              label: checkoutState.nextButtonLabel,
              onPressed: () {
                checkoutNotifier.nextStep();
              },
            ),
            gapH16,
            Button(
              buttonType: ButtonType.secondary,
              label: 'Go back',
              onPressed: () {
                if (checkoutNotifier.isFirstStep) {
                  context.pop();
                } else {
                  checkoutNotifier.previousStep();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
