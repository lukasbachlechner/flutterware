import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/api/shopware_client.dart';
import 'package:flutterware/src/features/search/data/search_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../../utils/mock/mock_shopware_client.dart';

void main() {
  group('SearchRepository', () {
    test('executes search', () async {
      final searchRepository = SearchRepository(
        getMockShopwareClient(),
      );

      final response = await searchRepository.search(
        'term',
        const ProductListingCriteriaInput(),
      );

      expect(response, isA<Response<ProductCriteriaResponse>>());
    });

    test('executes search suggest', () async {
      final searchRepository = SearchRepository(
        getMockShopwareClient(),
      );

      // This will throw a TypeError because of the Shopware 6 API.

      Object? exception;
      Response<ProductCriteriaResponse>? response;

      try {
        response = await searchRepository.searchSuggest(
          ProductSearchSuggestInput(
            search: 'term',
          ),
        );
      } catch (e) {
        exception = e;
      }

      expect(response, isNull);
      expect(exception, isNotNull);
      expect(exception, isA<TypeError>());
    });
  });

  group('searchRepositoryProvider', () {
    test('returns a SearchRepository', () async {
      final container = ProviderContainer(
        overrides: [
          shopwareClientProvider.overrideWithValue(
            getMockShopwareClient(),
          ),
        ],
      );

      final repository = container.read(searchRepositoryProvider);

      expect(repository, isA<SearchRepository>());
    });
  });
}
