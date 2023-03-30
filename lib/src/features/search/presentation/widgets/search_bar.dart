import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutterware/src/features/search/presentation/screens/search_screen.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../constants/flutterware_icons.dart';

class SearchBar extends HookWidget {
  final bool showLeading;
  final bool isAbsorbing;
  final void Function(String query)? onChanged;
  const SearchBar({
    super.key,
    this.showLeading = false,
    this.isAbsorbing = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final fieldFocusNode = useFocusNode();

    useEffect(() {
      if (!isAbsorbing) {
        fieldFocusNode.requestFocus();
      }
      return () => fieldFocusNode.unfocus();
    }, []);

    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      toolbarHeight: 50,
      automaticallyImplyLeading: false,
      leading: showLeading
          ? IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(
                FlutterwareIcons.chevronLeft,
                color: AppColors.blackPrimary,
              ),
            )
          : null,
      title: Padding(
        padding: showLeading
            ? const EdgeInsets.only(right: AppSizes.p16)
            : const EdgeInsets.symmetric(horizontal: AppSizes.p16),
        child: GestureDetector(
          onTap: () {
            context.pushNamed(SearchScreen.name);
          },
          child: AbsorbPointer(
            absorbing: isAbsorbing,
            child: TextField(
              onChanged: (value) => onChanged?.call(value),
              textInputAction: TextInputAction.search,
              focusNode: fieldFocusNode,
              decoration: InputDecoration(
                labelText: 'Search for items and promotions',
                labelStyle: Theme.of(context).textTheme.headlineSmall,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                suffixIconConstraints: const BoxConstraints.expand(
                  width: 32,
                  height: 32,
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(width: 2),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: AppColors.primaryColor,
                  ),
                ),
                isCollapsed: true,
                contentPadding: const EdgeInsets.all(AppSizes.p4),
                suffixIcon: const Icon(
                  FlutterwareIcons.search,
                  size: 28,
                  color: AppColors.blackPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
