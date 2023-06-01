import 'package:flutterware/src/constants/app_config.dart';
import 'package:flutterware/src/features/global/data/local_storage_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopware6_client/shopware6_client.dart';

part 'shopware_client.g.dart';

@Riverpod(keepAlive: true)
ShopwareClient shopwareClient(ShopwareClientRef ref) {
  final client = ShopwareClient(
    config: const ShopwareClientConfig(
      baseUrl: AppConfig.baseUrl,
      swAccessKey: AppConfig.swAccessKey,
      logging: true,
      logRequestBody: true,
      logResponseBody: false,
      logRequestHeaders: true,
      logResponseHeaders: true,
    ),
  );

  final persistedToken =
      ref.read(localStorageRepositoryProvider).getContextToken();

  if (persistedToken != null) {
    client.swContextToken = persistedToken;
  }

  return client;

  /* return ShopwareClient(
    baseUrl: 'https://customerdemo6.emzserver.de',
    swAccessKey: 'SWSCZFV6QWDKEXFKTMDRCU9IZQ',
  ); */
}
