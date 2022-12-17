import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/flutterware_icons.dart';

class FwBottomNavigationBar extends StatelessWidget {
  const FwBottomNavigationBar({
    super.key,
  });

  Widget _buildItem({required Widget icon, required String label}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        Text(label),
      ],
    );
  }

  Widget _buildFabPlaceholder({required String label}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 24,
          width: 66,
        ),
        Text(label),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: BottomAppBar(
        color: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildItem(
                icon: const Icon(
                  FlutterwareIcons.home,
                ),
                label: 'Home',
              ),
              _buildItem(
                icon: const Icon(FlutterwareIcons.menu),
                label: 'Menu',
              ),
              _buildItem(
                icon: const Icon(FlutterwareIcons.favorites),
                label: 'Wishlist',
              ),
              _buildItem(
                icon: const Icon(FlutterwareIcons.account),
                label: 'Account',
              ),
              _buildFabPlaceholder(label: 'Cart'),
            ],
          ),
        ),
      ),
    );
  }
}
