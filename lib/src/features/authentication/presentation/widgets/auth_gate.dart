import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../global/data/global_data_notifier.dart';

class AuthGate extends ConsumerWidget {
  final Widget loggedInChild;
  final Widget? loggedOutChild;
  const AuthGate({
    super.key,
    required this.loggedInChild,
    this.loggedOutChild,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn =
        ref.watch(globalDataNotifierProvider).asData!.value.isCustomerLoggedIn;

    if (isLoggedIn) {
      return loggedInChild;
    } else {
      return loggedOutChild ?? const SizedBox.shrink();
    }
  }
}
