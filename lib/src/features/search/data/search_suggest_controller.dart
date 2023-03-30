import 'package:flutter/material.dart';
import 'package:flutterware/src/features/search/data/search_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopware6_client/shopware6_client.dart';

part 'search_suggest_controller.g.dart';

@riverpod
class SearchSuggestController extends _$SearchSuggestController {
  @override
  List<Product> build() {
    return [];
  }

  void suggest(String query) async {
    try {
      final response = await ref
          .read(searchRepositoryProvider)
          .searchSuggest(ProductSearchSuggestInput(search: query));
      if (response.body != null) {
        state = response.body!.elements;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
