import 'package:flutter/material.dart';
import 'package:flutterware/src/constants/app_sizes.dart';
import 'package:flutterware/src/features/address/presentation/widgets/address_select_item.dart';
import 'package:shopware6_client/shopware6_client.dart';

class AddressSelect extends StatelessWidget {
  final List<Address?> addresses;
  const AddressSelect({
    super.key,
    required this.addresses,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) => AddressSelectItem(
        address: addresses[index]!,
        selected: index == 0,
      ),
      separatorBuilder: (_, __) => gapH16,
      itemCount: addresses.length,
    );
  }
}
