import 'package:shopware6_client/shopware6_client.dart';

import '../id_generator.dart';

Category createCategory({
  ID? id,
  String? name,
  ID? parentId,
  ID? afterCategoryId,
}) {
  final idToUse = id ?? IDGenerator.generate();
  return Category(
    id: idToUse,
    afterCategoryId: afterCategoryId,
    parentId: parentId,
    displayNestedProducts: true,
    type: '',
    productAssignmentType: '',
    name: name ?? 'Category $idToUse',
    createdAt: DateTime.now(),
  );
}
