import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/page_wrap/page_wrap.dart';
import 'package:flutterware/src/common_widgets/top_nav_bar/top_nav_bar.dart';
import 'package:flutterware/src/features/global/data/global_data_notifier.dart';
import 'package:flutterware/src/features/menu/presentation/widgets/category_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../../common_widgets/async_value_widget/async_value_widget.dart';
import '../../../products/presentation/widgets/products_view/products_view.dart';

class MenuSublevelScreen extends ConsumerWidget {
  static const path = '/menu-sub/:parentId';
  static const name = 'menuSublevel';

  final NavigationId parentId;
  final String title;
  final bool showProducts;

  const MenuSublevelScreen({
    super.key,
    required this.parentId,
    required this.title,
    this.showProducts = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageWrap(
      child: AsyncValueWidget(
        data: (globalData) {
          final categories = globalData.getChildCategories(ID(parentId.value));
          final currentCategory =
              globalData.getCategoryById(ID(parentId.value));

          return Column(
            children: [
              TopNavBar(title: title),
              if (currentCategory != null &&
                  !showProducts &&
                  categories.isNotEmpty)
                CategoryBar(
                  category: currentCategory,
                  title: 'All ${currentCategory.name}',
                  behaviour: CategoryBarBehaviour.showProducts,
                ),
              if (categories.isNotEmpty && !showProducts)
                ...categories.map((category) => CategoryBar(category: category))
              else
                Expanded(
                  child: ProductsView.category(
                    categoryId: ID(parentId.value),
                  ),
                ),
            ],
          );
        },
        value: ref.watch(globalDataNotifierProvider),
      ),
    );
  }
}
