import 'package:flutterware/src/api/shopware_client.dart';
import 'package:flutterware/src/features/authentication/data/auth_repository.dart';
import 'package:flutterware/src/features/home/presentation/home_screen.dart';
import 'package:flutterware/src/routing/app_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../global/data/global_data_notifier.dart';
import '../../global/data/local_storage_repository.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<Response<ContextTokenResponse>?> build() {
    // Nothing to do.
    return null;
  }

  Future<void> submit({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    final result = await _authenticate(email, password);

    if (result.error != null) {
      state = AsyncError(result.error!, StackTrace.current);
    } else {
      state = AsyncData(result);
      final newContextToken = result.body!.contextToken;

      print('newContextToken: $newContextToken');

      await ref
          .read(localStorageRepositoryProvider)
          .updateContextToken(newContextToken);

      ref.read(shopwareClientProvider).swContextToken = newContextToken;

      ref.invalidate(globalDataNotifierProvider);

      ref.read(goRouterProvider).goNamed(HomeScreen.name);
    }
  }

  Future<Response<ContextTokenResponse>> _authenticate(
      String email, String password) {
    final authRepository = ref.read(authRepositoryProvider);
    return authRepository.login(
      email: email,
      password: password,
    );
  }

  /*  bool get hasError {
    return state.hasValue && state.value != null && state.value!.error != null;
  } */

  String get errorMessage {
    return "Invalid email and/or password";
  }
}
