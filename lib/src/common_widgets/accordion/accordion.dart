import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import '../../constants/flutterware_icons.dart';

class AccordionItem extends HookWidget {
  final Widget body;
  final String title;

  const AccordionItem({super.key, required this.body, required this.title});
  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);

    final expansionTileTheme = ExpansionTileTheme.of(context);
    final colorToUse = isExpanded.value
        ? expansionTileTheme.textColor
        : expansionTileTheme.collapsedTextColor;

    return ExpansionTile(
      onExpansionChanged: (value) => isExpanded.value = value,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .apply(color: colorToUse),
      ),
      trailing: AnimatedRotation(
        duration: kThemeAnimationDuration,
        turns: isExpanded.value ? 0.25 : 0,
        child: Icon(FlutterwareIcons.chevronRight, color: colorToUse),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.p16),
          child: body,
        )
      ],
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

    return ExpansionPanelList(
      elevation: 0,
      expansionCallback: (panelIndex, isExpanded) {
        if (panelIndex == expandedIndex.value) {
          expandedIndex.value = -1;
        } else {
          expandedIndex.value = panelIndex;
        }
      },
      children: items
          .map(
            (item) => ExpansionPanel(
              canTapOnHeader: true,
              isExpanded: items.indexOf(item) == expandedIndex.value,
              headerBuilder: (context, isExpanded) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.p16,
                    vertical: 14.0,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColors.greyLightAccent),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: AppColors.blackSecondary,
                            ),
                      ),
                      const Icon(
                        FlutterwareIcons.chevronRight,
                        color: AppColors.blackSecondary,
                        size: 32.0,
                      ),
                    ],
                  ),
                );
              },
              body: item.body,
            ),
          )
          .toList(),
    );
  }
}
