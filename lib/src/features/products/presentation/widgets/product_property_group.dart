import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopware6_client/shopware6_client.dart';
import 'package:flutter/material.dart';

class ProductPropertyGroup extends HookConsumerWidget {
  final PropertyGroup propertyGroup;
  const ProductPropertyGroup({super.key, required this.propertyGroup});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = useState(propertyGroup.options?.first.id);

    return DropdownButton(
      value: current.value,
      items: propertyGroup.options
          ?.map((propertyGroupOption) => DropdownMenuItem(
                value: propertyGroupOption.id,
                child: Text(propertyGroupOption.name),
              ))
          .toList(),
      onChanged: (value) {
        current.value = value;
      },
    );
  }
}
