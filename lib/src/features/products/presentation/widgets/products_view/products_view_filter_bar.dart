import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/constants/flutterware_icons.dart';
import 'package:flutterware/src/features/products/data/products_view/products_view_controller.dart';
import 'package:flutterware/src/features/products/presentation/widgets/filter_dialog/filter_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductsViewFilterBar extends ConsumerWidget {
  final ProductsViewState providerState;
  final ProductsViewNotifier providerNotifier;
  const ProductsViewFilterBar({
    super.key,
    required this.providerState,
    required this.providerNotifier,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.p16),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.greyLightAccent),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => ref.read(productViewModeProvider.notifier).state =
                ProductViewMode.grid,
            child: const Icon(
              FlutterwareIcons.boxView,
            ),
          ),
          gapW8,
          GestureDetector(
            onTap: () => ref.read(productViewModeProvider.notifier).state =
                ProductViewMode.list,
            child: const Icon(
              FlutterwareIcons.listIcon,
            ),
          ),
          const Spacer(),
          Text(
            '${providerState.totalCount} Items',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: AppColors.greyPrimary),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              FilterDialog.show(
                context,
                providerState,
                providerNotifier,
              );
            },
            child: Row(
              children: [
                Text(
                  'Filters',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .apply(color: AppColors.blackSecondary),
                ),
                gapW4,
                const Icon(FlutterwareIcons.filter),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ProductsViewFilterBarDelegate implements SliverPersistentHeaderDelegate {
  final ProductsViewState providerState;
  final ProductsViewNotifier providerNotifier;

  ProductsViewFilterBarDelegate({
    required this.providerState,
    required this.providerNotifier,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ProductsViewFilterBar(
      providerState: providerState,
      providerNotifier: providerNotifier,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 50;

  @override
  // TODO: implement minExtent
  double get minExtent => 50;

  @override
  bool shouldRebuild(ProductsViewFilterBarDelegate oldDelegate) =>
      oldDelegate.providerState.totalCount != providerState.totalCount;

  @override
  // TODO: implement showOnScreenConfiguration
  PersistentHeaderShowOnScreenConfiguration? get showOnScreenConfiguration =>
      const PersistentHeaderShowOnScreenConfiguration();

  @override
  // TODO: implement snapConfiguration
  FloatingHeaderSnapConfiguration? get snapConfiguration =>
      FloatingHeaderSnapConfiguration();

  @override
  // TODO: implement stretchConfiguration
  OverScrollHeaderStretchConfiguration? get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration();

  @override
  // TODO: implement vsync
  TickerProvider? get vsync => null;
}
