import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/page_wrap/page_wrap.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/features/global/data/global_data_notifier.dart';
import 'package:flutterware/src/features/menu/presentation/widgets/category_bar.dart';
import 'package:flutterware/src/features/search/presentation/widgets/search_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../common_widgets/async_value_widget/async_value_widget.dart';

class MenuScreen extends ConsumerWidget {
  static const path = '/menu';
  static const name = 'menuScreen';
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageWrap(
      child: SingleChildScrollView(
        child: AsyncValueWidget(
          skipLoadingOnRefresh: false,
          data: (globalData) {
            final categories = globalData.rootCategories;
            return Column(
              children: [
                const SearchBar(),
                ...categories
                    .map((category) => CategoryBar(category: category)),
                gapH16,
                // const DebugMenu(),
              ],
            );
          },
          value: ref.watch(globalDataNotifierProvider),
        ),
      ),
    );
  }
}
