import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/api/shopware_client.dart';
import 'package:flutterware/src/features/products/data/products_repository.dart';
import 'package:flutterware/src/features/products/data/products_view/products_view_controller.dart';
import 'package:flutterware/src/features/search/data/search_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../../../utils/id_generator.dart';
import '../../../../../utils/mock/mock_response.dart';
import '../../../../../utils/mock/mock_shopware_client.dart';
import '../../../../../utils/riverpod/listener.dart';

class MockProductsRepository extends Mock implements ProductsRepository {}

class MockSearchRepository extends Mock implements SearchRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(IDGenerator.generate());
    registerFallbackValue(const ProductListingCriteriaInput());
    registerFallbackValue(AsyncData<ProductsViewState>(
      ProductsViewState.initial(type: ProductsViewType.byCategoryId),
    ));
  });

  ProviderContainer makeProviderContainer({
    MockProductsRepository? mockProductsRepository,
    MockSearchRepository? mockSearchRepository,
  }) {
    final mockShopwareClient = getMockShopwareClient();
    final container = ProviderContainer(
      overrides: [
        shopwareClientProvider.overrideWithValue(mockShopwareClient),
        if (mockProductsRepository != null)
          productsRepositoryProvider.overrideWithValue(mockProductsRepository),
        if (mockSearchRepository != null)
          searchRepositoryProvider.overrideWithValue(mockSearchRepository),
      ],
    );

    addTearDown(container.dispose);

    return container;
  }

  group('ProductViewMode', () {
    test('provider defaults to list', () {
      final container = ProviderContainer();

      expect(container.read(productViewModeProvider), ProductViewMode.list);
    });

    test('provider can be updated', () {
      final container = ProviderContainer();

      container.read(productViewModeProvider.notifier).state =
          ProductViewMode.grid;

      expect(container.read(productViewModeProvider), ProductViewMode.grid);
    });
  });

  group('ProductsViewNotifier', () {
    dynamic mockPayloadForType(ProductsViewType type) {
      switch (type) {
        case ProductsViewType.byCategoryId:
          return IDGenerator.generate();
        case ProductsViewType.search:
          return 'query';
      }
    }

    void testInitializesCorrectlyForType({
      required ProductsViewType type,
      required ProviderContainer container,
    }) async {
      final listener = Listener<AsyncValue<ProductsViewState>>();

      final provider = productsViewNotifierProvider(
        type,
        mockPayloadForType(type),
      );

      container.listen(
        provider,
        listener,
        fireImmediately: true,
      );

      const loadingState = AsyncLoading<ProductsViewState>();

      expect(container.read(provider), loadingState);

      final stateAfterBuild = await container.read(provider.future);

      expect(stateAfterBuild, isA<ProductsViewState>());
      expect(stateAfterBuild.type, equals(type));

      final dataState = AsyncData<ProductsViewState>(stateAfterBuild);

      verifyInOrder([
        () => listener(null, loadingState),
        () => listener(loadingState, dataState),
      ]);

      verifyNoMoreInteractions(listener);
    }

    test('initializes correctly for a category ID', () async {
      final mockProductsRepository = MockProductsRepository();
      when(() => mockProductsRepository.byCategoryId(any(), any())).thenAnswer(
        (_) async {
          return MockResponse(
            ProductCriteriaResponse(
              elements: [],
              total: 10,
              page: 1,
              limit: 10,
              listingAggregations: ListingAggregations(),
            ),
          );
        },
      );

      final container = makeProviderContainer(
        mockProductsRepository: mockProductsRepository,
      );

      testInitializesCorrectlyForType(
        type: ProductsViewType.byCategoryId,
        container: container,
      );
    });

    test('initializes correctly for a search query', () async {
      final mockSearchRepository = MockSearchRepository();
      when(() => mockSearchRepository.search(any(), any())).thenAnswer(
        (_) async {
          return MockResponse(
            ProductCriteriaResponse(
              elements: [],
              total: 10,
              page: 1,
              limit: 10,
              listingAggregations: ListingAggregations(),
            ),
          );
        },
      );

      final container = makeProviderContainer(
        mockSearchRepository: mockSearchRepository,
      );

      testInitializesCorrectlyForType(
        type: ProductsViewType.search,
        container: container,
      );
    });
  });
}
