// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shopware6_client/shopware6_client.dart';

import 'products_view_controller.dart';

typedef ProductsViewRequestFunction = Future<Response<ProductCriteriaResponse>>
    Function(dynamic payload);
typedef ProductsViewResponse = Future<Response<ProductCriteriaResponse>>;

class ProductsViewState {
  final List<Product> records;
  final List<int> previousPageKeys;
  final int? nextPageKey;
  final bool isFirst;

  final int totalCount;
  final ProductsViewType type;
  final ProductListingCriteriaInput criteriaInput;

  const ProductsViewState._({
    this.records = const [],
    this.previousPageKeys = const [],
    this.nextPageKey,
    this.criteriaInput = const ProductListingCriteriaInput(),
    this.totalCount = 0,
    required this.type,
    this.isFirst = false,
  });

  factory ProductsViewState.initial({
    required ProductsViewType type,
    List<Product> records = const [],
    List<int> previousPageKeys = const [],
    int? nextPageKey,
    ProductListingCriteriaInput criteriaInput =
        const ProductListingCriteriaInput(),
    int totalCount = 0,
  }) {
    return ProductsViewState._(
      type: type,
      records: records,
      previousPageKeys: previousPageKeys,
      nextPageKey: nextPageKey,
      criteriaInput: criteriaInput,
      totalCount: totalCount,
      isFirst: true,
    );
  }

  ProductsViewState copyWith({
    List<Product>? records,
    List<int>? previousPageKeys,
    int? nextPageKey,
    int? totalCount,
    ProductsViewType? type,
    ProductListingCriteriaInput? criteriaInput,
  }) {
    return ProductsViewState._(
      records: records ?? this.records,
      previousPageKeys: previousPageKeys ?? this.previousPageKeys,
      nextPageKey: nextPageKey ?? this.nextPageKey,
      totalCount: totalCount ?? this.totalCount,
      type: type ?? this.type,
      criteriaInput: criteriaInput ?? this.criteriaInput,
      isFirst: false,
    );
  }

  ProductsViewState copy() {
    return ProductsViewState._(
      records: records,
      previousPageKeys: previousPageKeys,
      nextPageKey: nextPageKey,
      totalCount: totalCount,
      type: type,
      criteriaInput: criteriaInput,
      isFirst: isFirst,
    );
  }
}
