import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutterware/src/common_widgets/page_wrap/page_wrap.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/app_colors.dart';
import '../../data/checkout_notifier.dart';
import '../widgets/checkout_footer.dart';
import '../widgets/checkout_header.dart';

class CheckoutView extends HookConsumerWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    ref.listen(checkoutNotifierProvider, (prev, next) {
      scrollController.jumpTo(0.0);
    });

    return Scaffold(
      body: SafeArea(
        child: PageWrap(
          color: AppColors.white,
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              const SliverPersistentHeader(
                delegate: CheckoutHeaderDelegate(),
                pinned: true,
                floating: true,
              ),
              const SliverToBoxAdapter(
                child: gapH40,
              ),
              SliverToBoxAdapter(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: ref.watch(checkoutNotifierProvider).content,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CheckoutFooter(),
    );

    /*  return Scaffold(
      body: SafeArea(
        child: PageWrap(
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              const SliverPersistentHeader(
                delegate: CheckoutHeaderDelegate(),
                pinned: true,
                floating: true,
              ),
              const SliverToBoxAdapter(
                child: gapH40,
              ),
              /*  SliverToBoxAdapter(
                child: Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(checkoutNotifierProvider).content;
                  },
                ),
              ), */
              SliverFillRemaining(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: [
                    ...ref.watch(checkoutNotifierProvider.notifier).steps.map(
                          (step) => step.content,
                        ),
                  ],
                ),
              ),
              /* const SliverToBoxAdapter(
                child: gapH40,
              ), */
              const SliverToBoxAdapter(
                child: CartPriceDetails(),
              ),
              /*  const SliverToBoxAdapter(
                child: CheckoutFooter(),
              ), */
            ],
          ),
        ),
      ),
      //  bottomNavigationBar: const CheckoutFooter(),
    ); */
  }
}
