import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/heading/heading.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/features/cart/data/cart_repository.dart';

import '../../../../../constants/app_sizes.dart';
import '../../../../../utils/currency.dart';

class ReviewProductsTableFooter extends StatelessWidget {
  final CartState cartState;
  const ReviewProductsTableFooter({
    super.key,
    required this.cartState,
  });

  Widget _buildPrice(double? amount, BuildContext context) {
    return Text(
      formatCurrency(amount ?? 0),
      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.w700,
          ),
    );
  }

  Widget _buildRow(
    BuildContext context, {
    required String label,
    required double? amount,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppSizes.p20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Heading(
            label,
            level: HeadingLevel.h4,
          ),
          _buildPrice(amount, context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRow(
          context,
          label: 'Subtotal',
          amount: cartState.cart.price?.netPrice,
        ),
        ...?cartState.cart.price?.calculatedTaxes
            ?.map(
              (item) => _buildRow(
                context,
                label: '+ VAT (${item.taxRate?.toInt()} %)',
                amount: item.tax,
              ),
            )
            .toList(),
        if (cartState.cart.deliveries?.isNotEmpty ?? false)
          _buildRow(
            context,
            label: 'Shipping',
            amount: cartState.cart.deliveries![0].shippingCosts?.totalPrice,
          ),
        const Divider(
          color: AppColors.primaryColor,
          thickness: 2,
        ),
        gapH20,
        _buildRow(
          context,
          label: 'Total price',
          amount: cartState.cart.price?.totalPrice,
        ),
      ],
    );
  }
}
