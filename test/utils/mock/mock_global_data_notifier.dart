import 'dart:async';
import 'dart:developer';

import 'package:flutterware/src/features/global/data/context_repository.dart';
import 'package:flutterware/src/features/global/data/global_data_notifier.dart';
import 'package:flutterware/src/features/global/data/local_storage_repository.dart';
import 'package:flutterware/src/features/products/data/categories_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopware6_client/shopware6_client.dart';

class MockGlobalDataNotifier extends AutoDisposeAsyncNotifier<GlobalData>
    implements GlobalDataNotifier {
  @override
  FutureOr<GlobalData> build() async {
    return await _fetch();

    /*   return GlobalData(
      categories: [],
      currentContext: originalContext.currentContext,
      languages: [],
      countries: [],
      currencies: [],
      salutations: [],
      shippingMethods: [],
      paymentMethods: [],
    ); */
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

  @override
  Future<void> updateContext(ContextPatchRequest contextPatchRequest) {
    // TODO: implement updateContext
    throw UnimplementedError();
  }
}
