import 'package:flutter/material.dart';
import 'package:flutterware/src/features/global/data/global_data_notifier.dart';
import 'package:flutterware/src/features/menu/presentation/widgets/category_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../common_widgets/async_value_widget/async_value_widget.dart';

class MenuScreen extends ConsumerWidget {
  static const path = '/menu';
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      data: (globalData) {
        final categories = globalData.rootCategories;

        return ListView.builder(
          itemBuilder: (context, index) => CategoryBar(
            category: categories[index],
          ),
          itemCount: categories.length,
        );
      },
      value: ref.watch(globalDataNotifierProvider),
    );
  }
}
