import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'overlay_loading_notifier.g.dart';

@riverpod
class OverlayLoadingNotifier extends _$OverlayLoadingNotifier {
  @override
  bool build() {
    return false;
  }

  void show() {
    state = true;
  }

  void hide() {
    state = false;
  }
}

extension AddOverlayLoading on Ref {
  void showOverlay() {
    read(overlayLoadingNotifierProvider.notifier).show();
  }

  void hideOverlay() {
    read(overlayLoadingNotifierProvider.notifier).hide();
  }
}
