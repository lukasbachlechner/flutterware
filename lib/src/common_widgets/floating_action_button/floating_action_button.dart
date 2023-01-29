import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/floating_action_button/floating_action_button_badge.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/features/cart/data/cart_button_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../circle_button/circle_button.dart';

class FwFloatingActionButton extends ConsumerWidget {
  const FwFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartButtonNotifier = ref.watch(cartButtonNotifierProvider);

    return SizedBox.square(
      dimension: AppSizes.fabSize,
      child: Stack(
        children: [
          CircleButton(
            iconData: cartButtonNotifier.iconData,
            size: AppSizes.fabSize,
            onPressed: cartButtonNotifier.onPressed,
            color: cartButtonNotifier.buttonBackgroundColor,
          ),
          const Align(
            alignment: Alignment.topRight,
            child: FwFloatingActionButtonBadge(),
          )
        ],
      ),
    );
  }
}
