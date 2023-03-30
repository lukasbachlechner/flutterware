import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../api/shopware_client.dart';

part 'search_repository.g.dart';

class SearchRepository {
  final ShopwareClient client;

  const SearchRepository(this.client);

  Future<Response<ProductCriteriaResponse>> search(
    String search,
    ProductListingCriteriaInput criteriaInput,
  ) {
    return client.products.search(search, criteriaInput);
  }

  Future<Response<ProductCriteriaResponse>> searchSuggest(
    ProductSearchSuggestInput suggestInput,
  ) {
    return client.products.searchSuggest(suggestInput);
  }
}

@Riverpod(keepAlive: true)
SearchRepository searchRepository(SearchRepositoryRef ref) {
  final client = ref.watch(shopwareClientProvider);
  return SearchRepository(client);
}
