import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/features/search/data/search_repository.dart';
import 'package:flutterware/src/features/search/data/search_suggest_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../../utils/factories/product_factory.dart';
import '../../../../utils/id_generator.dart';
import '../../../../utils/mock/mock_response.dart';
import '../../../../utils/riverpod/listener.dart';

class MockSearchRepository extends Mock implements SearchRepository {}

void main() {
  group('SearchSuggestController', () {
    setUpAll(() {
      registerFallbackValue(
        ProductSearchSuggestInput(search: 'term'),
      );
    });
    test('initializes with empty state', () {
      final controller = SearchSuggestController();

      final state = controller.build();

      expect(state, isA<List>());
      expect(state, isEmpty);
    });

    test('has results after calling suggest', () async {
      final mockSearchRepository = MockSearchRepository();
      final resultProductId = IDGenerator.generate();

      when(() => mockSearchRepository.searchSuggest(any()))
          .thenAnswer((_) async {
        return MockResponse(
          createProductCriteriaResponse(
            resultProductId: resultProductId,
          ),
        );
      });

      final container = ProviderContainer(
        overrides: [
          searchRepositoryProvider.overrideWithValue(mockSearchRepository),
        ],
      );
      final listener = Listener<List<Product>>();
      container.listen(
        searchSuggestControllerProvider,
        listener,
        fireImmediately: true,
      );

      verify(() => listener(null, []));

      final controller =
          container.read(searchSuggestControllerProvider.notifier);

      await controller.suggest('test');

      final state = container.read(searchSuggestControllerProvider);

      expect(state, isA<List>());
      expect(state, isNotEmpty);
    });

    test('returns empty state on exception', () async {
      final mockSearchRepository = MockSearchRepository();
      const exceptionMessage = 'Test exception message';

      when(() => mockSearchRepository.searchSuggest(any()))
          .thenThrow(Exception(exceptionMessage));

      final container = ProviderContainer(
        overrides: [
          searchRepositoryProvider.overrideWithValue(mockSearchRepository),
        ],
      );

      final listener = Listener<List<Product>>();
      container.listen(
        searchSuggestControllerProvider,
        listener,
        fireImmediately: true,
      );

      verify(() => listener(null, []));

      final controller =
          container.read(searchSuggestControllerProvider.notifier);
      final printLog = [];

      runZoned(() async {
        await controller.suggest('test');
      }, zoneSpecification: ZoneSpecification(
        print: (_, __, ___, message) {
          printLog.add(message);
        },
      ));

      final state = container.read(searchSuggestControllerProvider);

      expect(state, isA<List>());
      expect(state, isEmpty);

      expect(printLog, contains('Exception: $exceptionMessage'));
    });
  });
}
