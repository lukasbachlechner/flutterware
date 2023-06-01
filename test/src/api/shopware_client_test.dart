import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/api/shopware_client.dart';
import 'package:flutterware/src/features/global/data/local_storage_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shopware6_client/shopware6_client.dart';

class MockLocalStorageRepository extends Mock
    implements LocalStorageRepository {}

void main() {
  group('shopwareClientProvider', () {
    test('returns a ShopwareClient', () async {
      final mockLocalStorageRepository = MockLocalStorageRepository();

      when(() => mockLocalStorageRepository.getContextToken()).thenReturn(null);
      final container = ProviderContainer(overrides: [
        localStorageRepositoryProvider
            .overrideWithValue(mockLocalStorageRepository),
      ]);

      final client = container.read(shopwareClientProvider);

      expect(client, isA<ShopwareClient>());
    });

    test('returns a ShopwareClient with a token', () async {
      final mockLocalStorageRepository = MockLocalStorageRepository();

      when(() => mockLocalStorageRepository.getContextToken())
          .thenReturn('test-token');
      final container = ProviderContainer(overrides: [
        localStorageRepositoryProvider
            .overrideWithValue(mockLocalStorageRepository),
      ]);

      final client = container.read(shopwareClientProvider);

      expect(client.swContextToken, isNotNull);
      expect(client.swContextToken, equals('test-token'));
    });
  });
}
