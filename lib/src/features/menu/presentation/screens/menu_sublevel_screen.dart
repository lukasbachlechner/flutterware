import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/page_wrap/page_wrap.dart';
import 'package:flutterware/src/common_widgets/top_nav_bar/top_nav_bar.dart';
import 'package:flutterware/src/features/global/data/global_data_notifier.dart';
import 'package:flutterware/src/features/menu/presentation/widgets/category_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../../common_widgets/async_value_widget/async_value_widget.dart';

class MenuSublevelScreen extends ConsumerWidget {
  static const path = '/menu-sub/:parentId';
  static const name = 'menuSublevel';

  final NavigationId parentId;
  final String title;

  const MenuSublevelScreen({
    super.key,
    required this.parentId,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageWrap(
      child: AsyncValueWidget(
        data: (globalData) {
          final categories = globalData.getChildCategories(ID(parentId.value));

          return Column(
            children: [
              TopNavBar(title: title),
              ...categories.map((category) => CategoryBar(category: category))
            ],
          );
        },
        value: ref.watch(globalDataNotifierProvider),
      ),
    );
  }
}
