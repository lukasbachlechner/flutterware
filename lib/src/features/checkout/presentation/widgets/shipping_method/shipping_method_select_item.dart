import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/radio_button_icon/radio_button_icon.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/features/global/data/global_data_notifier.dart';
import 'package:flutterware/src/utils/currency.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopware6_client/shopware6_client.dart';

class ShippingMethodSelectItem extends ConsumerWidget {
  final ShippingMethod shippingMethod;
  final bool selected;
  const ShippingMethodSelectItem({
    super.key,
    required this.shippingMethod,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formattedPrice = formatCurrency(
        shippingMethod.prices?.first.currencyPrice.first.gross ?? 0);

    return InkWell(
      onTap: selected
          ? null
          : () {
              ref
                  .read(globalDataNotifierProvider.notifier)
                  .updateContext(ContextPatchRequest(
                    shippingMethodId: shippingMethod.id,
                  ));
            },
      child: Container(
        color: selected ? AppColors.greyLightAccent : Colors.transparent,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.p8,
          vertical: AppSizes.p16 * 0.75,
        ),
        child: Row(children: [
          FwRadioButtonIcon(
            selected: selected,
          ),
          gapW24,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                gapH4,
                Text(shippingMethod.name),
                gapH4,
                Text(shippingMethod.deliveryTime.name),
                if (shippingMethod.description != null)
                  Text(shippingMethod.description!),
              ],
            ),
          ),
          Text(
            formattedPrice,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontSize: 18.0,
                ),
          ),
        ]),
      ),
    );
  }
}
