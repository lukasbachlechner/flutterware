import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../api/shopware_client.dart';

part 'context_repository.g.dart';

class ContextRepository {
  final ShopwareClient client;
  late final ContextService contextService;
  late final SystemService systemService;
  late final PaymentMethodService paymentMethodService;

  ContextRepository(this.client) {
    contextService = client.context;
    systemService = client.system;
    paymentMethodService = client.paymentMethod;
  }

  Future<Response<CurrentContext>> fetchCurrentContext() {
    return contextService.fetchCurrentContext();
  }

  Future<Response<ContextPatchResponse>> modifyCurrentContext(
    ContextPatchRequest contextPatchRequest,
  ) {
    return contextService.modifyCurrentContext(contextPatchRequest);
  }

  Future<Response<List<Currency>>> fetchCurrencies([
    CriteriaInput? criteriaInput,
  ]) {
    return systemService.fetchCurrencies(criteriaInput);
  }

  Future<Response<LanguageCriteriaResponse>> fetchLanguages([
    CriteriaInput? criteriaInput,
  ]) {
    return systemService.fetchLanguages(criteriaInput);
  }

  Future<Response<CountryCriteriaResponse>> fetchCountries([
    CriteriaInput? criteriaInput,
  ]) {
    return systemService.fetchCountries(criteriaInput);
  }

  Future<Response<SalutationCriteriaResponse>> fetchSalutations([
    CriteriaInput? criteriaInput,
  ]) {
    return systemService.fetchSalutations(criteriaInput);
  }

  Future<Response<ShippingMethodCriteriaResponse>> fetchShippingMethods([
    CriteriaInput? criteriaInput,
    bool onlyAvailable = true,
  ]) {
    return systemService.fetchShippingMethods(
      criteriaInput,
      onlyAvailable: onlyAvailable,
    );
  }

  Future<Response<PaymentMethodCriteriaResponse>> fetchPaymentMethods([
    CriteriaInput? criteriaInput,
    bool onlyAvailable = true,
  ]) {
    return paymentMethodService.getPaymentMethods();
  }
}

@riverpod
ContextRepository contextRepository(ContextRepositoryRef ref) {
  final client = ref.watch(shopwareClientProvider);
  return ContextRepository(client);
}
