import 'package:shopware6_client/shopware6_client.dart';

import '../id_generator.dart';

PropertyGroup createPropertyGroup() {
  return PropertyGroup(
      id: IDGenerator.generate(),
      name: 'PropertyGroup',
      displayType: '',
      sortingType: '',
      createdAt: DateTime.now(),
      options: [
        createPropertyGroupOption(),
      ]);
}

PropertyGroupOption createPropertyGroupOption() {
  return PropertyGroupOption(
    groupId: IDGenerator.generate(),
    name: 'PropertyGroupOption',
    createdAt: DateTime.now(),
  );
}

ListingAggregations createListingAggregations() {
  return ListingAggregations(
    properties: PropertyAggregation(
      entities: [
        createPropertyGroup(),
      ],
    ),
  );
}
