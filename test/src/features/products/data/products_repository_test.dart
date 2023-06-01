import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/api/shopware_client.dart';
import 'package:flutterware/src/features/products/data/products_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../../utils/factories/product_factory.dart';
import '../../../../utils/factories/property_group_option_factory.dart';
import '../../../../utils/id_generator.dart';
import '../../../../utils/mock/mock_shopware_client.dart';

void main() {
  group('ProductsRepository', () {
    test('initializes correctly', () {
      final repository = ProductsRepository(getMockShopwareClient());

      expect(repository.client, isA<ShopwareClient>());
      expect(repository.productService, isA<ProductService>());
    });

    test('getAll', () async {
      final repository = ProductsRepository(getMockShopwareClient());

      final response = await repository.getAll(const CriteriaInput());

      expect(response, isA<Response<ProductCriteriaResponse>>());
    });

    test('byCategoryId', () async {
      final repository = ProductsRepository(getMockShopwareClient());

      final response = await repository.byCategoryId(
        IDGenerator.generate(),
        const ProductListingCriteriaInput(),
      );

      expect(response, isA<Response<ProductCriteriaResponse>>());
    });

    test('get', () async {
      final repository = ProductsRepository(getMockShopwareClient());

      final response = await repository.get(IDGenerator.generate());

      expect(response, isA<Response<ProductDetailResponse>>());
      expect(response.body, isNotNull);
      expect(response.body!.product, isA<Product>());
    });
  });

  group('productsRepositoryProvider', () {
    test('returns a ProductsRepository', () async {
      final container = ProviderContainer(
        overrides: [
          shopwareClientProvider.overrideWithValue(
            getMockShopwareClient(),
          ),
        ],
      );

      final repository = container.read(productsRepositoryProvider);

      expect(repository, isA<ProductsRepository>());
    });
  });

  group('FutureProviders', () {
    ProviderContainer getProviderContainer() {
      return ProviderContainer(
        overrides: [
          productsRepositoryProvider.overrideWithValue(
            ProductsRepository(
              getMockShopwareClient(),
            ),
          ),
        ],
      );
    }

    test('getAllProductsFutureProvider', () async {
      final container = getProviderContainer();

      final future = container.read(getAllProductsFutureProvider());

      future.when(
        data: (data) => expect(data, isA<Response<ProductCriteriaResponse>>()),
        loading: () => expect(
          future,
          isA<AsyncLoading<Response<ProductCriteriaResponse>>>(),
        ),
        error: (error, stackTrace) {},
      );
    });

    test('getSingleProductFutureProvider', () async {
      final container = getProviderContainer();

      final future = container
          .read(getSingleProductFutureProvider(IDGenerator.generate()));

      future.when(
        data: (data) => expect(data, isA<Response<ProductDetailResponse>>()),
        loading: () => expect(
          future,
          isA<AsyncLoading<Response<ProductDetailResponse>>>(),
        ),
        error: (error, stackTrace) {},
      );
    });

    test('getSingleProductPageDataFutureProvider', () async {
      final container = getProviderContainer();

      final future = container
          .read(getSingleProductPageDataFutureProvider(IDGenerator.generate()));

      future.when(
        data: (data) => expect(data, isA<SingleProductPageData>()),
        loading: () => expect(
          future,
          isA<AsyncLoading<SingleProductPageData>>(),
        ),
        error: (error, stackTrace) {},
      );
    });
  });

  group('SingleProductPageData', () {
    test('initializes correctly', () async {
      final repository = ProductsRepository(getMockShopwareClient());

      final response = await repository.get(IDGenerator.generate());

      final data = SingleProductPageData(
        variants: [
          createProduct(),
        ],
        productResponse: response,
      );

      expect(data.variants, isA<List<Product>>());
      expect(data.productResponse, isA<Response<ProductDetailResponse>>());
    });
  });

  group('PropertyGroupOptionWithProductId', () {
    test('initializes correctly', () async {
      final productId = IDGenerator.generate();
      final data = PropertyGroupOptionWithProductId(
        productId: productId,
        isAvailable: true,
        propertyGroupOption: createPropertyGroupOption(),
      );

      expect(data.productId, equals(productId));
      expect(data.isAvailable, isTrue);
      expect(data.propertyGroupOption, isA<PropertyGroupOption>());
    });
  });
}
