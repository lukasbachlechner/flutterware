import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutterware/src/common_widgets/async_value_widget/async_value_widget.dart';
import 'package:flutterware/src/common_widgets/loading_indicator/loading_indicator.dart';
import 'package:flutterware/src/features/global/data/global_data_notifier.dart';
import 'package:flutterware/src/routing/app_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'theme/dark_theme.dart';
import 'theme/light_theme.dart';

class FlutterwareApp extends HookConsumerWidget {
  const FlutterwareApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final globalData = ref.watch(globalDataNotifierProvider);
    return KeyboardVisibilityProvider(
      child: KeyboardDismissOnTap(
        child: AsyncValueWidget(
          value: globalData,
          loading: () => const Material(
            child: Center(
              child: LoadingIndicator(),
            ),
          ),
          data: (_) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: goRouter,
            darkTheme: getDarkTheme(),
            theme: getLightTheme(),
            themeMode: ThemeMode.light,
          ),
        ),
      ),
    );
  }
}
