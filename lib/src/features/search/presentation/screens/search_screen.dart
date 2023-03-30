import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutterware/src/common_widgets/button/button.dart';
import 'package:flutterware/src/common_widgets/page_wrap/page_wrap.dart';
import 'package:flutterware/src/features/products/presentation/widgets/products_view/products_view.dart';
import 'package:flutterware/src/features/search/presentation/widgets/search_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchScreen extends HookConsumerWidget {
  static const path = '/search';
  static const name = 'searchPage';

  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = useState('');
    void setQuery(String newQuery) {
      if (newQuery.length > 3) {
        query.value = newQuery;
      } else {
        query.value = '';
      }
    }

    return Column(
      children: [
        SearchBar(
          showLeading: false,
          isAbsorbing: false,
          onChanged: setQuery,
        ),
        if (query.value.isNotEmpty) ...[
          Expanded(
            child: PageWrap(
              child: ProductsView.search(search: query.value),
            ),
          ),
          Button(
            label: 'Close',
            buttonSize: ButtonSize.fullWidth,
            buttonType: ButtonType.primaryBlack,
            onPressed: () => context.pop(),
          ),
        ]
      ],
    );
  }
}
