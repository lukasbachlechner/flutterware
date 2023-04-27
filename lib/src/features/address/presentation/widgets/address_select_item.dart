import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_colors.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/constants/flutterware_icons.dart';
import 'package:shopware6_client/shopware6_client.dart';

class AddressSelectItem extends StatelessWidget {
  final Address address;
  final bool selected;
  const AddressSelectItem({
    super.key,
    required this.address,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headlineSmall!.copyWith(
          height: 1.5,
        );
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(
          AppSizes.p16,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color:
                selected ? AppColors.primaryColor : AppColors.greyLightAccent,
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${address.firstName} ${address.lastName}',
                  style: textStyle,
                ),
                Text(
                  address.street,
                  style: textStyle,
                ),
                Text(
                  '${address.zipcode} ${address.city}',
                  style: textStyle,
                ),
                Text(
                  address.country?.name ?? '',
                  style: textStyle,
                ),
              ],
            ),
            if (selected)
              const Positioned(
                right: 0,
                top: 0,
                child: Icon(
                  FlutterwareIcons.checked,
                  color: AppColors.primaryColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
