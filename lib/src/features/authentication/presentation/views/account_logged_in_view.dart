import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/heading/heading.dart';
import 'package:flutterware/src/common_widgets/list_tile/list_tile.dart';

import '../../../../common_widgets/top_nav_bar/top_nav_bar.dart';
import '../../../../constants/app_sizes.dart';
import '../widgets/account/account_header.dart';
import '../widgets/logout_button.dart';

class AccountLoggedInView extends StatelessWidget {
  const AccountLoggedInView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TopNavBar(title: 'My Account'),
            AccountHeader(),
            gapH40,
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.p16,
              ),
              child: Heading(
                'Order details',
                level: HeadingLevel.h3,
              ),
            ),
            gapH40,
            FwListTile(
              title: 'Order history',
              backgroundColor: Colors.transparent,
            ),
            Padding(
              padding: EdgeInsets.all(
                AppSizes.p16,
              ),
              child: LogoutButton(),
            ),
          ],
        ),
      ),
    ]);
  }
}
