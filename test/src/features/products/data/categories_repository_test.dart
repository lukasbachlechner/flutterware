import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/api/shopware_client.dart';
import 'package:flutterware/src/features/products/data/categories_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../../utils/id_generator.dart';
import '../../../../utils/mock/mock_shopware_client.dart';

void main() {
  group('CategoriesRepository', () {
    test('initializes correctly', () {
      final repository = CategoriesRepository(getMockShopwareClient());

      expect(repository.client, isA<ShopwareClient>());
    });

    test('getAll', () async {
      final repository = CategoriesRepository(getMockShopwareClient());

      final response = await repository.getAll();
      expect(response, isA<Response<CategoryCriteriaResponse>>());
    });

    test('get', () async {
      final repository = CategoriesRepository(getMockShopwareClient());

      final response = await repository.get(IDGenerator.generate());

      expect(response, isA<Response<Category>>());
    });

    test('getNavigationMenu', () async {
      final repository = CategoriesRepository(getMockShopwareClient());

      final response = await repository.getNavigationMenu(
        const NavigationId.mainNavigation(),
        const NavigationId.mainNavigation(),
      );

      expect(response, isA<Response<List<Category>>>());
    });

    test('getMainNavigation', () async {
      final repository = CategoriesRepository(getMockShopwareClient());

      final response = await repository.getMainNavigation();

      expect(response, isA<Response<List<Category>>>());
    });
  });

  group('categoriesRepositoryProvider', () {
    test('returns a CategoriesRepository', () async {
      final container = ProviderContainer(
        overrides: [
          shopwareClientProvider.overrideWithValue(
            getMockShopwareClient(),
          ),
        ],
      );

      final repository = container.read(categoriesRepositoryProvider);

      expect(repository, isA<CategoriesRepository>());
    });
  });

  group('FutureProviders', () {
    ProviderContainer getProviderContainer() {
      return ProviderContainer(
        overrides: [
          categoriesRepositoryProvider.overrideWithValue(
            CategoriesRepository(
              getMockShopwareClient(),
            ),
          ),
        ],
      );
    }

    test('getAllCategoriesFutureProvider', () async {
      final container = getProviderContainer();

      final future = container.read(getAllCategoriesFutureProvider);

      future.when(
        data: (data) => expect(data, isA<Response<CategoryCriteriaResponse>>()),
        loading: () => expect(
          future,
          isA<AsyncLoading<Response<CategoryCriteriaResponse>>>(),
        ),
        error: (error, stackTrace) {},
      );
    });

    test('getSingleCategoryFuture', () async {
      final container = getProviderContainer();

      final future = container
          .read(getSingleCategoryFutureProvider(IDGenerator.generate()));

      future.when(
        data: (data) => expect(data, isA<Response<Category>>()),
        loading: () => expect(
          future,
          isA<AsyncLoading<Response<Category>>>(),
        ),
        error: (error, stackTrace) {},
      );
    });

    test('getNavigationMenuFuture', () async {
      final container = getProviderContainer();

      final future = container.read(getNavigationMenuFutureProvider());

      future.when(
        data: (data) => expect(data, isA<Response<List<Category>>>()),
        loading: () => expect(
          future,
          isA<AsyncLoading<Response<List<Category>>>>(),
        ),
        error: (error, stackTrace) {},
      );
    });
  });
}
