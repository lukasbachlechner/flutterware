import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../api/shopware_client.dart';

part 'checkout_repository.g.dart';

class CheckoutRepository {
  final ShopwareClient client;

  CheckoutRepository(
    this.client,
  );

  Future<Response<Order>> createOrderFromCart() {
    return client.checkout.createOrderFromCart();
  }
}

@riverpod
CheckoutRepository checkoutRepository(CheckoutRepositoryRef ref) {
  final client = ref.watch(shopwareClientProvider);
  return CheckoutRepository(client);
}
