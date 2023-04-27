import 'package:flutter/material.dart';
import 'package:flutterware/src/features/authentication/presentation/views/account_logged_out_view.dart';
import 'package:flutterware/src/features/authentication/presentation/widgets/auth_gate.dart';
import 'package:flutterware/src/features/checkout/presentation/views/checkout_view.dart';

class CheckoutScreen extends StatelessWidget {
  static const path = '/checkout';
  static const name = 'checkoutScreen';
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthGate(
      loggedInChild: CheckoutView(),
      loggedOutChild: AccountLoggedOutView(),
    );
  }
}
