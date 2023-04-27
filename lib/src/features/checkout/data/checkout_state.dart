// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutterware/src/features/checkout/presentation/views/steps/checkout_review_step.dart';
import 'package:flutterware/src/features/checkout/presentation/views/steps/checkout_shipping_step.dart';

import '../presentation/views/steps/checkout_payment_step.dart';

abstract class CheckoutState {
  final ValueKey stateKey;

  const CheckoutState(
    this.stateKey,
  );

  Widget get content;
  String get title;
  String get nextButtonLabel;
  String get backButtonLabel => 'Go back';

  @override
  bool operator ==(covariant CheckoutState other) {
    if (identical(this, other)) return true;

    return other.stateKey == stateKey;
  }

  @override
  int get hashCode => stateKey.hashCode;
}

class CheckoutStateInitial extends CheckoutState {
  const CheckoutStateInitial() : super(const ValueKey('CheckoutStateInitial'));

  @override
  Widget get content => const Placeholder();

  @override
  String get title => 'Details';

  @override
  String get nextButtonLabel => 'Go to shipping';
}

class CheckoutStateShipping extends CheckoutState {
  const CheckoutStateShipping()
      : super(const ValueKey('CheckoutStateShipping'));

  @override
  Widget get content => const CheckoutShippingStep();

  @override
  String get title => 'Shipping';

  @override
  String get nextButtonLabel => 'Go to payment';
}

class CheckoutStatePayment extends CheckoutState {
  const CheckoutStatePayment() : super(const ValueKey('CheckoutStatePayment'));

  @override
  Widget get content => const CheckoutPaymentStep();

  @override
  String get title => 'Payment';

  @override
  String get nextButtonLabel => 'Go to review';
}

class CheckoutStateReview extends CheckoutState {
  const CheckoutStateReview() : super(const ValueKey('CheckoutStateReview'));

  @override
  Widget get content => const CheckoutReviewStep();

  @override
  String get title => 'Review';

  @override
  String get nextButtonLabel => 'Confirm & pay';
}
