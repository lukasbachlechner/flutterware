import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutterware/src/features/products/data/products_repository.dart';
import 'package:flutterware/src/features/products/presentation/screens/single_product_screen.dart';
import 'package:flutterware/src/features/products/presentation/widgets/products_view/products_view.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../common_widgets/async_value_widget/async_value_widget.dart';

class HomeScreen extends HookConsumerWidget {
  static const path = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ProductsView();
    final input = useState(CriteriaInput(
      filter: [
        EqualsFilter(field: 'parentId', value: null),
      ],
    ));
    final getProductsValue = ref.watch(
      getAllProductsFutureProvider(),
    );

    return AsyncValueWidget(
      value: getProductsValue,
      data: (response) {
        final products = response.body!.elements
            .where((element) => element.name != '')
            .toList();
        return ListView.separated(
          itemBuilder: (context, index) => ListTile(
            leading: Image.network(products[index].cover?.media.url ?? ''),
            trailing: Visibility(
              visible: products[index].isMainProduct,
              child: const Chip(
                label: Text('child'),
              ),
            ),
            title: Text(products[index].name),
            onTap: () => context.goNamed(
              SingleProductScreen.name,
              params: {
                'productId': products[index].id.toString(),
              },
            ),
          ),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: products.length,
        );
      },
    );
  }
}
