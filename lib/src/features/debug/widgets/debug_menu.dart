import 'package:flutter/material.dart';
import 'package:flutterware/src/api/shopware_client.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/features/authentication/presentation/widgets/logout_button.dart';
import 'package:flutterware/src/features/debug/widgets/debug_menu_item.dart';
import 'package:flutterware/src/features/debug/widgets/debug_menu_section.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common_widgets/button/button.dart';
import '../../global/data/global_data_notifier.dart';

class DebugMenu extends ConsumerWidget {
  const DebugMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalData = ref.watch(globalDataNotifierProvider).asData!.value;
    return Container(
      padding: const EdgeInsets.all(AppSizes.p16),
      color: AppColors.greyLightAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Debug info',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          gapH32,
          DebugMenuSection(title: 'API', children: [
            DebugMenuItem(
              title: 'Context token',
              value: ref.read(shopwareClientProvider).swContextToken ??
                  '<not set>',
            ),
            /* DebugMenuItem(
              title: 'Context token box',
              value: Hive.box(LocalStorageRepository.defaultBoxName)
                  .get(LocalStorageRepository.contextTokenKey),
            ), */
          ]),
          gapH32,
          DebugMenuSection(title: 'Context', children: [
            DebugMenuItem(
              title: 'Currency',
              value: globalData.currentContext.currency.isoCode.toString(),
            ),
            DebugMenuItem(
              title: 'Currency ID',
              value: globalData.currentContext.currency.id.toString(),
            ),
            DebugMenuItem(
              title: 'Country',
              value: globalData.currentCountry().name.toString(),
            ),
            DebugMenuItem(
              title: 'Country ID',
              value:
                  globalData.currentContext.salesChannel.countryId.toString(),
            ),
            DebugMenuItem(
              title: 'Language',
              value: globalData.currentLanguage().name.toString(),
            ),
            DebugMenuItem(
              title: 'Language ID',
              value:
                  globalData.currentContext.salesChannel.languageId.toString(),
            ),
          ]),
          DebugMenuSection(title: 'Customer', children: [
            DebugMenuItem(
              title: 'Context has customer',
              value: (globalData.currentContext.customer != null).toString(),
            ),
            if (globalData.isCustomerLoggedIn) ...[
              DebugMenuItem(
                title: 'ID',
                value: globalData.customer!.id?.toString() ?? '-',
              ),
              DebugMenuItem(
                title: 'Customer number',
                value: globalData.customer!.customerNumber.toString(),
              ),
              DebugMenuItem(
                title: 'Email',
                value: globalData.customer!.email,
              ),
              DebugMenuItem(
                title: 'First name',
                value: globalData.customer!.firstName,
              ),
              DebugMenuItem(
                title: 'Last name',
                value: globalData.customer!.lastName,
              ),
              DebugMenuItem(
                title: 'Active',
                value: globalData.customer!.active.toString(),
              ),
              DebugMenuItem(
                title: 'Created at',
                value: globalData.customer!.createdAt.toString(),
              ),
              DebugMenuItem(
                title: 'First login',
                value: globalData.customer!.firstLogin.toString(),
              ),
              DebugMenuItem(
                title: 'Last login',
                value: globalData.customer!.lastLogin.toString(),
              ),
            ],
          ]),
          gapH32,
          DebugMenuSection(title: 'Actions', children: [
            Button(
              label: 'Refresh global',
              onPressed: () => ref.refresh(globalDataNotifierProvider),
            ),
            const LogoutButton()
          ]),
        ],
      ),
    );
  }
}
