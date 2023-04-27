import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/page_wrap/page_wrap.dart';
import 'package:flutterware/src/features/authentication/presentation/views/account_logged_in_view.dart';
import 'package:flutterware/src/features/authentication/presentation/views/account_logged_out_view.dart';

import '../widgets/auth_gate.dart';

class AccountScreen extends StatelessWidget {
  static const path = '/account';
  static const name = 'accountScreen';
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageWrap(
      child: AuthGate(
        loggedInChild: AccountLoggedInView(),
        loggedOutChild: AccountLoggedOutView(),
      ),
    );
  }
}
