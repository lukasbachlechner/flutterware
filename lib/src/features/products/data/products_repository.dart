import 'package:flutterware/src/api/shopware_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopware6_client/shopware6_client.dart';

part 'products_repository.g.dart';

class ProductsRepository {
  final ShopwareClient client;
  late final ProductService productService;
  ProductsRepository(this.client) {
    productService = client.getService<ProductService>();
  }

  Future<Response<ProductCriteriaResponse>> getAll(CriteriaInput input) {
    return client.products.getAll(input);
  }

  Future<Response<ProductCriteriaResponse>> byCategoryId(
      ID categoryId, ProductListingCriteriaInput input) {
    return client.products.byCategoryId(categoryId, input);
  }

  Future<Response<ProductDetailResponse>> get(ID id) {
    return client.products.get(
      id,
      const CriteriaInput(
        associations: {
          'media': {},
        },
      ),
    );
  }
}

@Riverpod(keepAlive: true)
ProductsRepository productsRepository(ProductsRepositoryRef ref) {
  final client = ref.watch(shopwareClientProvider);
  return ProductsRepository(client);
}

@Riverpod(keepAlive: true)
Future<Response<ProductCriteriaResponse>> getAllProductsFuture(
  GetAllProductsFutureRef ref, {
  int limit = 1,
  int page = 1,
  List<Filter>? filter,
  List<ID>? ids,
}) {
  final productsRepository = ref.watch(productsRepositoryProvider);

  return productsRepository.getAll(
    CriteriaInput(
      filter: filter,
      ids: ids,
      limit: limit,
      page: page,
    ),
  );
}

@Riverpod(keepAlive: true)
Future<Response<ProductDetailResponse>> getSingleProductFuture(
  GetSingleProductFutureRef ref,
  ID id,
) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.get(id);
}

class SingleProductPageData {
  final Response<ProductDetailResponse> productResponse;
  final List<Product>? variants;

  const SingleProductPageData({
    required this.productResponse,
    this.variants,
  });
}

class PropertyGroupOptionWithProductId {
  final ID productId;
  final bool isAvailable;
  final PropertyGroupOption propertyGroupOption;

  PropertyGroupOptionWithProductId({
    required this.productId,
    required this.propertyGroupOption,
    this.isAvailable = true,
  });
}

@Riverpod(keepAlive: true)
Future<SingleProductPageData> getSingleProductPageDataFuture(
  GetSingleProductPageDataFutureRef ref,
  ID id,
) async {
  final productsRepository = ref.watch(productsRepositoryProvider);
  final productResponse = await productsRepository.get(id);

  List<Product> availableVariants = [];
  final configurator = productResponse.body?.configurator ?? [];

  if (configurator.isNotEmpty) {
    final variantResponse = await productsRepository.getAll(
      CriteriaInput(
        filter: [
          EqualsFilter(field: 'parentId', value: id.value),
        ],
      ),
    );

    availableVariants = variantResponse.body!.elements;
  }

  return SingleProductPageData(
    productResponse: productResponse,
    variants: availableVariants.isNotEmpty ? availableVariants : null,
  );
}
