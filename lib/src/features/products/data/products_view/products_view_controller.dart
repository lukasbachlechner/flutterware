import 'dart:async';

import 'package:flutterware/src/features/products/data/products_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopware6_client/shopware6_client.dart';

class PaginatedProductsState {
  final List<Product> products;
  final List<Filter> filters;
  final int page;
  final int limit;
  final int total;
  final bool hasMore;

  const PaginatedProductsState({
    required this.products,
    required this.filters,
    required this.page,
    required this.limit,
    required this.total,
    required this.hasMore,
  });

  const PaginatedProductsState.initial()
      : products = const <Product>[],
        filters = const <Filter>[],
        page = 1,
        limit = 24,
        total = 0,
        hasMore = true;

  PaginatedProductsState copyWith({
    List<Product>? products,
    List<Filter>? filters,
    int? page,
    int? limit,
    int? total,
    bool? hasMore,
  }) {
    return PaginatedProductsState(
      products: products ?? this.products,
      filters: filters ?? this.filters,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      total: total ?? this.total,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  String toString() {
    return 'PaginatedProductsState(products: $products, filters: $filters, page: $page, limit: $limit, total: $total)';
  }
}

class AsyncPaginatedProductsController
    extends AutoDisposeAsyncNotifier<PaginatedProductsState> {
  @override
  FutureOr<PaginatedProductsState> build() async {
    return _fetchProducts(const PaginatedProductsState.initial()).then((data) {
      return data.copyWith(page: data.page + 1);
    });
  }

  Future<PaginatedProductsState> _fetchProducts(
      PaginatedProductsState currentState) async {
    final productsResponse = await ref.read(productsRepositoryProvider).getAll(
          CriteriaInput(
            page: currentState.page,
            limit: currentState.limit,
            filter: [
              EqualsFilter(field: 'parentId', value: null),
              ...currentState.filters
            ],
            totalCountMode: 1,
          ),
        );

    final newState = currentState.copyWith(
      products: [...currentState.products, ...productsResponse.body!.elements],
      total: productsResponse.body!.total,
      hasMore: !!productsResponse.body!.elements.isNotEmpty,
    );
    return newState;
  }

  Future<void> nextPage() async {
    update((data) => _fetchProducts(data).then((data) {
          return data.copyWith(page: data.page + 1);
        }));
  }

  void checkIndex(int index) {
    state.whenData((currentState) {
      final isCurrentLast = (index + 1) == currentState.page;
      if (isCurrentLast && currentState.hasMore) {
        print('[index $index]: load next page! ');
        nextPage();
      }
    });
  }

  Future<void> resetAndAddFilter() async {
    update((data) {
      const modifiedState = PaginatedProductsState.initial();

      return _fetchProducts(modifiedState);
    });
  }
}

final asyncPaginatedProductsControllerProvider =
    AsyncNotifierProvider.autoDispose<AsyncPaginatedProductsController,
        PaginatedProductsState>(AsyncPaginatedProductsController.new);

enum ProductViewMode { list, grid }

final productViewModeProvider =
    StateProvider<ProductViewMode>((ref) => ProductViewMode.list);
