import 'package:shopware6_client/shopware6_client.dart';

ProductSorting createProductSorting({
  required String key,
  required int priority,
  String? label,
}) {
  return ProductSorting(
    key: key,
    priority: priority,
    label: label ?? 'ProductSorting $key',
    createdAt: DateTime.now(),
  );
}
