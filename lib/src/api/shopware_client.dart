import 'package:flutterware/src/constants/app_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopware6_client/shopware6_client.dart';

part 'shopware_client.g.dart';

@Riverpod(keepAlive: true)
ShopwareClient shopwareClient(ShopwareClientRef ref) {
  return ShopwareClient(
    baseUrl: AppConfig.baseUrl,
    swAccessKey: AppConfig.swAccessKey,
  );

  /* return ShopwareClient(
    baseUrl: 'https://customerdemo6.emzserver.de',
    swAccessKey: 'SWSCZFV6QWDKEXFKTMDRCU9IZQ',
  ); */
}
