import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../loading_indicator/loading_indicator.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final Widget Function()? loading;
  final bool skipLoadingOnRefresh;

  const AsyncValueWidget({
    super.key,
    required this.data,
    required this.value,
    this.loading,
    this.skipLoadingOnRefresh = true,
  });

  Widget _handleError(String message) {
    return Center(
      child: Text(message),
    );
  }

  @override
  Widget build(BuildContext context) {
    return value.when(
      skipLoadingOnRefresh: skipLoadingOnRefresh,
      data: (responseData) {
        if (responseData is Response && responseData.error != null) {
          return _handleError(responseData.error.toString());
        }
        return data(responseData);
      },
      error: (error, stackTrace) => _handleError(error.toString()),
      loading: loading != null
          ? loading!
          : () => const Center(
                child: LoadingIndicator(),
              ),
    );
  }
}
