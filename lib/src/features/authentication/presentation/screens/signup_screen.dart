import 'package:flutter/material.dart';
import 'package:flutterware/src/common_widgets/page_wrap/page_wrap.dart';

import '../../../../common_widgets/heading/heading.dart';
import '../../../../common_widgets/top_nav_bar/top_nav_bar.dart';
import '../../../../constants/app_sizes.dart';

class SignupScreen extends StatelessWidget {
  static const path = '/signup';
  static const name = 'signupScreen';

  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TopNavBar(title: 'Join us'),
            gapH40,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.p16),
              child: Heading(
                'Personal details',
                level: HeadingLevel.h3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
