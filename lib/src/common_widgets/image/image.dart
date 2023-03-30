import 'package:flutter/material.dart';

class FwImage extends StatelessWidget {
  final String? src;
  final BoxFit? fit;
  final double? width;
  final double? height;
  const FwImage({
    super.key,
    this.src,
    this.fit,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    if (src == null || src!.isEmpty) {
      return const Placeholder();
    }
    return Image.network(
      src ?? '',
      fit: fit,
      height: height,
      width: width,
    );
  }
}
