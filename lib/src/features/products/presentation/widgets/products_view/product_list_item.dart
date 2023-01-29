import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/constants/flutterware_icons.dart';
import 'package:flutterware/src/features/products/presentation/screens/single_product_screen.dart';
import 'package:flutterware/src/features/products/presentation/widgets/product_price.dart';
import 'package:flutterware/src/features/products/presentation/widgets/products_view/product_item_discount_badge.dart';
import 'package:go_router/go_router.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../product_rating.dart';

class ProductListItem extends StatelessWidget {
  final Product product;
  const ProductListItem({super.key, required this.product});

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
        child: SizedBox(
          height: 150,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.p8),
            child: Row(
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
                    if (product
                            .calculatedCheapestPrice?.listPrice?.percentage !=
                        null)
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: ProductItemDiscountBadge(
                          price: product.calculatedCheapestPrice!,
                        ),
                      ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.p16,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .apply(color: AppColors.blackSecondary),
                        ),
                        gapH16,
                        ProductPrice(price: product.calculatedPrice!),
                        const Spacer(),
                        ProductRating(
                          rating: product.ratingAverage ?? 0,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  child: const Icon(
                    FlutterwareIcons.favorites,
                    size: AppSizes.iconLG,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
