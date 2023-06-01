import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/features/products/data/products_view/products_view_filter.dart';

import '../../../../../utils/factories/product_sorting_factory.dart';
import '../../../../../utils/id_generator.dart';

void main() {
  group('ProductsViewFilterState', () {
    test('initializes correctly', () {
      const state = ProductsViewFilterState();

      expect(state.sorting, equals('name-asc'));
      expect(state.availableSortings, equals([]));
      expect(state.aggregations, isNull);
      expect(state.optionIds, isA<Set>());
      expect(state.optionIds.length, equals(0));
    });

    test('labelForSorting returns correct string', () {
      const label = 'test-label';
      const currentSortingKey = 'current-sorting-key';
      final state = ProductsViewFilterState(
        sorting: currentSortingKey,
        availableSortings: [
          createProductSorting(
            key: currentSortingKey,
            priority: 1,
            label: label,
          ),
        ],
      );

      expect(state.labelForSorting, equals(label));
    });

    test('labelForSorting returns empty string if not found', () {
      const state = ProductsViewFilterState();

      expect(state.labelForSorting, equals(''));
    });

    test('labelForOptionGroup returns empty string if not found', () {
      const state = ProductsViewFilterState();

      expect(state.labelForOptionGroup(IDGenerator.generate()), equals(''));
    });

    test('transformToString works correctly', () {
      final input = ['foo', 'bar'];
      const state = ProductsViewFilterState();

      expect(state.transformToString(input), equals('foo|bar'));
    });
  });
}
