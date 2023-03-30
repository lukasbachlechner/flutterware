import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_storage_repository.g.dart';

class LocalStorageRepository {
  late final Box box;

  static const defaultBoxName = 'box';
  static const contextTokenKey = 'sw_context_token';

  LocalStorageRepository() {
    box = Hive.box(defaultBoxName);
  }

  void saveContextToken(String token) {
    if (box.get(contextTokenKey) == null) {
      box.put(contextTokenKey, token);
    }
  }

  String? getContextToken() {
    return box.get(contextTokenKey);
  }
}

@Riverpod(keepAlive: true)
LocalStorageRepository localStorageRepository(LocalStorageRepositoryRef ref) {
  return LocalStorageRepository();
}
