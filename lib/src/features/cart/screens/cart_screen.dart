import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/async_value_widget/async_value_widget.dart';
import 'package:flutterware/src/common_widgets/page_wrap/page_wrap.dart';
import 'package:flutterware/src/common_widgets/top_nav_bar/top_nav_bar.dart';
import 'package:flutterware/src/features/cart/data/cart_repository.dart';
import 'package:flutterware/src/features/cart/widgets/cart_details.dart';
import 'package:flutterware/src/features/cart/widgets/empty_cart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartScreen extends ConsumerWidget {
  static const path = '/cart';
  static const name = 'cartScreen';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartValue = ref.watch(cartNotifierProvider);
    final cartNotifier = ref.watch(cartNotifierProvider.notifier);
    return PageWrap(
      child: Column(
        children: [
          const TopNavBar(title: 'My Cart'),
          Expanded(
            child: AsyncValueWidget(
              data: (cart) {
                if (cartNotifier.isEmpty) {
                  return const EmptyCart();
                }
                return const CartDetails();
              },
              value: cartValue,
            ),
          ),
        ],
      ),
    );
  }
}
