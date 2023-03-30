// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutterware/src/features/products/data/products_view/products_view_filter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopware6_client/shopware6_client.dart';

import 'package:flutterware/src/features/search/data/search_repository.dart';

import '../products_repository.dart';
import 'products_view_state.dart';

export 'products_view_state.dart';

part 'products_view_controller.g.dart';

class InvalidProductsViewTypeException implements Exception {
  final String message = 'Wrong ProductViewType was passed.';
}

enum ProductsViewType {
  byCategoryId,
  search,
}

@Riverpod(keepAlive: false)
class ProductsViewNotifier extends _$ProductsViewNotifier {
  late final ProductsViewType _type;
  late final dynamic _staticPayload;

  @override
  FutureOr<ProductsViewState> build(
    ProductsViewType type,
    dynamic staticPayload,
  ) async {
    _type = type;

    switch (_type) {
      case ProductsViewType.byCategoryId:
        _staticPayload = staticPayload as ID;
        break;
      case ProductsViewType.search:
        _staticPayload = staticPayload as String;
        break;
      default:
        break;
    }

    final firstState = await fetchProducts();

    return firstState;
  }

  Future<ProductsViewState> fetchProducts() async {
    // Initialize the new state. If it doesn't get mutated, the default one will be returned.
    ProductsViewState newState = ProductsViewState.initial(type: _type);

    // Copy the current state
    final previousState = state.value?.copy();

    if (previousState != null && previousState.isFirst) {
      // Make sure to always show a loading state for the first load
      state = const AsyncLoading();
    }

    try {
      final productsResponse = await getRequest();

      if (productsResponse.body != null) {
        final responseBody = productsResponse.body!;

        final totalItems = responseBody.total;
        final maxPerPage = responseBody.limit!;
        final currentPage = responseBody.page!;
        final currentPageCount = responseBody.elements.length;

        final hasMore =
            maxPerPage * (currentPage - 1) + currentPageCount < totalItems!;

        // Either copy the old or initial state with new values
        newState = (previousState ?? newState).copyWith(
          totalCount: totalItems,
          records: [...?previousState?.records, ...responseBody.elements],
          previousPageKeys: {
            ...?previousState?.previousPageKeys,
            responseBody.page ?? 1,
          }.toList(),
          nextPageKey: hasMore ? (responseBody.page ?? 1) + 1 : null,
        );

        ref.read(productsViewFilterProvider.notifier).setResponseData(
              sorting: responseBody.sorting,
              availableSortings: responseBody.availableSortings,
              aggregations: responseBody.listingAggregations,
            );
      }
    } catch (e, st) {
      print(e);
      print(st);
    }

    // Return the modified state
    return newState;
  }

  ProductsViewResponse getRequest() {
    if (_type == ProductsViewType.byCategoryId) {
      return getByCategoryId(_staticPayload);
    } else if (_type == ProductsViewType.search) {
      return getBySearch(_staticPayload);
    } else {
      throw InvalidProductsViewTypeException();
    }
  }

  ProductsViewResponse getByCategoryId(ID categoryId) {
    return ref.read(productsRepositoryProvider).byCategoryId(
          categoryId,
          state.value?.criteriaInput ?? const ProductListingCriteriaInput(),
        );
  }

  ProductsViewResponse getBySearch(String search) {
    return ref.read(searchRepositoryProvider).search(
          search,
          state.value?.criteriaInput ?? const ProductListingCriteriaInput(),
        );
  }

  void filter() async {
    final input = ref.read(productsViewFilterProvider.notifier).criteriaInput;

    if (state.value?.criteriaInput != input) {
      // Initialize a fresh state with the new input
      state = AsyncData(
        ProductsViewState.initial(
          type: _type,
          criteriaInput: input,
        ),
      );

      // Fetch products & update state
      state = AsyncData(await fetchProducts());
    }
  }

  void reset() async {
    state = AsyncData(
      ProductsViewState.initial(
        type: _type,
      ),
    );

    // Fetch products & update state
    state = AsyncData(await fetchProducts());
  }
}

enum ProductViewMode { list, grid }

final productViewModeProvider =
    StateProvider<ProductViewMode>((ref) => ProductViewMode.list);
