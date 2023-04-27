import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/heading/heading.dart';
import 'package:flutterware/src/common_widgets/image/image.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/utils/currency.dart';
import 'package:shopware6_client/shopware6_client.dart';

class ReviewProductsTableItem extends StatelessWidget {
  final LineItem lineItem;

  const ReviewProductsTableItem({
    super.key,
    required this.lineItem,
  });

  Widget _buildOptions() {
    if (lineItem.payload != null) {
      final lineItemProduct = lineItem.payload as LineItemProduct;
      if (lineItemProduct.options != null) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSizes.p4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...lineItemProduct.options!.map(
                (option) => Text("${option.group}: ${option.option}"),
              ),
              Text("Quantity: ${lineItem.quantity}"),
            ],
          ),
        );
      }
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.p8,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.greyLightAccent,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FwImage(
            src: lineItem.cover?.url ?? '',
            width: AppSizes.p80,
          ),
          gapW20,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Heading(lineItem.label ?? '', level: HeadingLevel.h5),
                _buildOptions(),
              ],
            ),
          ),
          gapW20,
          Heading(
            formatCurrency(lineItem.price?.totalPrice ?? 0.0),
            level: HeadingLevel.h5,
          ),
        ],
      ),
    );
  }
}
