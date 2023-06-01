import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterware/src/api/shopware_client.dart';
import 'package:flutterware/src/theme/light_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../mock/mock_shopware_client.dart';
import '../test_wrapper.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpWrapperApp(
    Widget widget,
  ) async {
    await pumpWidget(
      _withProviderScope(
        TestWrapper(child: widget),
      ),
    );
  }

  ProviderScope _withProviderScope(Widget child) {
    return ProviderScope(
      overrides: [
        shopwareClientProvider.overrideWithValue(
          getMockShopwareClient(),
        ),
      ],
      child: child,
    );
  }

  Future<void> pumpWrapperAppWithRouter(
    Widget widget, {
    required List<GoRoute> routes,
    List<NavigatorObserver> observers = const [],
  }) async {
    const initialRoute = '/_initial';

    final router = GoRouter(
      initialLocation: initialRoute,
      observers: observers,
      routes: [
        GoRoute(
          path: initialRoute,
          builder: (context, state) => widget,
        ),
        ...routes,
      ],
    );

    await pumpWidget(
      _withProviderScope(
        MaterialApp.router(
          routerConfig: router,
          theme: getLightTheme(),
          themeMode: ThemeMode.light,
        ),
      ),
    );
  }
}
