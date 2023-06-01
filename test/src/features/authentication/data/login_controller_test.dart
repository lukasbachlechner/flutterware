import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/features/authentication/data/auth_repository.dart';
import 'package:flutterware/src/features/authentication/data/login_controller.dart';
import 'package:flutterware/src/features/global/data/local_storage_repository.dart';
import 'package:flutterware/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../../utils/mock/mock_response.dart';
import '../../../../utils/riverpod/listener.dart';

typedef LoginControllerState = Response<ContextTokenResponse>?;

class MockLocalStorageRepository extends Mock
    implements LocalStorageRepository {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  group('LoginController', () {
    test('login success', () {
      final mockLocalStorageRepository = MockLocalStorageRepository();
      final mockAuthRepository = MockAuthRepository();
      final mockGoRouter = MockGoRouter();

      when(
        () => mockAuthRepository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => MockResponse(
          ContextTokenResponse(contextToken: 'contextToken'),
        ),
      );

      final container = ProviderContainer(
        overrides: [
          localStorageRepositoryProvider
              .overrideWithValue(mockLocalStorageRepository),
          authRepositoryProvider.overrideWithValue(mockAuthRepository),
          goRouterProvider.overrideWithValue(mockGoRouter),
        ],
      );

      final controller = container.read(loginControllerProvider.notifier);
      final listener = Listener<AsyncValue<Response<ContextTokenResponse>?>>();

      container.listen(
        loginControllerProvider,
        listener,
        fireImmediately: true,
      );

      const stateAfterBuild = AsyncData<LoginControllerState>(null);

      verify(() => listener(null, stateAfterBuild)).called(1);
    });
  });
}
