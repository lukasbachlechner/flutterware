import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutterware/src/features/products/data/products_view/products_view_controller.dart';
import 'package:flutterware/src/features/products/presentation/widgets/products_view/product_grid_item.dart';
import 'package:flutterware/src/features/products/presentation/widgets/products_view/product_list_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../../../common_widgets/async_value_widget/async_value_widget.dart';
import '../../../../../constants/app_sizes.dart';
import '../../../data/products_view/products_view_filter.dart';
import 'products_view_filter_bar.dart';

class ProductsView extends HookConsumerWidget {
  final ID? categoryId;
  final String? search;
  final ProductsViewType _type;

  const ProductsView.search({super.key, required this.search})
      : categoryId = null,
        _type = ProductsViewType.search;

  const ProductsView.category({super.key, required this.categoryId})
      : search = null,
        _type = ProductsViewType.byCategoryId;

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
    // Get the correct instance of the provider
    final providerInstance = productsViewNotifierProvider(
      _type,
      _type == ProductsViewType.byCategoryId ? categoryId : search,
    );

    final productsViewNotifierState = ref.watch(providerInstance);
    final productsViewNotifier = ref.watch(providerInstance.notifier);

    useEffect(() {
      // Clean up & dispose of the filter provider when this widget is disposed
      return () => ref.invalidate(productsViewFilterProvider);
    }, []);

    return AsyncValueWidget(
      value: productsViewNotifierState,
      data: (state) {
        return CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: ProductsViewFilterBarDelegate(
                providerState: state,
                providerNotifier: productsViewNotifier,
              ),
              pinned: true,
            ),
            const SliverToBoxAdapter(
              child: gapH24,
            ),
            if (ref.watch(productViewModeProvider) == ProductViewMode.list)
              _buildList(
                state.records,
                (index) {},
              )
            else
              _buildGrid(
                state.records,
                (index) {},
              ),

            /*  SliverVisibility(
              visible: state.hasMore,
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
            ), */
          ],
        );
      },
    );
  }
}
