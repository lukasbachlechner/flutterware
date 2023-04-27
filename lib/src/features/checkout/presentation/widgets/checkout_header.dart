import 'package:flutter/material.dart';
import 'package:flutterware/src/features/checkout/presentation/widgets/checkout_top_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'steps_rail/checkout_steps_rail.dart';

class CheckoutHeader extends ConsumerWidget {
  const CheckoutHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.white,
      elevation: 4,
      child: Column(
        children: const [
          CheckoutTopBar(),
          CheckoutStepsRail(),
        ],
      ),
    );
  }
}

class CheckoutHeaderDelegate extends SliverPersistentHeaderDelegate {
  const CheckoutHeaderDelegate();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return const CheckoutHeader();
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 100;

  @override
  // TODO: implement minExtent
  double get minExtent => 100;
}
