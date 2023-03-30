import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutterware/src/common_widgets/image/image.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:shopware6_client/shopware6_client.dart';

class ProductImages extends HookWidget {
  final ProductMedia? cover;
  final List<ProductMedia>? media;

  const ProductImages({super.key, this.cover, this.media});

  @override
  Widget build(BuildContext context) {
    final activeIndex = useState(0);

    if (media == null || media!.length <= 1) {
      return AspectRatio(
        aspectRatio: 375 / 600,
        child: Container(
            color: AppColors.white,
            child: FwImage(src: cover?.media.url ?? '')),
      );
    } else {
      final imageSrcList = media!.map(
        (item) => item.media.thumbnails
            ?.firstWhere(
              (thumbnail) => thumbnail.width > 1000,
            )
            .url,
      );
      final imageWidgetList = imageSrcList
          .map(
            (url) => FwImage(
              src: url ?? '',
              fit: BoxFit.contain,
              width: 1000,
            ),
          )
          .toList();
      return Stack(
        children: [
          Container(
            color: AppColors.white,
            child: CarouselSlider(
              items: imageWidgetList,
              options: CarouselOptions(
                onPageChanged: (index, _) => activeIndex.value = index,
                enableInfiniteScroll: false,
                viewportFraction: 1,
                aspectRatio: 375 / 600,
              ),
            ),
          ),
          Positioned(
              bottom: AppSizes.p24,
              left: 0,
              right: 0,
              child: ProductImagesIndicator(
                length: imageSrcList.length,
                activeIndex: activeIndex.value,
              ))
        ],
      );
    }
  }
}

class ProductImagesIndicator extends StatelessWidget {
  final int length;
  final int activeIndex;

  const ProductImagesIndicator({
    super.key,
    required this.length,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        for (int i = 0; i < length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.p4,
            ),
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: i == activeIndex
                    ? AppColors.primaryColor
                    : AppColors.greyPrimary,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}
