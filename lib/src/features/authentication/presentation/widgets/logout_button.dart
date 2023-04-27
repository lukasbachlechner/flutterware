import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/button/button.dart';
import 'package:flutterware/src/features/global/data/global_data_notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../api/shopware_client.dart';
import '../../../global/data/local_storage_repository.dart';
import '../../data/auth_repository.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref
            .watch(globalDataNotifierProvider)
            .asData!
            .value
            .isCustomerLoggedIn ==
        false) {
      return const SizedBox.shrink();
    }

    Future<void> doLogout() async {
      final newTokenResult = await ref.read(authRepositoryProvider).logout();
      await ref.read(localStorageRepositoryProvider).deleteContextToken();

      if (newTokenResult.body != null) {
        ref.read(shopwareClientProvider).swContextToken =
            newTokenResult.body!.contextToken;
      }
      ref.invalidate(globalDataNotifierProvider);
      if (context.mounted) {
        context.pop();
      }
    }

    return Button(
      label: 'Logout',
      buttonType: ButtonType.primaryBlack,
      buttonSize: ButtonSize.fullWidth,
      onPressed: () async {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'Are you sure?',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                actions: [
                  Button(
                    label: 'No',
                    buttonType: ButtonType.text,
                    onPressed: () => context.pop(),
                  ),
                  Button(
                    label: 'Yes',
                    onPressed: doLogout,
                  ),
                ],
              );
            });
      },
    );
  }
}
