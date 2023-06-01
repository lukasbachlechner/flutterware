// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopware6_client/shopware6_client.dart';

class ProductsViewFilterState {
  // State values
  final String sorting;
  final Set<ID> optionIds;

  // Read-only data
  final List<ProductSorting> availableSortings;
  final ListingAggregations? aggregations;

  const ProductsViewFilterState({
    this.sorting = 'name-asc',
    this.availableSortings = const [],
    this.aggregations,
    this.optionIds = const {},
  });

  String get labelForSorting {
    try {
      return availableSortings
              .firstWhere((element) => element.key == sorting)
              .label ??
          '';
    } catch (e) {
      return '';
    }
  }

  String labelForOptionGroup(ID groupId) {
    try {
      final group = aggregations?.properties?.entities?.firstWhere(
        (group) => group.id == groupId,
      );

      if (group == null) {
        throw Exception();
      }

      final selectedOptionNames = group.sortedOptions
          .where((option) => optionIds.contains(option.id))
          .toList();

      return selectedOptionNames.map((option) => option.name).join(', ');
    } catch (e) {
      return '';
    }
  }

  String transformToString(Iterable iterable) {
    return iterable.join('|');
  }

  ProductsViewFilterState copyWith({
    String? sorting,
    Set<ID>? optionIds,
    List<ProductSorting>? availableSortings,
    ListingAggregations? aggregations,
  }) {
    return ProductsViewFilterState(
      sorting: sorting ?? this.sorting,
      optionIds: optionIds ?? this.optionIds,
      availableSortings: availableSortings ?? this.availableSortings,
      aggregations: aggregations ?? this.aggregations,
    );
  }
}

class ProductsViewFilter extends StateNotifier<ProductsViewFilterState> {
  ProductsViewFilter() : super(const ProductsViewFilterState());

  void setSorting(ProductSorting sorting) {
    state = state.copyWith(sorting: sorting.key);
  }

  void toggleOption(PropertyGroupOption option) {
    Set<ID> currentOptions = state.optionIds.toSet();

    if (currentOptions.contains(option.id)) {
      currentOptions.remove(option.id);
    } else {
      currentOptions.add(option.id!);
    }

    state = state.copyWith(
      optionIds: currentOptions,
    );
  }

  void setResponseData({
    String? sorting,
    List<ProductSorting>? availableSortings,
    ListingAggregations? aggregations,
  }) {
    state = state.copyWith(
      availableSortings: availableSortings,
      aggregations: aggregations,
    );
  }

  ProductListingCriteriaInput get criteriaInput {
    return ProductListingCriteriaInput(
      order: state.sorting,
      properties: state.transformToString(state.optionIds),
    );
  }
}

final productsViewFilterProvider =
    StateNotifierProvider<ProductsViewFilter, ProductsViewFilterState>((ref) {
  return ProductsViewFilter();
});
