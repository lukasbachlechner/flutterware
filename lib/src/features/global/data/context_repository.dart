import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../api/shopware_client.dart';

part 'context_repository.g.dart';

class ContextRepository {
  final ShopwareClient client;
  late final ContextService contextService;

  ContextRepository(this.client) {
    contextService = client.context;
  }

  Future<Response<CurrentContext>> fetchCurrentContext() {
    return contextService.fetchCurrentContext();
  }

  Future<Response<ContextPatchResponse>> modifyCurrentContext(
    ContextPatchRequest contextPatchRequest,
  ) {
    return contextService.modifyCurrentContext(contextPatchRequest);
  }
}

@riverpod
ContextRepository contextRepository(ContextRepositoryRef ref) {
  final client = ref.watch(shopwareClientProvider);
  return ContextRepository(client);
}
