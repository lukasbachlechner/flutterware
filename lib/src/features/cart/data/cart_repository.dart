import 'package:flutterware/src/api/shopware_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopware6_client/shopware6_client.dart';

part 'cart_repository.g.dart';

class CartRepository {
  final ShopwareClient client;

  CartRepository(this.client);

  Future<Response<Cart>> getOrCreateCart() {
    return client.cart.getOrCreateCart();
  }

  Future<Response<Cart>> addItems(List<LineItem> items) {
    return client.cart.addItems(items);
  }

  Future<Response<Cart>> updateItems(List<LineItem> items) {
    return client.cart.updateItems(items);
  }

  Future<Response<Cart>> removeItems(List<ID> ids) {
    return client.cart.removeItems(ids);
  }
}

@Riverpod(keepAlive: true)
CartRepository cartRepository(CartRepositoryRef ref) {
  final client = ref.watch(shopwareClientProvider);
  return CartRepository(client);
}

class CartState {
  final Cart cart;
  const CartState(this.cart);

  List<LineItem> get products {
    return cart.lineItems
            ?.where((item) => item.type == LineItemType.product)
            .toList() ??
        [];
  }

  int get productCount {
    return products.fold(
      0,
      (previousValue, item) => previousValue + (item.quantity ?? 0),
    );
  }

  bool get isEmpty {
    return productCount == 0;
  }
}

@Riverpod(keepAlive: true)
class CartNotifier extends _$CartNotifier {
  @override
  FutureOr<CartState> build() async {
    final cartResponse =
        await ref.watch(cartRepositoryProvider).getOrCreateCart();
    if (cartResponse.body != null) {
      return CartState(cartResponse.body!);
    } else {
      return CartState(Cart());
    }
  }

  Future<void> addItems(List<LineItem> items) async {
    state = const AsyncLoading();
    try {
      final newCartResponse =
          await ref.read(cartRepositoryProvider).addItems(items);
      if (newCartResponse.body != null) {
        state = AsyncData(CartState(newCartResponse.body!));
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> updateItems(List<LineItem> items) async {
    state = const AsyncLoading();
    try {
      final newCartResponse =
          await ref.read(cartRepositoryProvider).updateItems(items);
      if (newCartResponse.body != null) {
        state = AsyncData(CartState(newCartResponse.body!));
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> removeItems(List<ID> ids) async {
    state = const AsyncLoading();
    try {
      final newCartResponse =
          await ref.read(cartRepositoryProvider).removeItems(ids);
      if (newCartResponse.body != null) {
        state = AsyncData(CartState(newCartResponse.body!));
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  List<LineItem> get products {
    if (state.hasValue) {
      return state.value!.products;
    }

    return [];
  }

  int get productCount {
    if (state.hasValue) {
      return state.value!.productCount;
    }

    return 0;
  }

  bool get isEmpty {
    if (state.hasValue) {
      return state.value!.isEmpty;
    }

    return true;
  }
}
