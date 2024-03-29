import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/features/authentication/presentation/screens/account_screen.dart';
import 'package:flutterware/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:flutterware/src/features/authentication/presentation/screens/signup_screen.dart';
import 'package:flutterware/src/features/cart/screens/cart_screen.dart';
import 'package:flutterware/src/features/checkout/presentation/screens/checkout_confirmation_screen.dart';
import 'package:flutterware/src/features/checkout/presentation/screens/checkout_screen.dart';
import 'package:flutterware/src/features/home/presentation/home_screen.dart';
import 'package:flutterware/src/features/menu/presentation/screens/menu_screen.dart';
import 'package:flutterware/src/features/menu/presentation/screens/menu_sublevel_screen.dart';
import 'package:flutterware/src/features/search/presentation/screens/search_screen.dart';
import 'package:flutterware/src/features/products/presentation/screens/single_product_screen.dart';
import 'package:flutterware/src/features/wishlist/presentation/wishlist_screen.dart';
import 'package:flutterware/src/routing/app_route_observer.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopware6_client/shopware6_client.dart';

import 'app_shell.dart';
import 'not_found_screen.dart';

part 'app_router.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GlobalKey<NavigatorState> shellNavigatorKey(ShellNavigatorKeyRef ref) {
  return GlobalKey<NavigatorState>();
}

final menuShellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createGoRouter({
  required GlobalKey<NavigatorState> rootNavigatorKey,
  required GlobalKey<NavigatorState> menuShellNavigatorKey,
  required GlobalKey<NavigatorState> shellNavigatorKey,
  required List<NavigatorObserver> observers,
  String? initialLocation,
  Widget? initialLocationWidget,
}) {
  return GoRouter(
    observers: [],
    initialLocation: initialLocation ?? '/home',
    navigatorKey: rootNavigatorKey,
    errorPageBuilder: (context, state) => NoTransitionPage(
      child: NotFoundScreen(error: state.error),
      key: state.pageKey,
    ),
    routes: [
      if (initialLocation != null && initialLocationWidget != null)
        GoRoute(
          path: initialLocation,
          builder: (context, state) => initialLocationWidget,
        ),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        observers: observers,
        pageBuilder: (context, state, child) => NoTransitionPage(
          child: AppShell(child: child),
          key: state.pageKey,
          name: state.name,
        ),
        routes: [
          GoRoute(
              path: HomeScreen.path,
              name: HomeScreen.name,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: HomeScreen()),
              routes: [
                GoRoute(
                  path: SingleProductScreen.path,
                  name: SingleProductScreen.name,
                  parentNavigatorKey: shellNavigatorKey,
                  builder: (context, state) => SingleProductScreen(
                    productId: ID(state.params['productId']!),
                  ),
                ),
              ]),
          ShellRoute(
            pageBuilder: (context, state, child) => NoTransitionPage(
              child: child,
              key: state.pageKey,
            ),
            navigatorKey: menuShellNavigatorKey,
            routes: [
              GoRoute(
                path: MenuScreen.path,
                name: MenuScreen.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: const MenuScreen(),
                  key: state.pageKey,
                ),
              ),
              GoRoute(
                path: MenuSublevelScreen.path,
                name: MenuSublevelScreen.name,
                parentNavigatorKey: menuShellNavigatorKey,
                builder: (context, state) => MenuSublevelScreen(
                  key: state.pageKey,
                  parentId: NavigationId(state.params['parentId']!),
                  title: state.queryParams['title'] ?? '',
                  showProducts: state.queryParams['showProducts'] == 'true',
                ),
              ),
            ],
          ),
          GoRoute(
            path: WishlistScreen.path,
            name: WishlistScreen.name,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: WishlistScreen()),
          ),
          GoRoute(
            path: AccountScreen.path,
            name: AccountScreen.name,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: AccountScreen()),
          ),
          GoRoute(
            path: CartScreen.path,
            name: CartScreen.name,
            parentNavigatorKey: shellNavigatorKey,
            builder: (context, state) => const CartScreen(),
          ),
          GoRoute(
            path: SearchScreen.path,
            name: SearchScreen.name,
            parentNavigatorKey: shellNavigatorKey,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return SearchPage(
                key: state.pageKey,
                child: const SearchScreen(),
              );
            },
            builder: (context, state) => SearchScreen(
              key: state.pageKey,
            ),
          ),
        ],
      ),
      GoRoute(
        path: LoginScreen.path,
        name: LoginScreen.name,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: SignupScreen.path,
        name: SignupScreen.name,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: CheckoutScreen.path,
        name: CheckoutScreen.name,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: CheckoutConfirmationScreen.path,
        name: CheckoutConfirmationScreen.name,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const CheckoutConfirmationScreen(),
      ),
    ],
  );
}

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  return createGoRouter(
    rootNavigatorKey: rootNavigatorKey,
    menuShellNavigatorKey: menuShellNavigatorKey,
    shellNavigatorKey: ref.watch(shellNavigatorKeyProvider),
    observers: [
      ref.watch(appRouteObserverProvider),
    ],
  );
}

class SearchPage extends CustomTransitionPage<void> {
  SearchPage({
    super.key,
    required super.child,
  }) : super(
          opaque: false,
          barrierColor: AppColors.blackPrimary.withOpacity(0.2),
          barrierDismissible: true,
          fullscreenDialog: true,
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            // Change the opacity of the screen using a Curve based on the the animation's
            // value
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            );
          },
        );
}
