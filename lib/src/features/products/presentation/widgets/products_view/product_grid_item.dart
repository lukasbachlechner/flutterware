import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/features/products/presentation/screens/single_product_screen.dart';
import 'package:flutterware/src/features/products/presentation/widgets/product_rating.dart';
import 'package:go_router/go_router.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../../../constants/app_colors.dart';
import '../product_price.dart';
import 'product_item_discount_badge.dart';

class ProductGridItem extends StatelessWidget {
  final Product product;
  const ProductGridItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.p16).copyWith(top: 0),
      child: InkWell(
        onTap: () => context.goNamed(
          SingleProductScreen.name,
          params: {
            "productId": product.id.toString(),
          },
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    product.cover?.media.url ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
                if (product.calculatedCheapestPrice?.listPrice?.percentage !=
                    null)
                  Positioned(
                    left: 0,
                    top: AppSizes.p8,
                    child: ProductItemDiscountBadge(
                      price: product.calculatedCheapestPrice!,
                    ),
                  ),
              ],
            ),
            gapH8,
            Text(
              product.name,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .apply(color: AppColors.blackSecondary),
            ),
            gapH4,
            ProductPrice(price: product.calculatedPrice!),
            gapH4,
            const ProductRating(),
          ],
        ),
      ),
    );
  }
}
