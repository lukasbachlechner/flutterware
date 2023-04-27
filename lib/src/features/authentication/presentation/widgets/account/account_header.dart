import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../constants/app_sizes.dart';
import '../../../../global/data/global_data_notifier.dart';

class AccountHeader extends ConsumerWidget {
  const AccountHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customer =
        ref.watch(globalDataNotifierProvider).asData!.value.customer;
    if (customer == null) {
      return const SizedBox.shrink();
    }

    String getInitials() {
      final firstName = customer.firstName;
      final lastName = customer.lastName;
      if (firstName.isNotEmpty && lastName.isNotEmpty) {
        return '${firstName[0]}${lastName[0]}';
      } else if (firstName.isNotEmpty) {
        return firstName[0];
      } else if (lastName.isNotEmpty) {
        return lastName[0];
      } else {
        return '';
      }
    }

    return Container(
      color: AppColors.greyLightAccent,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.p32,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: AppSizes.fabSize / 2,
            backgroundColor: AppColors.blackPrimary,
            child: Text(
              getInitials(),
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: AppColors.white),
            ),
          ),
          gapH16,
          Text(
            '${customer.firstName} ${customer.lastName}',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          gapH8,
          Text(
            customer.email,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
