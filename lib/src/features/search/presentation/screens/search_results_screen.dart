import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/page_wrap/page_wrap.dart';
import 'package:flutterware/src/common_widgets/top_nav_bar/top_nav_bar.dart';
import 'package:flutterware/src/features/products/presentation/widgets/products_view/products_view.dart';

class SearchResultsScreen extends StatelessWidget {
  static const name = 'searchResults';
  static const path = 'results';

  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      child: Column(
        children: const [
          TopNavBar(title: 'Results'),
          Expanded(
            child: ProductsView.search(search: 'product'),
          )
        ],
      ),
    );
  }
}
