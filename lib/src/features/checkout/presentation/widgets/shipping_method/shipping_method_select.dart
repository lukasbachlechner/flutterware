import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/async_value_widget/async_value_widget.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../global/data/global_data_notifier.dart';
import 'shipping_method_select_item.dart';

class ShippingMethodSelect extends HookConsumerWidget {
  const ShippingMethodSelect({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(globalDataNotifierProvider),
      data: (GlobalData data) {
        final shippingMethods = data.shippingMethods;
        shippingMethods.sort((a, b) => a.position.compareTo(b.position));

        return ListView.separated(
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            return ShippingMethodSelectItem(
              shippingMethod: shippingMethods[index],
              selected: data.isCurrentShippingMethod(shippingMethods[index]),
            );
          },
          itemCount: shippingMethods.length,
          separatorBuilder: (_, __) => gapH16,
        );
      },
    );
  }
}
