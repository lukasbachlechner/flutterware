import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/async_value_widget/async_value_widget.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/features/checkout/presentation/widgets/payment_method/payment_method_select_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../global/data/global_data_notifier.dart';

class PaymentMethodSelect extends HookConsumerWidget {
  const PaymentMethodSelect({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(globalDataNotifierProvider),
      data: (GlobalData data) {
        final paymentMethods = data.paymentMethods;
        paymentMethods.sort((a, b) => a.position.compareTo(b.position));

        return ListView.separated(
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            return PaymentMethodSelectItem(
              paymentMethod: paymentMethods[index],
              selected: data.isCurrentPaymentMethod(paymentMethods[index]),
            );
          },
          itemCount: paymentMethods.length,
          separatorBuilder: (_, __) => gapH16,
        );
      },
    );
  }
}
