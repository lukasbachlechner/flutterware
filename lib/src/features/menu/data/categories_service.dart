import 'package:shopware6_client/shopware6_client.dart';

class CategoriesService {
  const CategoriesService();

  static List<Category> sortCategories(List<Category> unsorted) {
    final sorted = <Category>[];

    if (unsorted.isEmpty) {
      return unsorted;
    }

    try {
      final first = unsorted.firstWhere(
        (element) => element.afterCategoryId == null,
      );

      sorted.add(first);

      for (var i = 0; i < unsorted.length - 1; i++) {
        sorted.add(unsorted.firstWhere(
          (element) => element.afterCategoryId == sorted[i].id,
        ));
      }

      return sorted;
    } catch (e) {
      return unsorted;
    }
  }

  static List<Category> getRootCategories({
    required List<Category> categories,
    required ID navigationCategoryId,
  }) {
    final rootCategories = categories
        .where(
          (category) => category.parentId == navigationCategoryId,
        )
        .toList();

    return sortCategories(rootCategories);
  }

  static List<Category> getChildCategories({
    required List<Category> categories,
    required ID parentId,
  }) {
    final children = categories
        .where(
          (category) => category.parentId == parentId,
        )
        .toList();

    return sortCategories(children);
  }

  static Category? getCategoryById({
    required List<Category> categories,
    required ID categoryId,
  }) {
    try {
      final category =
          categories.firstWhere((category) => category.id == categoryId);
      return category;
    } catch (e) {
      return null;
    }
  }
}
