import 'package:flutter/cupertino.dart';
import 'package:flutterware/src/features/cart/data/cart_button_provider.dart';
import 'package:flutterware/src/features/cart/data/cart_repository.dart';
import 'package:flutterware/src/features/cart/screens/cart_screen.dart';
import 'package:flutterware/src/features/products/presentation/screens/single_product_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_route_observer.g.dart';

class AppRouteObserver extends NavigatorObserver {
  late final CartButtonNotifier cartButtonNotifier;
  final Ref ref;

  AppRouteObserver(this.ref) {
    cartButtonNotifier = ref.read(cartButtonNotifierProvider.notifier);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    switch (route.settings.name) {
      /*   case SingleProductScreen.name:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          cartButtonNotifier.setAddToCartState();
        });
        break; */
      case CartScreen.name:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (ref.read(cartNotifierProvider.notifier).isEmpty) {
            cartButtonNotifier.setCartIsEmptyState();
          } else {
            cartButtonNotifier.setCartIsNotEmptyState();
          }
        });
        break;
      default:
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    switch (route.settings.name) {
      case SingleProductScreen.name:
      case CartScreen.name:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          cartButtonNotifier.setInitialState();
        });
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {}
}

@Riverpod(keepAlive: true)
AppRouteObserver appRouteObserver(AppRouteObserverRef ref) {
  return AppRouteObserver(ref);
}
