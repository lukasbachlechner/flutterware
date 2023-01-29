import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutterware/src/common_widgets/accordion/accordion.dart';
import 'package:flutterware/src/common_widgets/async_value_widget/async_value_widget.dart';
import 'package:flutterware/src/common_widgets/modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutterware/src/common_widgets/page_wrap/page_wrap.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/features/products/data/products_repository.dart';
import 'package:flutterware/src/features/products/presentation/widgets/product_app_bar.dart';
import 'package:flutterware/src/features/products/presentation/widgets/product_images.dart';
import 'package:flutterware/src/features/products/presentation/widgets/product_price.dart';
import 'package:flutterware/src/features/products/presentation/widgets/product_to_cart_modal.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopware6_client/shopware6_client.dart';

import '../../../cart/data/cart_button_provider.dart';

class SingleProductScreen extends HookConsumerWidget with RouteAware {
  final ID productId;
  const SingleProductScreen({super.key, required this.productId});

  static const path = 'products/:productId';
  static const name = 'singleProduct';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = useState(productId);

    final pageDataValue = ref.watch(
      getSingleProductPageDataFutureProvider(id.value),
    );

    useEffect(() {
      pageDataValue.whenData((response) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(cartButtonNotifierProvider.notifier).setAddToCartState(
                onPressed: () => FwBottomSheet.show(
                  context: context,
                  child: ProductToCartModal(
                    productId: productId,
                    variants: response.variants,
                    configurator: response.productResponse.body!.configurator,
                  ),
                ),
              );
        });
      });
      return null;
    }, [pageDataValue]);

    return PageWrap(
      child: AsyncValueWidget(
        value: pageDataValue,
        data: (response) {
          final product = response.productResponse.body!.product;
          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  /* CupertinoSliverRefreshControl(
                    builder: (context, refreshState, pulledExtent,
                        refreshTriggerPullDistance, refreshIndicatorExtent) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: CupertinoSliverRefreshControl.buildRefreshIndicator(
                          context,
                          refreshState,
                          pulledExtent,
                          refreshTriggerPullDistance,
                          refreshIndicatorExtent,
                        ),
                      );
                    },
                    onRefresh: () async => ref
                        .refresh(getSingleProductPageDataFutureProvider(id.value)),
                  ), */

                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductImages(
                          cover: product.cover,
                          media: product.media,
                        ),
                        gapH16,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.p16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              gapH8,
                              ProductPrice(
                                price: product.calculatedPrice!,
                              ),
                            ],
                          ),
                        ),
                        gapH40,
                        Accordion(items: [
                          AccordionItem(
                            body: Html(
                              data: product.description,
                              style: {
                                "body": Style(
                                  margin: EdgeInsets.zero,
                                ),
                              },
                              tagsList: Html.tags..remove('br'),
                            ),
                            title: 'Description',
                          ),
                          const AccordionItem(
                            body: SizedBox.shrink(),
                            title: 'Reviews',
                          ),
                          const AccordionItem(
                            body: SizedBox.shrink(),
                            title: 'Additional info',
                          )
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
              const ProductAppBar(),
            ],
          );
        },
      ),
    );
  }
}
