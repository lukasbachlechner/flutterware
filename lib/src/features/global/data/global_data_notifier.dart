// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutterware/src/features/cart/data/cart_repository.dart';
import 'package:flutterware/src/features/global/data/context_repository.dart';
import 'package:flutterware/src/features/global/data/overlay_loading_notifier.dart';
import 'package:flutterware/src/features/products/data/categories_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:shopware6_client/shopware6_client.dart';

import '../../menu/data/categories_service.dart';
import 'local_storage_repository.dart';

part 'global_data_notifier.g.dart';

class GlobalData {
  final List<Category> categories;
  final CurrentContext currentContext;
  final List<Language> languages;
  final List<Country> countries;
  final List<Currency> currencies;
  final List<Salutation> salutations;
  final List<ShippingMethod> shippingMethods;
  final List<PaymentMethod> paymentMethods;

  const GlobalData({
    required this.categories,
    required this.currentContext,
    required this.languages,
    required this.countries,
    required this.currencies,
    required this.salutations,
    required this.shippingMethods,
    required this.paymentMethods,
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

  bool isCurrentLanguage(Language language) {
    return currentContext.salesChannel.languageId == language.id;
  }

  bool isCurrentCurrency(Currency currency) {
    return currentContext.currency.id == currency.id;
  }

  bool isCurrentCountry(Country country) {
    return currentContext.salesChannel.countryId == country.id;
  }

  Country currentCountry() {
    return countries.firstWhere(
      (country) => country.id == currentContext.salesChannel.countryId,
    );
  }

  Currency currentCurrency() {
    return currencies.firstWhere(
      (currency) => currency.id == currentContext.currency.id,
    );
  }

  Language currentLanguage() {
    return languages.firstWhere(
      (language) => language.id == currentContext.salesChannel.languageId,
    );
  }

  bool get isCustomerLoggedIn {
    return currentContext.customer != null;
  }

  Customer? get customer => currentContext.customer;

  bool isCurrentShippingMethod(ShippingMethod shippingMethod) {
    return currentContext.shippingMethod.id == shippingMethod.id;
  }

  bool isCurrentPaymentMethod(PaymentMethod paymentMethod) {
    return currentContext.paymentMethod.id == paymentMethod.id;
  }

  @override
  bool operator ==(covariant GlobalData other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return listEquals(other.categories, categories) &&
        other.currentContext == currentContext &&
        listEquals(other.languages, languages) &&
        listEquals(other.countries, countries) &&
        listEquals(other.currencies, currencies);
  }

  @override
  int get hashCode {
    return categories.hashCode ^
        currentContext.hashCode ^
        languages.hashCode ^
        countries.hashCode ^
        currencies.hashCode;
  }
}

@riverpod
class GlobalDataNotifier extends _$GlobalDataNotifier {
  @override
  FutureOr<GlobalData> build() async {
    return _fetch();
  }

  Future<GlobalData> _fetch() async {
    late final List<Category> categories;
    late final CurrentContext currentContext;
    late final List<Language> languages;
    late final List<Country> countries;
    late final List<Currency> currencies;
    late final List<Salutation> salutations;
    late final List<ShippingMethod> shippingMethods;
    late final List<PaymentMethod> paymentMethods;

    final contextRepository = ref.watch(contextRepositoryProvider);
    final categoriesRepository = ref.watch(categoriesRepositoryProvider);

    try {
      await Future.wait({
        contextRepository
            .fetchCurrentContext()
            .then((response) => currentContext = response.body!),
        categoriesRepository
            .getMainNavigation()
            .then((response) => categories = response.body!),
        contextRepository
            .fetchLanguages()
            .then((response) => languages = response.body!.elements),
        contextRepository
            .fetchCountries()
            .then((response) => countries = response.body!.elements),
        contextRepository
            .fetchCurrencies()
            .then((response) => currencies = response.body!),
        contextRepository
            .fetchSalutations()
            .then((response) => salutations = response.body!.elements),
        contextRepository
            .fetchShippingMethods(
              const CriteriaInput(associations: {'prices': []}),
            )
            .then((response) => shippingMethods = response.body!.elements),
        contextRepository
            .fetchPaymentMethods()
            .then((response) => paymentMethods = response.body!.elements),
      });
    } catch (e, st) {
      log('GlobalDataNotifier: $e', stackTrace: st);
      ref.read(localStorageRepositoryProvider).deleteContextToken();
      rethrow;
    }

    ref
        .read(localStorageRepositoryProvider)
        .saveContextToken(currentContext.token);

    return GlobalData(
      categories: categories,
      currentContext: currentContext,
      languages: languages,
      countries: countries,
      currencies: currencies,
      salutations: salutations,
      shippingMethods: shippingMethods,
      paymentMethods: paymentMethods,
    );
  }

  Future<void> updateContext(ContextPatchRequest contextPatchRequest) async {
    // state = const AsyncLoading();
    // ref.read(overlayLoadingNotifierProvider.notifier).show();
    ref.showOverlay();

    final contextRepository = ref.watch(contextRepositoryProvider);
    await contextRepository.modifyCurrentContext(
      contextPatchRequest,
    );

    ref.invalidate(cartNotifierProvider);

    final globalData = await _fetch();
    state = AsyncData(globalData);

    ref.hideOverlay();
  }
}
