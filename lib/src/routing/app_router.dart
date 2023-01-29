import 'package:flutter/material.dart';
import 'package:flutterware/src/features/authentication/presentation/account_screen.dart';
import 'package:flutterware/src/features/cart/screens/cart_screen.dart';
import 'package:flutterware/src/features/home/presentation/home_screen.dart';
import 'package:flutterware/src/features/menu/presentation/screens/menu_screen.dart';
import 'package:flutterware/src/features/menu/presentation/screens/menu_sublevel_screen.dart';
import 'package:flutterware/src/features/products/presentation/screens/single_product_screen.dart';
import 'package:flutterware/src/features/wishlist/presentation/wishlist_screen.dart';
import 'package:flutterware/src/routing/app_route_observer.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../features/menu/presentation/widgets/menu_shell.dart';
import 'app_shell.dart';
import 'not_found_screen.dart';

part 'app_router.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GlobalKey<NavigatorState> shellNavigatorKey(ShellNavigatorKeyRef ref) {
  return GlobalKey<NavigatorState>();
}

final menuShellNavigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    observers: [],
    initialLocation: '/home',
    navigatorKey: rootNavigatorKey,
    errorPageBuilder: (context, state) => NoTransitionPage(
      child: NotFoundScreen(error: state.error),
      key: state.pageKey,
    ),
    routes: [
      ShellRoute(
          navigatorKey: ref.watch(shellNavigatorKeyProvider),
          observers: [ref.watch(appRouteObserverProvider)],
          pageBuilder: (context, state, child) => NoTransitionPage(
                child: AppShell(child: child),
                key: state.pageKey,
                name: state.name,
              ),
          routes: [
            GoRoute(
                path: HomeScreen.path,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: HomeScreen()),
                routes: [
                  GoRoute(
                    path: SingleProductScreen.path,
                    name: SingleProductScreen.name,
                    builder: (context, state) => SingleProductScreen(
                      productId: ID(state.params['productId']!),
                    ),
                  ),
                ]),
            ShellRoute(
              pageBuilder: (context, state, child) => NoTransitionPage(
                child: MenuShell(child: child),
                key: state.pageKey,
              ),
              navigatorKey: menuShellNavigatorKey,
              routes: [
                GoRoute(
                  path: MenuScreen.path,
                  pageBuilder: (context, state) =>
                      const NoTransitionPage(child: MenuScreen()),
                  routes: const [],
                ),
                GoRoute(
                  path: MenuSublevelScreen.path,
                  name: MenuSublevelScreen.name,
                  builder: (context, state) => MenuSublevelScreen(
                    parentId: NavigationId(state.params['parentId']!),
                    title: state.queryParams['title'] ?? '',
                  ),
                ),
              ],
            ),
            GoRoute(
              path: WishlistScreen.path,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: WishlistScreen()),
            ),
            GoRoute(
              path: AccountScreen.path,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: AccountScreen()),
            ),
            GoRoute(
              path: CartScreen.path,
              name: CartScreen.name,
              parentNavigatorKey: ref.watch(shellNavigatorKeyProvider),
              builder: (context, state) => const CartScreen(),
            ),
          ])
    ],
  );
}
