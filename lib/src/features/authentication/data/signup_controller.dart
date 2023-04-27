import 'package:flutterware/src/features/global/data/global_data_notifier.dart';
import 'package:flutterware/src/features/global/data/local_storage_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../routing/app_router.dart';
import '../../home/presentation/home_screen.dart';
import 'auth_repository.dart';

part 'signup_controller.g.dart';

@riverpod
class SignupController extends _$SignupController {
  @override
  FutureOr<Response<Customer>?> build() {
    // Nothing to do.
    return null;
  }

  Future<void> submit({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required ID salutationId,
    required String street,
    required String zipcode,
    required String city,
    required ID countryId,
    required bool acceptedDataProtection,
  }) async {
    state = const AsyncLoading();

    final result = await _signup(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      salutationId: salutationId,
      street: street,
      zipcode: zipcode,
      city: city,
      countryId: countryId,
      acceptedDataProtection: acceptedDataProtection,
    );

    if (result.error != null) {
      state = AsyncError(
          result.error! as ShopwareErrorResponse, StackTrace.current);
    } else {
      state = AsyncData(result);

      final newContextToken = result.headers['sw-context-token'];

      if (newContextToken != null) {
        ref.read(localStorageRepositoryProvider).updateContextToken(
              newContextToken,
            );

        ref.invalidate(globalDataNotifierProvider);

        ref.read(goRouterProvider).goNamed(HomeScreen.name);
      }
    }
  }

  Future<Response<Customer>> _signup({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required ID salutationId,
    required String street,
    required String zipcode,
    required String city,
    required ID countryId,
    required bool acceptedDataProtection,
  }) {
    final authRepository = ref.read(authRepositoryProvider);
    return authRepository.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        salutationId: salutationId,
        street: street,
        zipcode: zipcode,
        city: city,
        countryId: countryId,
        acceptedDataProtection: acceptedDataProtection);
  }
}
