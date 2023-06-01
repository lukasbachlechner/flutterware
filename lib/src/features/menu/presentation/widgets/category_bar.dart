import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/list_tile/list_tile.dart';
import 'package:go_router/go_router.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../screens/menu_sublevel_screen.dart';

enum CategoryBarBehaviour { showSub, showProducts }

class CategoryBar extends StatelessWidget {
  final Category category;
  final String? title;
  final CategoryBarBehaviour behaviour;
  final VoidCallback? onTap;

  const CategoryBar({
    super.key,
    required this.category,
    this.title,
    this.behaviour = CategoryBarBehaviour.showSub,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FwListTile(
      onTap: () {
        if (onTap != null) {
          onTap!();
          return;
        }

        context.pushNamed(
          MenuSublevelScreen.name,
          params: {
            'parentId': category.id.toString(),
          },
          queryParams: {
            'title': category.name,
            'showProducts':
                (behaviour == CategoryBarBehaviour.showProducts).toString()
          },
        );
      },
      title: title ?? category.name,
    );
  }
}
