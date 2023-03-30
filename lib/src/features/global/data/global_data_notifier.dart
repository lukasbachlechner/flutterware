import 'package:flutterware/src/features/global/data/context_repository.dart';
import 'package:flutterware/src/features/products/data/categories_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../menu/data/categories_service.dart';
import 'local_storage_repository.dart';

part 'global_data_notifier.g.dart';

class GlobalData {
  final List<Category> categories;
  final CurrentContext currentContext;

  const GlobalData({
    required this.categories,
    required this.currentContext,
  });

  List<Category> get rootCategories {
    return CategoriesService.getRootCategories(
      categories: categories,
      navigationCategoryId: currentContext.salesChannel.navigationCategoryId,
    );
  }

  List<Category> getChildCategories(ID parentId) {
    return CategoriesService.getChildCategories(
      categories: categories,
      parentId: parentId,
    );
  }

  Category? getCategoryById(ID categoryId) {
    return CategoriesService.getCategoryById(
      categories: categories,
      categoryId: categoryId,
    );
  }
}

@riverpod
class GlobalDataNotifier extends _$GlobalDataNotifier {
  @override
  FutureOr<GlobalData> build() async {
    late final List<Category> categories;
    late final CurrentContext currentContext;

    await Future.wait({
      ref
          .watch(contextRepositoryProvider)
          .fetchCurrentContext()
          .then((response) => currentContext = response.body!),
      ref
          .watch(categoriesRepositoryProvider)
          .getMainNavigation()
          .then((response) => categories = response.body!),
    });

    ref
        .read(localStorageRepositoryProvider)
        .saveContextToken(currentContext.token);

    /*  final categoriesResponse = futures[0] as Response<List<Category>>;
    final contextResponse = futures[1] as Response<CurrentContext>; */

    return GlobalData(
      categories: categories,
      currentContext: currentContext,
    );
  }
}
