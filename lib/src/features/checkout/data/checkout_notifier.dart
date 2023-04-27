import 'package:flutterware/src/features/checkout/data/checkout_repository.dart';
import 'package:flutterware/src/features/checkout/data/checkout_state.dart';
import 'package:flutterware/src/features/checkout/data/order_notifier.dart';
import 'package:flutterware/src/features/checkout/presentation/screens/checkout_confirmation_screen.dart';
import 'package:flutterware/src/features/global/data/overlay_loading_notifier.dart';
import 'package:flutterware/src/routing/app_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../cart/data/cart_repository.dart';

part 'checkout_notifier.g.dart';

@Riverpod(keepAlive: true)
class CheckoutNotifier extends _$CheckoutNotifier {
  @override
  CheckoutState build() {
    return steps.first;
  }

  void nextStep() {
    final hasNextStep = steps.length > currentStepIndex + 1;

    if (hasNextStep) {
      state = steps[currentStepIndex + 1];
    } else {
      placeOrder();
    }
  }

  void previousStep() {
    final hasPreviousStep = currentStepIndex > 0;

    if (hasPreviousStep) {
      state = steps[currentStepIndex - 1];
    }
  }

  void placeOrder() async {
    ref.showOverlay();

    try {
      final response =
          await ref.read(checkoutRepositoryProvider).createOrderFromCart();

      print(response.body);

      if (response.body != null) {
        ref.read(orderNotifierProvider.notifier).setOrder(response.body!);
      }
      ref
          .read(goRouterProvider)
          .pushReplacementNamed(CheckoutConfirmationScreen.name);

      ref.invalidate(cartNotifierProvider);
      ref.invalidateSelf();
    } catch (e, st) {
      print(e);
      print(st);
    } finally {
      ref.hideOverlay();
    }
  }

  int get currentStepIndex {
    return steps.indexOf(state);
  }

  bool get isFirstStep {
    return currentStepIndex == 0;
  }

  bool get isLastStep {
    return currentStepIndex == steps.length - 1;
  }

  List<CheckoutState> get steps {
    return [
      /* const CheckoutStateInitial(), */
      const CheckoutStateShipping(),
      const CheckoutStatePayment(),
      const CheckoutStateReview(),
    ];
  }

  bool isStepDone(CheckoutState step) {
    return steps.indexOf(step) <= currentStepIndex;
  }

  double get progress {
    return (currentStepIndex / steps.length) + doubleProgressStep;
  }

  double get doubleProgressStep {
    return 1 / (steps.length * 2);
  }
}
