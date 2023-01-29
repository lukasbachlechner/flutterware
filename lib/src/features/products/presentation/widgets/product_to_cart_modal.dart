import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutterware/src/features/products/presentation/widgets/product_add_to_cart_button.dart';
import 'package:flutterware/src/features/products/presentation/widgets/product_quantity_selector.dart';
import 'package:flutterware/src/features/products/presentation/widgets/product_variant_select_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../../common_widgets/modal_bottom_sheet/modal_bottom_sheet_heading.dart';
import '../../../../constants/app_sizes.dart';

class ProductToCartModal extends HookConsumerWidget {
  final ID productId;
  final List<Product>? variants;
  final List<PropertyGroup>? configurator;

  const ProductToCartModal({
    super.key,
    required this.productId,
    this.variants,
    this.configurator,
  });

  List<Widget> buildConfigurator({
    required List<PropertyGroup> configurator,
    required ValueNotifier<Map<ID, ID?>> selectedOptionIds,
    required List<ID> availableOptionIds,
  }) {
    final widgetList = <Widget>[];

    for (var propertyGroup in configurator) {
      if (propertyGroup.options != null && propertyGroup.options!.isNotEmpty) {
        widgetList.add(FwBottomSheetHeading(propertyGroup.name));
        widgetList.addAll(
          buildConfiguratorGroup(
            propertyGroupOptions: propertyGroup.options!,
            selectedOptionIds: selectedOptionIds,
            availableOptionIds: availableOptionIds,
          ),
        );
        widgetList.add(gapH16);
      }
    }

    return widgetList;
  }

  List<Widget> buildConfiguratorGroup({
    required List<PropertyGroupOption> propertyGroupOptions,
    required ValueNotifier<Map<ID, ID?>> selectedOptionIds,
    required List<ID> availableOptionIds,
  }) {
    final optionWidgetList = <Widget>[];

    // Sort the options
    propertyGroupOptions.sort(
      (a, b) => (a.position ?? 1).compareTo(b.position ?? 1),
    );

    for (var option in propertyGroupOptions) {
      optionWidgetList.add(
        ProductVariantSelectItem(
          onPressed: () {
            final newIDMap = {
              ...selectedOptionIds.value,
            };

            if (newIDMap[option.groupId] == option.id) {
              newIDMap[option.groupId] = null;
            } else {
              newIDMap[option.groupId] = option.id;
            }

            selectedOptionIds.value = newIDMap;
          },
          isSelected: selectedOptionIds.value[option.groupId] == option.id!,
          isAvailable: availableOptionIds.contains(option.id),
          label: option.name,
        ),
      );
    }
    return optionWidgetList;
  }

  bool get hasVariants {
    return variants != null &&
        variants!.isNotEmpty &&
        configurator != null &&
        configurator!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = useState<ID?>(null);
    final selectedQuantity = useState<int>(1);
    final selectedOptionIds = useState<Map<ID, ID?>>({});
    final availableOptionIds = useState<List<ID>>([]);

    Map<ID, ID?> getInitialIDMap() {
      Map<ID, ID?> initialMap = {};

      for (var propertyGroup in configurator!) {
        initialMap[propertyGroup.id!] = null;
      }

      return initialMap;
    }

    Map<ID, List<ID>> getGroupedOptionIds() {
      Map<ID, List<ID>> initial = {};

      for (var group in configurator!) {
        List<ID> groupIds = [];

        if (group.options != null) {
          groupIds = group.options!.map((option) => option.id!).toList();
        }

        initial[group.id!] = groupIds;
      }

      return initial;
    }

    List<ID> getAllOptionIds() {
      List<ID> ids = [];
      for (var group in configurator!) {
        ids.addAll(group.options!.map((option) => option.id!).toList());
      }
      return ids;
    }

    void listenToSelectionChange() {
      // Only do something if it's not a simple product
      if (hasVariants) {
        // Get all values of our {<groupID>: <selectedGroupOption>} tuple
        final List<ID?> selectedOptionValues =
            selectedOptionIds.value.values.toList();

        // Count how many groups have a non-null option ID (= are selected)
        final int selectedGroupsCount =
            selectedOptionValues.where((element) => element != null).length;

        // If every value is null => reset the available options with all options
        if (selectedOptionValues.every((element) => element == null)) {
          availableOptionIds.value = getAllOptionIds();
        } else {
          // Get a Map with all options grouped
          final Map<ID, List<ID>> groupedOptionIds = getGroupedOptionIds();

          // A list to store all options that we want to search in the variants
          final mustContainOptionIds = <ID>[];

          // A list to keep an overview on which groups already have a value
          final alreadySelectedGroupIds = <ID>[];

          selectedOptionIds.value.forEach((key, value) {
            // Add everything to the corresponding lists
            if (value != null) {
              alreadySelectedGroupIds.add(key);
              mustContainOptionIds.add(value);
            }
          });

          // Get a list of option IDs which satisfy our current selecton
          List<ID> stillAvailableOptionIds = variants!
              .where(
                (variantProduct) =>
                    // Get all option IDs for a product
                    variantProduct.optionIds!
                        // which are in the "selected IDs" list
                        .where(
                          (optionId) => mustContainOptionIds.contains(optionId),
                        )
                        // And only return them if the count matches the number of currently selected groups
                        // This needs to be done in order to drill down the data
                        // Otherwise, we couldn't disable impossible variants
                        .length ==
                    selectedGroupsCount,
              )
              // Map everything to a flat list
              .map((variantProduct) => variantProduct.optionIds!)
              .expand((element) => element)
              .toList();

          // We have to add options for the groups back
          for (final ID groupId in alreadySelectedGroupIds) {
            // Get all available option IDs for the group
            final allOptionsForGroup = groupedOptionIds[groupId]!;

            // Filter out the IDs that really can't be applied
            final filteredOptionsForGroup = allOptionsForGroup
                .where((element) => availableOptionIds.value.contains(element))
                .toList();

            // Append them to the available options
            stillAvailableOptionIds.addAll(filteredOptionsForGroup);
          }

          // Set the state
          availableOptionIds.value = stillAvailableOptionIds;
        }

        // Try to find the matching product ID

        Product? foundProduct;

        for (var variantProduct in variants!) {
          // Search a variant that matches all selected IDs
          if (variantProduct.optionIds!
              .every((id) => selectedOptionValues.contains(id))) {
            foundProduct = variantProduct;
            break;
          } else {
            // Reset just to make sure
            foundProduct = null;
          }
        }

        // Set the state to the product ID
        selectedId.value = foundProduct?.id;
      }
    }

    useEffect(() {
      if (!hasVariants) {
        // Just set the selectedId to the product ID if it's not a variable product
        selectedId.value = productId;
      } else {
        // Prefill states
        availableOptionIds.value = getAllOptionIds();
        selectedOptionIds.value = getInitialIDMap();
      }

      // Listen to changes on the selection
      selectedOptionIds.addListener(listenToSelectionChange);
      return () => selectedOptionIds.removeListener(listenToSelectionChange);
    }, []);

    return Column(
      children: [
        if (hasVariants)
          ...buildConfigurator(
            configurator: configurator!,
            selectedOptionIds: selectedOptionIds,
            availableOptionIds: availableOptionIds.value,
          ),
        const FwBottomSheetHeading('Choose quantity'),
        gapH16,
        ProductQuantitySelector(
          onMinusPressed: () => selectedQuantity.value > 1
              ? selectedQuantity.value = selectedQuantity.value - 1
              : null,
          onPlusPressed: () =>
              selectedQuantity.value = selectedQuantity.value + 1,
          count: selectedQuantity.value,
        ),
        gapH24,
        ProductAddToCartButton(
          productId: selectedId.value,
          quantity: selectedQuantity.value,
        ),
      ],
    );
  }
}
