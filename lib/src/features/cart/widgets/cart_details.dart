import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/features/cart/data/cart_repository.dart';
import 'package:flutterware/src/features/cart/widgets/cart_price_details.dart';
import 'package:flutterware/src/features/cart/widgets/cart_product_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopware6_client/shopware6_client.dart';

class CartDetails extends ConsumerWidget {
  final Cart cart;
  const CartDetails({
    super.key,
    required this.cart,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          gapH4,
          CartPriceDetails(cart: cart),
          ...ref.watch(cartNotifierProvider.notifier).products.map(
                (product) => CartProductItem(lineItem: product),
              ),
          /* ...?cart.lineItems
              ?.where((item) => item.type == LineItemType.product)
              .map(
                (item) => ListTile(
                  title: Text(item.label ?? ''),
                  /* subtitle: Text(
                      (item.payload as LineItemProduct?)?.options.map((option) => null) ??
                          ''), */
                  trailing: IconButton(
                      onPressed: () => ref
                              .read(cartRepositoryProvider)
                              .removeItems([item.referencedId!]).then(
                            (_) => ref.refresh(getOrCreateCartFutureProvider),
                          ),
                      icon: const Icon(FlutterwareIcons.close)),
                ),
              )
              .toList() */
        ],
      ),
    );
  }
}
