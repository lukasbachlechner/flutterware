import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/button/button.dart';
import 'package:flutterware/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

class AccountScreen extends StatelessWidget {
  static const path = '/account';
  static const name = 'accountScreen';
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Button(
          label: 'Login',
          onPressed: () => context.pushNamed(LoginScreen.name),
        )
      ],
    ));
  }
}
