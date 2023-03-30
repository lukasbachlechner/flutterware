import 'package:flutter/material.dart';
import 'package:flutterware/src/api/shopware_client.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/features/debug/widgets/debug_menu_item.dart';
import 'package:flutterware/src/features/debug/widgets/debug_menu_section.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common_widgets/button/button.dart';
import '../../global/data/global_data_notifier.dart';

class DebugMenu extends ConsumerWidget {
  const DebugMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              value: ref
                      .read(globalDataNotifierProvider)
                      .asData
                      ?.value
                      .currentContext
                      .currency
                      .isoCode
                      .toString() ??
                  '',
            ),
            DebugMenuItem(
              title: 'Country',
              value: ref
                      .read(globalDataNotifierProvider)
                      .asData
                      ?.value
                      .currentContext
                      .toString() ??
                  '',
            ),
            DebugMenuItem(
              title: 'Country ID',
              value: ref
                      .read(globalDataNotifierProvider)
                      .asData
                      ?.value
                      .currentContext
                      .salesChannel
                      .countryId
                      .toString() ??
                  '',
            ),
            DebugMenuItem(
              title: 'Language ID',
              value: ref
                      .read(globalDataNotifierProvider)
                      .asData
                      ?.value
                      .currentContext
                      .salesChannel
                      .languageId
                      .toString() ??
                  '',
            ),
          ]),
          gapH32,
          DebugMenuSection(title: 'Actions', children: [
            Button(
              label: 'Refresh global',
              onPressed: () => ref.refresh(globalDataNotifierProvider),
            ),
          ]),
        ],
      ),
    );
  }
}
