import 'package:flutterware/src/constants/app_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../api/shopware_client.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  final ShopwareClient client;

  AuthRepository(this.client);

  Future<Response<ContextTokenResponse>> login({
    required String email,
    required String password,
  }) {
    return client.auth.login(
      LoginRequest(
        username: email,
        password: password,
      ),
    );
  }

  Future<Response<ContextTokenResponse>> logout() {
    return client.auth.logout();
  }

  Future<Response<Customer>> register({
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
    return client.auth.register(
      SignupRequest(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        salutationId: salutationId,
        acceptedDataProtection: acceptedDataProtection,
        storefrontUrl: AppConfig.defaultHeadlessUrl,
        billingAddress: AddressInput(
          firstName: firstName,
          lastName: lastName,
          street: street,
          zipcode: zipcode,
          city: city,
          countryId: countryId,
        ),
      ),
    );
  }

  Future<Response<Customer>> getCustomer() {
    return client.auth.getCustomer();
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  final client = ref.watch(shopwareClientProvider);
  return AuthRepository(client);
}
