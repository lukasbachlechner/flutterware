import 'package:flutter/material.dart';
import 'package:flutterware/src/features/cart/data/cart_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_sizes.dart';
import '../../../utils/currency.dart';

class CartPriceDetails extends ConsumerWidget {
  final Cart cart;
  const CartPriceDetails({super.key, required this.cart});

  Widget _buildTableItem(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: AppColors.greyLightAccent,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.p16,
        vertical: AppSizes.p24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Totals',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          gapH40,
          _buildTableItem(
            context,
            label: 'Products:',
            value: ref
                .watch(cartNotifierProvider.notifier)
                .productCount
                .toString(),
          ),
          gapH24,
          _buildTableItem(context,
              label: 'Subtotal:',
              value: formatCurrency(cart.price?.positionPrice ?? 0)),
          gapH24,
          _buildTableItem(
            context,
            label: 'Shipping (${cart.deliveries?[0].shippingMethod?.name}):',
            value: formatCurrency(
                cart.deliveries?[0].shippingCosts?.totalPrice ?? 0),
          ),
          /*  gapH8,
          ...?cart.price?.calculatedTaxes
              ?.map(
                (item) => _buildTableItem(
                  context,
                  label: '+ Tax (${item.taxRate} %)',
                  value: formatCurrency(item.tax ?? 0),
                ),
              )
              .toList(), */
          gapH40,
          const Divider(
            color: AppColors.white,
          ),
          gapH24,
          _buildTableItem(
            context,
            label: 'Total price:',
            value: formatCurrency(
              cart.price?.totalPrice ?? 0,
            ),
          ),
          gapH24,
        ],
      ),
    );
  }
}
