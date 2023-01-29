import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/async_value_widget/async_value_widget.dart';
import 'package:flutterware/src/common_widgets/button/button.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/constants/flutterware_icons.dart';
import 'package:flutterware/src/features/products/data/products_view/products_view_controller.dart';
import 'package:flutterware/src/features/products/presentation/widgets/products_view/product_grid_item.dart';
import 'package:flutterware/src/features/products/presentation/widgets/products_view/product_list_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopware6_client/shopware6_client.dart';

class ProductsViewFilterBar extends ConsumerWidget {
  final int totalCount;
  const ProductsViewFilterBar({super.key, required this.totalCount});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.p16),
      decoration: const BoxDecoration(
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
            '$totalCount Items',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: AppColors.greyPrimary),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
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

class ProductsView extends HookConsumerWidget {
  const ProductsView({super.key});

  Widget _buildList(
      List<Product> products, void Function(int index) renderCallback) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index + 1 == products.length) {
            renderCallback(index);
          }
          final product = products[index];
          return ProductListItem(
            product: product,
          );
        },
        childCount: products.length,
      ),
    );
  }

  Widget _buildGrid(
      List<Product> products, void Function(int index) renderCallback) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final leftIndex = index * 2;

          final rightIndex = leftIndex + 1;
          final hasRightItem = rightIndex + 1 < products.length;

          return Row(
            children: [
              Expanded(child: ProductGridItem(product: products[leftIndex])),
              Expanded(
                  child: hasRightItem
                      ? ProductGridItem(product: products[rightIndex])
                      : const SizedBox.shrink()),
            ],
          );
        },
        childCount: (products.length / 2).ceil(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: AsyncValueWidget(
        value: ref.watch(asyncPaginatedProductsControllerProvider),
        data: (paginationNotifierState) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ProductsViewFilterBar(
                  totalCount: paginationNotifierState.total,
                ),
              ),
              const SliverToBoxAdapter(
                child: gapH24,
              ),
              if (ref.watch(productViewModeProvider) == ProductViewMode.list)
                _buildList(
                    paginationNotifierState.products,
                    (index) => ref
                        .read(asyncPaginatedProductsControllerProvider.notifier)
                        .checkIndex(index))
              else
                _buildGrid(
                    paginationNotifierState.products,
                    (index) => ref
                        .read(asyncPaginatedProductsControllerProvider.notifier)
                        .checkIndex(index)),
              SliverVisibility(
                visible: paginationNotifierState.products.length <
                    paginationNotifierState.total,
                sliver: SliverToBoxAdapter(
                  child: Button(
                    label: 'Load more',
                    onPressed: () {
                      ref
                          .read(
                              asyncPaginatedProductsControllerProvider.notifier)
                          .nextPage();
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
/* 
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ProductsViewFilterBar(
              totalCount: paginationNotifierState.total,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final product = paginationNotifierState.products[index];
                return ListTile(
                  title: Text(product.name),
                );
              },
              childCount: paginationNotifierState.products.length,
            ),
          ),
          SliverToBoxAdapter(
            child: Button(
              label: 'Load more',
              onPressed: () {
                paginationNotifier.fetchMore();
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Button(
              label: 'New page',
              onPressed: () {
                context.push(CartScreen.path);
              },
            ),
          )
        ],
      ),
    ); */
  }
}
