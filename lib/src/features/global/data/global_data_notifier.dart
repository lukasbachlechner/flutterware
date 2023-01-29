import 'package:flutterware/src/constants/app_config.dart';
import 'package:flutterware/src/features/products/data/categories_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopware6_client/shopware6_client.dart';

part 'global_data_notifier.g.dart';

class GlobalData {
  final List<Category> categories;

  const GlobalData({required this.categories});

  /// This is ugly, I know :D
  static List<Category> sortCategories(List<Category> unsorted) {
    final sorted = <Category>[];

    if (unsorted.isEmpty) {
      return unsorted;
    }

    final first = unsorted.firstWhere(
      (element) => element.afterCategoryId == null,
    );

    sorted.add(first);

    for (var i = 0; i < unsorted.length - 1; i++) {
      sorted.add(unsorted.firstWhere(
        (element) => element.afterCategoryId == sorted[i].id,
      ));
    }

    return sorted;
  }

  List<Category> get rootCategories {
    final rootCategories = categories
        .where(
          (category) => category.parentId == AppConfig.navigationEntryPointId,
        )
        .toList();

    return sortCategories(rootCategories);
  }

  List<Category> getChildCategories(ID parentId) {
    final children = categories
        .where(
          (category) => category.parentId == parentId,
        )
        .toList();

    return sortCategories(children);
  }
}

@riverpod
class GlobalDataNotifier extends _$GlobalDataNotifier {
  @override
  FutureOr<GlobalData> build() async {
    final futures = await Future.wait([
      ref.watch(categoriesRepositoryProvider).getNavigationMenu(
            const NavigationId.mainNavigation(),
            const NavigationId.mainNavigation(),
          ),
    ]);

    final categoriesResponse = futures[0];

    return GlobalData(categories: categoriesResponse.body!);
  }
}
