import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/list_tile/list_tile.dart';
import 'package:shopware6_client/shopware6_client.dart';

class SearchSuggestItem extends StatelessWidget {
  final VoidCallback? onTap;
  final Product product;
  const SearchSuggestItem({
    super.key,
    this.onTap,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return FwListTile(
      title: product.name,
      onTap: onTap,
    );
  }
}
