import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/constants/flutterware_icons.dart';
import 'package:flutterware/src/features/authentication/presentation/account_screen.dart';
import 'package:flutterware/src/features/cart/data/cart_button_provider.dart';
import 'package:flutterware/src/features/home/presentation/home_screen.dart';
import 'package:flutterware/src/features/menu/presentation/screens/menu_screen.dart';
import 'package:flutterware/src/features/wishlist/presentation/wishlist_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FwBottomNavigationBar extends ConsumerWidget {
  const FwBottomNavigationBar({
    super.key,
  });

  Widget _buildFabPlaceholder({required String label}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 24,
          width: AppSizes.fabSize,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final safeBottomInset = MediaQuery.of(context).padding.bottom;
    return SizedBox(
      height: 60 + safeBottomInset,
      child: BottomAppBar(
        color: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 16.0, top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              const FwBottomNavigationBarItem(
                icon: FlutterwareIcons.home,
                label: 'Home',
                path: HomeScreen.path,
              ),
              const FwBottomNavigationBarItem(
                icon: FlutterwareIcons.menu,
                label: 'Menu',
                path: MenuScreen.path,
              ),
              const FwBottomNavigationBarItem(
                icon: FlutterwareIcons.favorites,
                label: 'Wishlist',
                path: WishlistScreen.path,
              ),
              const FwBottomNavigationBarItem(
                icon: FlutterwareIcons.account,
                label: 'Account',
                path: AccountScreen.path,
              ),
              _buildFabPlaceholder(
                label: ref.watch(cartButtonNotifierProvider).text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FwBottomNavigationBarItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final String path;

  const FwBottomNavigationBarItem({
    super.key,
    required this.label,
    required this.icon,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = GoRouter.of(context).location.startsWith(path);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => context.go(path),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.primaryColor : null,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            label,
            style: TextStyle(
              color: isActive ? AppColors.primaryColor : null,
              fontWeight: FontWeight.w300,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
