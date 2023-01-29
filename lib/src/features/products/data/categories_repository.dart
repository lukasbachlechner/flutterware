import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../api/shopware_client.dart';

part 'categories_repository.g.dart';

class CategoriesRepository {
  final ShopwareClient client;

  const CategoriesRepository(this.client);

  Future<Response<CategoryCriteriaResponse>> getAll() {
    return client.categories.getCategories();
  }

  Future<Response<Category>> get(ID id) {
    return client.categories.getCategory(id);
  }

  Future<Response<List<Category>>> getNavigationMenu(
    NavigationId requestActiveId,
    NavigationId requestRootId,
  ) {
    return client.categories.getNavigationMenu(
      requestActiveId,
      requestRootId,
    );
  }
}

@Riverpod(keepAlive: true)
CategoriesRepository categoriesRepository(CategoriesRepositoryRef ref) {
  final client = ref.watch(shopwareClientProvider);
  return CategoriesRepository(client);
}

@Riverpod(keepAlive: true)
Future<Response<CategoryCriteriaResponse>> getAllCategoriesFuture(
    GetAllCategoriesFutureRef ref) {
  final categoriesRepository = ref.watch(categoriesRepositoryProvider);
  return categoriesRepository.getAll();
}

@Riverpod(keepAlive: true)
Future<Response<Category>> getSingleCategoryFuture(
  GetSingleCategoryFutureRef ref,
  ID id,
) {
  final categoriesRepository = ref.watch(categoriesRepositoryProvider);
  return categoriesRepository.get(id);
}

@Riverpod(keepAlive: true)
Future<Response<List<Category>>> getNavigationMenuFuture(
  GetNavigationMenuFutureRef ref, {
  NavigationId requestActiveId = const NavigationId.mainNavigation(),
  NavigationId requestRootId = const NavigationId.mainNavigation(),
}) {
  final categoriesRepository = ref.watch(categoriesRepositoryProvider);
  return categoriesRepository.getNavigationMenu(
    requestActiveId,
    requestRootId,
  );
}
