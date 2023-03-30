import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  static const path = '/home';
  static const name = 'homeScreen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Placeholder();

    /* final input = useState(CriteriaInput(
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
    ); */
  }
}
