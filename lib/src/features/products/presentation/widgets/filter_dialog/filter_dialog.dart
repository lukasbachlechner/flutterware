import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/accordion/accordion.dart';
import 'package:flutterware/src/common_widgets/button/button.dart';
import 'package:flutterware/src/common_widgets/list_tile/list_tile.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/constants/flutterware_icons.dart';
import 'package:flutterware/src/features/products/data/products_view/products_view_filter.dart';
import 'package:flutterware/src/features/products/presentation/widgets/filter_dialog/filter_dialog_header.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../../../common_widgets/circle_icon/circle_icon.dart';
import '../../../data/products_view/products_view_controller.dart';

class FilterDialogOption extends StatelessWidget {
  final String title;
  final Widget? leading;
  final bool isSelected;
  final VoidCallback? onTap;

  const FilterDialogOption({
    super.key,
    required this.title,
    this.leading,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FwListTile(
      onTap: onTap,
      textColor: isSelected ? AppColors.primaryColor : null,
      padding: const EdgeInsets.only(
        top: AppSizes.p16,
        bottom: AppSizes.p16,
        left: AppSizes.p24,
        right: AppSizes.p20,
      ),
      leading: leading,
      title: title,
      trailing: isSelected
          ? const CircleIcon(
              FlutterwareIcons.checked,
            )
          : CircleIcon.placeholder(),
    );
  }
}

class FilterDialogPropertyGroupOption extends ConsumerWidget {
  final PropertyGroupOption propertyGroupOption;
  final ProductsViewFilterState filterState;

  const FilterDialogPropertyGroupOption({
    super.key,
    required this.propertyGroupOption,
    required this.filterState,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilterDialogOption(
      isSelected: filterState.optionIds.contains(propertyGroupOption.id),
      title: propertyGroupOption.name,
      onTap: () => ref
          .read(productsViewFilterProvider.notifier)
          .toggleOption(propertyGroupOption),
    );
  }
}

class FilterDialog extends HookConsumerWidget {
  final ProductsViewState providerState;
  final ProductsViewNotifier providerNotifier;

  const FilterDialog({
    super.key,
    required this.providerState,
    required this.providerNotifier,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(productsViewFilterProvider);
    return Column(
      children: [
        const FilterDialogHeader(),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Accordion(
                items: [
                  AccordionItem(
                    withPadding: false,
                    body: Column(
                      children: [
                        ...filterState.availableSortings.map(
                          (e) => FilterDialogOption(
                            title: e.label ?? '',
                            isSelected: filterState.sorting == e.key,
                            onTap: () {
                              ref
                                  .read(productsViewFilterProvider.notifier)
                                  .setSorting(e);
                            },
                          ),
                        ),
                      ],
                    ),
                    title: 'Sort by',
                    trailingText: filterState.labelForSorting,
                  ),
                  ...?filterState.aggregations?.properties?.entities
                      ?.map((propertyGroup) {
                    return AccordionItem(
                      withPadding: false,
                      body: Column(
                        children: propertyGroup.sortedOptions
                            .map(
                              (propertyGroupOption) =>
                                  FilterDialogPropertyGroupOption(
                                propertyGroupOption: propertyGroupOption,
                                filterState: filterState,
                              ),
                            )
                            .toList(),
                      ),
                      title: propertyGroup.name,
                      trailingText: filterState.labelForOptionGroup(
                        propertyGroup.id!,
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.p16,
          ),
          child: Button(
            label: 'Done',
            buttonSize: ButtonSize.fullWidth,
            buttonType: ButtonType.primaryColor,
            onPressed: () {
              providerNotifier.filter();
              FilterDialog.close(context);
            },
          ),
        ),
        gapH16,
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.p16,
          ),
          child: Button(
            label: 'Cancel',
            buttonSize: ButtonSize.fullWidth,
            buttonType: ButtonType.secondary,
            onPressed: () => FilterDialog.close(context),
          ),
        )
      ],
    );
  }

  static Future<void> show(
    BuildContext context,
    ProductsViewState providerState,
    ProductsViewNotifier providerNotifier,
  ) {
    return showDialog(
      barrierColor: AppColors.white,
      useRootNavigator: true,
      context: context,
      builder: (context) => FilterDialog(
        providerState: providerState,
        providerNotifier: providerNotifier,
      ),
    );
  }

  static void close(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
