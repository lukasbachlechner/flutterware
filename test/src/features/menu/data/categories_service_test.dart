import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/features/menu/data/categories_service.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../../utils/factories/category_factory.dart';
import '../../../../utils/id_generator.dart';

void main() {
  group('CategoriesService', () {
    test('can sort an unsorted list of categories', () {
      final category1ID = IDGenerator.generate();
      final category2ID = IDGenerator.generate();
      final category3ID = IDGenerator.generate();

      final category1 = createCategory(
        id: category1ID,
        afterCategoryId: null,
        name: 'Category 1',
      );

      final category2 = createCategory(
        id: category2ID,
        afterCategoryId: category1ID,
        name: 'Category 2',
      );

      final category3 = createCategory(
        id: category3ID,
        afterCategoryId: category2ID,
        name: 'Category 3',
      );

      final unsorted = <Category>[
        category3,
        category1,
        category2,
      ];

      final expected = <Category>[
        category1,
        category2,
        category3,
      ];

      final sorted = CategoriesService.sortCategories(unsorted);

      expect(listEquals(unsorted, sorted), isFalse);
      expect(listEquals(sorted, expected), isTrue);
    });

    test('returns the original List if no afterCategoryId is null', () {
      final category1 = createCategory(afterCategoryId: IDGenerator.generate());
      final category2 = createCategory(afterCategoryId: IDGenerator.generate());

      final unsorted = [category2, category1];

      final sorted = CategoriesService.sortCategories(unsorted);

      expect(listEquals(unsorted, sorted), isTrue);

      expect(sorted[0], equals(category2));
      expect(sorted[1], equals(category1));
    });

    test('returns the original List if unrelated categories are passed', () {
      final firstCategoryId = IDGenerator.generate();
      final unrelatedCategoryId = IDGenerator.generate();
      final category1 = createCategory(
        id: firstCategoryId,
        afterCategoryId: null,
      );
      final category2 = createCategory(
        id: unrelatedCategoryId,
        afterCategoryId: IDGenerator.generate(),
      );

      final unsorted = [category2, category1];

      final sorted = CategoriesService.sortCategories(unsorted);

      expect(listEquals(unsorted, sorted), isTrue);

      expect(sorted[0], equals(category2));
      expect(sorted[1], equals(category1));
    });

    test('can get child categories for a given category', () {
      final parentCategoryId = IDGenerator.generate();
      final parentCategory = createCategory(
        id: parentCategoryId,
      );

      final childCategory1 = createCategory(
        parentId: parentCategoryId,
      );

      final childCategory2 = createCategory(
        parentId: parentCategoryId,
      );

      final unrelatedCategory = createCategory();

      final categories = [
        parentCategory,
        childCategory1,
        childCategory2,
        unrelatedCategory,
      ];

      final expected = [
        childCategory1,
        childCategory2,
      ];

      final children = CategoriesService.getChildCategories(
        categories: categories,
        parentId: parentCategoryId,
      );

      expect(listEquals(children, expected), isTrue);
    });

    test('can get a category by ID', () {
      final targetCategoryId = IDGenerator.generate();
      final targetCategory = createCategory(
        id: targetCategoryId,
      );

      final allCategories = [
        createCategory(),
        createCategory(),
        targetCategory,
        createCategory(),
      ];

      final category = CategoriesService.getCategoryById(
        categories: allCategories,
        categoryId: targetCategoryId,
      );

      expect(category, equals(targetCategory));
    });

    test('can get root categories by root id', () {
      final rootCategoryId = IDGenerator.generate();

      final rootCategory1 = createCategory(
        id: IDGenerator.generate(),
        parentId: rootCategoryId,
      );

      final rootCategory2 = createCategory(
        id: IDGenerator.generate(),
        parentId: rootCategoryId,
      );

      final childCategory = createCategory(
        id: IDGenerator.generate(),
        parentId: rootCategory1.id,
      );

      final categories = [
        rootCategory1,
        rootCategory2,
        childCategory,
      ];

      final expected = [
        rootCategory1,
        rootCategory2,
      ];

      final rootCategories = CategoriesService.getRootCategories(
        categories: categories,
        navigationCategoryId: rootCategoryId,
      );

      expect(listEquals(rootCategories, expected), isTrue);
    });
  });
}
