import 'dart:convert';

import 'package:shopware6_client/shopware6_client.dart';

import '../fixtures/fixture.dart';
import '../id_generator.dart';

Future<Product> createProductFromFixture() async {
  final jsonString = await const Fixture('product/[id]').get();
  final json = jsonDecode(jsonString);

  return Product.fromJson(json['product']);
}

Product createProduct({
  ID? id,
  String? name,
}) {
  final idToUse = id ?? IDGenerator.generate();
  return Product(
    id: idToUse,
    taxId: IDGenerator.generate(),
    productNumber: 'productNumber',
    stock: 1,
    name: name ?? 'Product $idToUse',
    createdAt: DateTime.now(),
  );
}

ID getFixtureProductId() {
  // Hardcoded ID from fixtures
  return ID("176b6c013f5b4ac7a6bb13219a2fd969");
}

ProductCriteriaResponse createProductCriteriaResponse({
  required ID resultProductId,
}) {
  return ProductCriteriaResponse(
    elements: [
      createProduct(
        id: resultProductId,
      ),
    ],
    listingAggregations: ListingAggregations(),
  );
}

ProductMedia createProductMedia() {
  return ProductMedia(
    productId: IDGenerator.generate(),
    mediaId: IDGenerator.generate(),
    createdAt: DateTime.now(),
    media: Media(
      createdAt: DateTime.now(),
    ),
  );
}
