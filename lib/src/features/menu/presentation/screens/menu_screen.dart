import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/page_wrap/page_wrap.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/features/debug/widgets/debug_menu.dart';
import 'package:flutterware/src/features/global/data/global_data_notifier.dart';
import 'package:flutterware/src/features/menu/presentation/widgets/category_bar.dart';
import 'package:flutterware/src/features/search/presentation/widgets/search_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../common_widgets/async_value_widget/async_value_widget.dart';

class MenuScreen extends ConsumerWidget {
  static const path = '/menu';
  static const name = 'menuScreen';
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /*   final globalData = ref.watch(globalDataNotifierProvider).asData!.value;
    final globalDataNotifier = ref.read(globalDataNotifierProvider.notifier); */

    return PageWrap(
      child: SingleChildScrollView(
        child: AsyncValueWidget(
          skipLoadingOnRefresh: false,
          data: (globalData) {
            final categories = globalData.rootCategories;
            return Column(
              children: [
                const SearchBar(),
                ...categories
                    .map((category) => CategoryBar(category: category)),
                gapH16,
                /* Accordion(
                  items: [
                    AccordionItem(
                      title: 'Language',
                      body: Column(
                        children: [
                          ...globalData.languages
                              .map(
                                (language) => FilterDialogOption(
                                  title: language.name,
                                  isSelected:
                                      globalData.isCurrentLanguage(language),
                                  onTap: () {
                                    globalDataNotifier.updateContext(
                                      ContextPatchRequest(
                                        languageId: language.id,
                                      ),
                                    );
                                  },
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ),
                    AccordionItem(
                      title: 'Currency',
                      body: Column(
                        children: [
                          ...globalData.currencies
                              .map(
                                (currency) => FilterDialogOption(
                                  title: currency.name,
                                  isSelected:
                                      globalData.isCurrentCurrency(currency),
                                  onTap: () {
                                    globalDataNotifier.updateContext(
                                      ContextPatchRequest(
                                        currencyId: currency.id,
                                      ),
                                    );
                                  },
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ),
                    AccordionItem(
                      title: 'Country',
                      body: Column(
                        children: [
                          ...globalData.countries
                              .map(
                                (country) => FilterDialogOption(
                                  title: country.name,
                                  isSelected:
                                      globalData.isCurrentCountry(country),
                                  onTap: () {
                                    globalDataNotifier.updateContext(
                                      ContextPatchRequest(
                                        countryId: country.id,
                                      ),
                                    );
                                  },
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ),
                  ],
                ), */
                const DebugMenu(),
              ],
            );
          },
          value: ref.watch(globalDataNotifierProvider),
        ),
      ),
    );
  }
}
