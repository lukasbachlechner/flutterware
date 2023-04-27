import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopware6_client/shopware6_client.dart';

part 'order_notifier.g.dart';

@Riverpod(keepAlive: true)
class OrderNotifier extends _$OrderNotifier {
  @override
  Order? build() {
    return null;
  }

  void setOrder(Order order) {
    state = order;
  }
}
