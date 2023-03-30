import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../api/shopware_client.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  final ShopwareClient client;

  AuthRepository(this.client);

  Future<Response<dynamic>> login(
      {required String email, required String password}) {
    return client.auth.login(
      LoginRequest(username: email, password: password),
    );
  }

  Future<Response<void>> logout() {
    return client.auth.logout();
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  final client = ref.watch(shopwareClientProvider);
  return AuthRepository(client);
}
