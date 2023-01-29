import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/features/cart/data/cart_button_provider.dart';
import 'package:flutterware/src/features/cart/data/cart_repository.dart';
import 'package:flutterware/src/utils/string.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/app_sizes.dart';

class FwFloatingActionButtonBadge extends ConsumerWidget {
  const FwFloatingActionButtonBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItemCount = ref.watch(cartNotifierProvider.notifier).productCount;
    final cartButtonState = ref.watch(cartButtonNotifierProvider);

    if (cartItemCount == 0 || cartButtonState is! InitialCartButtonState) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const ShapeDecoration(
        color: AppColors.primaryRed,
        shape: StadiumBorder(),
      ),
      constraints: const BoxConstraints(
        minWidth: AppSizes.p16,
      ),
      height: AppSizes.p16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            limitToThreshold(cartItemCount),
            textAlign: TextAlign.center,
            // TODO: refactor styling
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
