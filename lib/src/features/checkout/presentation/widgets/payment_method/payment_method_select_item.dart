import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/radio_button_icon/radio_button_icon.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/features/global/data/global_data_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopware6_client/shopware6_client.dart';

class PaymentMethodSelectItem extends ConsumerWidget {
  final PaymentMethod paymentMethod;
  final bool selected;

  const PaymentMethodSelectItem({
    super.key,
    required this.paymentMethod,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: selected
          ? null
          : () {
              ref
                  .read(globalDataNotifierProvider.notifier)
                  .updateContext(ContextPatchRequest(
                    paymentMethodId: paymentMethod.id,
                  ));
            },
      child: Container(
        color: selected ? AppColors.greyLightAccent : Colors.transparent,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.p8,
          vertical: AppSizes.p16 * 0.75,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FwRadioButtonIcon(
              selected: selected,
            ),
            gapW24,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gapH4,
                  Text(paymentMethod.name),
                  gapH4,
                  Text(paymentMethod.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
