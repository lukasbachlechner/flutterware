import 'package:flutterware/src/features/authentication/data/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopware6_client/shopware6_client.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<Response<dynamic>?> build() {
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
    }
  }

  Future<Response<dynamic>> _authenticate(String email, String password) {
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
