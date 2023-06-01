import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/features/products/data/products_view/products_view_controller.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../../../utils/factories/product_factory.dart';
import '../../../../../utils/id_generator.dart';

void main() {
  group('ProductsViewState', () {
    test('initial returns a new instance', () {
      final state = ProductsViewState.initial(
        type: ProductsViewType.byCategoryId,
      );

      expect(state, isNotNull);
      expect(state, isA<ProductsViewState>());
    });

    test('initial isFirst is always true', () {
      final state = ProductsViewState.initial(
        type: ProductsViewType.byCategoryId,
      );

      expect(state.isFirst, isTrue);
    });

    test('copy returns a new instance', () {
      final state = ProductsViewState.initial(
        type: ProductsViewType.byCategoryId,
      );

      final copiedState = state.copy();

      expect(copiedState, isNotNull);
      expect(copiedState, isA<ProductsViewState>());
      expect(copiedState, isNot(state));
    });

    test('copy returns an exact copy', () {
      const criteriaInput = ProductListingCriteriaInput(
        limit: 10,
      );

      final productId = IDGenerator.generate();

      final state = ProductsViewState.initial(
        type: ProductsViewType.byCategoryId,
        criteriaInput: criteriaInput,
        nextPageKey: 42,
        previousPageKeys: [1, 2, 3],
        totalCount: 147,
        records: [
          createProduct(
            id: productId,
          ),
        ],
      );

      final copiedState = state.copy();

      expect(copiedState.type, equals(ProductsViewType.byCategoryId));
      expect(copiedState.criteriaInput, equals(criteriaInput));
      expect(copiedState.nextPageKey, equals(42));
      expect(copiedState.previousPageKeys, equals([1, 2, 3]));
      expect(copiedState.totalCount, equals(147));
      expect(copiedState.records, hasLength(1));
      expect(copiedState.records.first.id, equals(productId));
      expect(copiedState.isFirst, isTrue);
    });

    test('copyWith returns an exact copy', () {
      const criteriaInput = ProductListingCriteriaInput(
        limit: 10,
      );

      final productId = IDGenerator.generate();

      final state = ProductsViewState.initial(
        type: ProductsViewType.byCategoryId,
        criteriaInput: criteriaInput,
        nextPageKey: 42,
        previousPageKeys: [1, 2, 3],
        totalCount: 147,
        records: [
          createProduct(
            id: productId,
          ),
        ],
      );

      final copiedState = state.copyWith();

      expect(copiedState.type, equals(ProductsViewType.byCategoryId));
      expect(copiedState.criteriaInput, equals(criteriaInput));
      expect(copiedState.nextPageKey, equals(42));
      expect(copiedState.previousPageKeys, equals([1, 2, 3]));
      expect(copiedState.totalCount, equals(147));
      expect(copiedState.records, hasLength(1));
      expect(copiedState.records.first.id, equals(productId));
      expect(copiedState.isFirst, isFalse);
    });

    test('copyWith overrides values', () {
      const criteriaInput = ProductListingCriteriaInput(
        limit: 10,
      );

      const newCriteriaInput = ProductListingCriteriaInput(
        limit: 10,
      );

      final productId = IDGenerator.generate();

      final state = ProductsViewState.initial(
        type: ProductsViewType.byCategoryId,
        criteriaInput: criteriaInput,
        nextPageKey: 42,
        previousPageKeys: [1, 2, 3],
        totalCount: 147,
        records: [
          createProduct(
            id: productId,
          ),
        ],
      );

      final copiedState = state.copyWith(
        type: ProductsViewType.search,
        criteriaInput: newCriteriaInput,
        nextPageKey: 24,
        previousPageKeys: [1, 2, 3, 4],
        totalCount: 158,
        records: [
          createProduct(),
          createProduct(
            id: productId,
          ),
        ],
      );

      expect(copiedState.type, equals(ProductsViewType.search));
      expect(copiedState.criteriaInput, equals(newCriteriaInput));
      expect(copiedState.nextPageKey, equals(24));
      expect(copiedState.previousPageKeys, equals([1, 2, 3, 4]));
      expect(copiedState.totalCount, equals(158));
      expect(copiedState.records, hasLength(2));
      expect(copiedState.records.first.id, isNot(productId));
    });
  });
}
