import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutterware/src/features/cart/data/cart_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../../common_widgets/button/button.dart';

class ProductAddToCartButton extends HookConsumerWidget {
  final ID? productId;
  final int quantity;

  const ProductAddToCartButton({
    super.key,
    this.productId,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);

    return Button(
      label: isLoading.value ? 'loading...' : 'Add to cart',
      onPressed: () async {
        isLoading.value = true;

        ref.read(cartNotifierProvider.notifier).addItems([
          LineItem(
            id: productId,
            referencedId: productId,
            quantity: quantity,
            type: LineItemType.product,
          )
        ]);

        isLoading.value = false;

        if (context.mounted) {
          context.pop();
        }
      },
      disabled: productId == null,
      buttonSize: ButtonSize.fullWidth,
    );
  }
}
