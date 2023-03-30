import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/image/image.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/features/cart/data/cart_repository.dart';
import 'package:flutterware/src/features/products/presentation/widgets/product_price.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopware6_client/shopware6_client.dart';

class CartProductItem extends ConsumerWidget {
  final LineItem lineItem;
  const CartProductItem({
    super.key,
    required this.lineItem,
  });

  Widget _buildOptionItem(
      LineItemProductOption lineItemProductOption, BuildContext context) {
    final sharedStyle = Theme.of(context).textTheme.headlineMedium!;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.p8),
      child: Row(
        children: [
          if (lineItemProductOption.group != null &&
              lineItemProductOption.group!.length <= 15)
            Text(
              '${lineItemProductOption.group}: ',
              style: sharedStyle,
            ),
          Text(
            lineItemProductOption.option ?? '',
            style: sharedStyle.copyWith(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.p20,
        horizontal: AppSizes.p16,
      ).copyWith(
        bottom: 0,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.p8,
        ).copyWith(
          bottom: AppSizes.p8,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.greyLightAccent),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FwImage(
              src: lineItem.cover?.url ?? '',
              width: 140,
            ),
            gapW16,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lineItem.label ?? '',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  gapH8,
                  ProductPrice(price: lineItem.price!),
                  if ((lineItem.payload as LineItemProduct).options != null &&
                      (lineItem.payload as LineItemProduct)
                          .options!
                          .isNotEmpty) ...[
                    gapH16,
                    ...?(lineItem.payload as LineItemProduct).options?.map(
                        (itemOption) => _buildOptionItem(itemOption, context)),
                  ],
                  gapH20,
                  GestureDetector(
                    onTap: () {
                      ref.read(cartNotifierProvider.notifier).removeItems([
                        lineItem.referencedId!,
                      ]);
                    },
                    child: const Text('Remove from cart'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
