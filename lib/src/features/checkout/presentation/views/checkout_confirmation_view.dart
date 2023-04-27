import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutterware/src/common_widgets/button/button.dart';
import 'package:flutterware/src/features/checkout/data/order_notifier.dart';
import 'package:flutterware/src/features/checkout/presentation/widgets/checkout_top_bar.dart';
import 'package:flutterware/src/features/checkout/presentation/widgets/confirmation/confirmation_hero.dart';
import 'package:flutterware/src/features/checkout/presentation/widgets/confirmation/confirmation_info.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/app_sizes.dart';

class CheckoutConfirmationView extends HookConsumerWidget {
  const CheckoutConfirmationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(orderNotifierProvider);

    useEffect(() {
      return () {
        ref.invalidate(orderNotifierProvider);
      };
    }, [order]);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CheckoutTopBar(),
          ConfirmationHero(
            orderNumber: order?.orderNumber ?? '',
          ),
          const ConfirmationInfo(),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.p16),
            child: Button(
              label: 'Back to home page',
              buttonType: ButtonType.primaryBlack,
              buttonSize: ButtonSize.fullWidth,
              onPressed: () {
                context.pop();
              },
            ),
          )
        ],
      ),
    );
  }
}
