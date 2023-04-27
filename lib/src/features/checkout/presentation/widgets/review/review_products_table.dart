import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/async_value_widget/async_value_widget.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/features/cart/data/cart_repository.dart';
import 'package:flutterware/src/features/checkout/presentation/widgets/review/review_products_table_header.dart';
import 'package:flutterware/src/features/checkout/presentation/widgets/review/review_products_table_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'review_products_table_footer.dart';

class ReviewProductsTable extends ConsumerWidget {
  const ReviewProductsTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      data: (CartState cartState) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.p16,
          ),
          child: Column(
            children: [
              const ReviewProductsTableHeader(),
              const Divider(
                color: AppColors.primaryColor,
                thickness: 2,
              ),
              ...cartState.products.map(
                (lineItem) => ReviewProductsTableItem(
                  lineItem: lineItem,
                ),
              ),
              gapH40,
              ReviewProductsTableFooter(
                cartState: cartState,
              ),
            ],
          ),
        );
      },
      value: ref.watch(cartNotifierProvider),
    );
  }
}
