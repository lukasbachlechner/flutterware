import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import '../../constants/flutterware_icons.dart';

class AccordionItem extends HookWidget {
  final Widget body;
  final String title;
  final String? trailingText;
  final bool withPadding;

  const AccordionItem({
    super.key,
    required this.body,
    required this.title,
    this.trailingText,
    this.withPadding = true,
  });
  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);

    final expansionTileTheme = ExpansionTileTheme.of(context);
    final colorToUse = isExpanded.value
        ? expansionTileTheme.textColor
        : expansionTileTheme.collapsedTextColor;

    return Material(
      color: Colors.transparent,
      child: ExpansionTile(
        childrenPadding: EdgeInsets.zero,
        onExpansionChanged: (value) => isExpanded.value = value,
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: colorToUse),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (trailingText != null)
              Text(
                trailingText!,
              ),
            AnimatedRotation(
              duration: kThemeAnimationDuration,
              turns: isExpanded.value ? 0.25 : 0,
              child: Icon(FlutterwareIcons.chevronRight, color: colorToUse),
            ),
          ],
        ),
        children: [
          Padding(
            padding: withPadding
                ? const EdgeInsets.all(AppSizes.p16)
                : EdgeInsets.zero,
            child: body,
          )
        ],
      ),
    );
  }
}

class Accordion extends HookWidget {
  final List<AccordionItem> items;
  const Accordion({super.key, required this.items});
  @override
  Widget build(BuildContext context) {
    final expandedIndex = useState(-1);

    return ExpansionTileTheme(
      data: const ExpansionTileThemeData(
        collapsedShape: Border(
          bottom: BorderSide(color: AppColors.greyLightAccent),
        ),
        collapsedTextColor: AppColors.blackSecondary,
        collapsedIconColor: AppColors.blackPrimary,
        textColor: AppColors.primaryColor,
        iconColor: AppColors.primaryColor,
      ),
      child: Column(
        children: [...items],
      ),
    );
  }
}
