import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    this.onPressed,
    this.size = 52.0,
    required this.iconData,
    this.iconSize = AppSizes.iconMD,
    this.color = AppColors.primaryColor,
  });

  final VoidCallback? onPressed;
  final double size;
  final IconData iconData;
  final double iconSize;
  final Color color;

  ButtonStyle getStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(color),
      padding: const MaterialStatePropertyAll(EdgeInsets.zero),
      shape: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.pressed)) {
          return CircleBorder(
            side: BorderSide(
              width: 8,
              color: color.withOpacity(0.3),
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          );
        }

        return const CircleBorder();
      }),
      fixedSize: MaterialStatePropertyAll(
        Size.square(size),
      ),
      elevation: const MaterialStatePropertyAll(0),
      splashFactory: NoSplash.splashFactory,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 11,
            color: AppColors.blackPrimary.withOpacity(0.1),
          )
        ],
        shape: BoxShape.circle,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: getStyle(),
        child: Icon(
          color: AppColors.white,
          iconData,
          size: iconSize,
        ),
      ),
    );
  }
}
