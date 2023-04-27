import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/async_value_widget/async_value_widget.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/features/cart/data/cart_repository.dart';
import 'package:flutterware/src/features/cart/widgets/cart_price_details.dart';
import 'package:flutterware/src/features/cart/widgets/cart_product_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartDetails extends ConsumerWidget {
  const CartDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(cartNotifierProvider),
      data: (cartState) => SingleChildScrollView(
        child: Column(
          children: [
            gapH4,
            const CartPriceDetails(),
            ...cartState.products.map(
              (product) => CartProductItem(lineItem: product),
            ),
          ],
        ),
      ),
    );
  }
}
