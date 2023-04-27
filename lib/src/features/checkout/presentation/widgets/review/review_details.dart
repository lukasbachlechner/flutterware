import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/async_value_widget/async_value_widget.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/features/global/data/global_data_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../../../common_widgets/heading/heading.dart';
import '../../../../../constants/app_sizes.dart';

class ReviewDetails extends ConsumerWidget {
  const ReviewDetails({super.key});

  Widget _buildItem(
    BuildContext context, {
    required String title,
    required Widget body,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Heading(
          title,
          level: HeadingLevel.h5,
        ),
        gapH16,
        body,
        gapH8,
        const Divider(
          color: AppColors.white,
        ),
        gapH16,
      ],
    );
  }

  String _buildCustomerAddress(Customer customer) {
    final lines = <String>[];
    final address = customer.defaultBillingAddress!;

    lines.add("${customer.firstName} ${customer.lastName}");
    lines.add(customer.email);
    lines.add(address.street);
    lines.add("${address.zipcode} ${address.city}");
    lines.add(address.country?.name ?? '');

    return lines.join('\n');
  }

  String _buildShippingAddress(Address address) {
    final lines = <String>[];

    lines.add(address.street);
    lines.add("${address.zipcode} ${address.city}");
    lines.add(address.country?.name ?? '');

    return lines.join('\n');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(globalDataNotifierProvider),
      data: (GlobalData globalData) {
        final customer = globalData.customer!;

        return Container(
          color: AppColors.greyLightAccent,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.p16,
            vertical: AppSizes.p24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Heading(
                'Order Details',
                level: HeadingLevel.h3,
              ),
              gapH40,
              _buildItem(
                context,
                title: "Personal details",
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_buildCustomerAddress(customer)),
                  ],
                ),
              ),
              _buildItem(
                context,
                title: "Shipping details",
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      globalData.currentContext.shippingMethod.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _buildShippingAddress(
                        customer.defaultShippingAddress!,
                      ),
                    ),
                  ],
                ),
              ),
              _buildItem(
                context,
                title: "Billing address",
                body: const Text("Same as shipping address"),
              ),
              _buildItem(
                context,
                title: "Payment method",
                body: Text(globalData.currentContext.paymentMethod.name),
              ),
            ],
          ),
        );
      },
    );
  }
}
