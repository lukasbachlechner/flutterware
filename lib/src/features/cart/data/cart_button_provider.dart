import 'package:flutter/cupertino.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/features/cart/data/cart_repository.dart';
import 'package:flutterware/src/features/cart/screens/cart_screen.dart';
import 'package:flutterware/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/flutterware_icons.dart';

class CartButtonState {
  final IconData iconData;
  final String text;
  final VoidCallback onPressed;
  final Color buttonBackgroundColor;
  final Color textColor;

  const CartButtonState({
    required this.iconData,
    required this.text,
    required this.onPressed,
    this.buttonBackgroundColor = AppColors.primaryColor,
    this.textColor = AppColors.blackPrimary,
  });
}

class InitialCartButtonState extends CartButtonState {
  InitialCartButtonState({required onPressed})
      : super(
          iconData: FlutterwareIcons.basket,
          text: 'Cart',
          onPressed: onPressed,
        );
}

class CartIsEmptyCartButtonState extends CartButtonState {
  CartIsEmptyCartButtonState({required onPressed})
      : super(
          iconData: FlutterwareIcons.close,
          text: 'Exit cart',
          onPressed: onPressed,
          buttonBackgroundColor: AppColors.blackPrimary,
        );
}

class CartIsNotEmptyCartButtonState extends CartButtonState {
  CartIsNotEmptyCartButtonState({required onPressed})
      : super(
          iconData: FlutterwareIcons.arrowRight,
          text: 'Checkout',
          onPressed: onPressed,
        );
}

class AddToCartCartButtonState extends CartButtonState {
  AddToCartCartButtonState({required onPressed})
      : super(
          iconData: FlutterwareIcons.plus,
          text: 'Add to cart',
          onPressed: onPressed,
          textColor: AppColors.primaryColor,
        );
}

class CartButtonNotifier extends StateNotifier<CartButtonState> {
  final Ref ref;
  CartButtonNotifier(this.ref)
      : super(
          InitialCartButtonState(
            onPressed: _goToCartScreenCallback(ref),
          ),
        ) {
    ref.listen(cartNotifierProvider, (previous, next) {
      if (next.hasValue &&
          next.value!.isEmpty &&
          state is CartIsNotEmptyCartButtonState) {
        setCartIsEmptyState();
      }
    });
  }

  static VoidCallback _goToCartScreenCallback(Ref ref) {
    return () => ref
        .read(shellNavigatorKeyProvider)
        .currentContext
        ?.pushNamed(CartScreen.name);
  }

  void setInitialState() {
    state = InitialCartButtonState(
      onPressed: _goToCartScreenCallback(ref),
    );
  }

  void setAddToCartState({required VoidCallback onPressed}) {
    state = AddToCartCartButtonState(
      onPressed: onPressed,
    );
  }

  void setCartIsEmptyState() {
    state = CartIsEmptyCartButtonState(
      onPressed: () =>
          ref.read(shellNavigatorKeyProvider).currentContext?.pop(),
    );
  }

  void setCartIsNotEmptyState() {
    state = CartIsNotEmptyCartButtonState(
      onPressed: () => print('go to checkout!'),
    );
  }
}

final cartItemCountProvider = StateProvider<int>((ref) => 0);

final cartButtonNotifierProvider =
    StateNotifierProvider<CartButtonNotifier, CartButtonState>(
  (ref) => CartButtonNotifier(ref),
);
