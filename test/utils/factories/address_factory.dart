import 'package:shopware6_client/shopware6_client.dart';

import '../id_generator.dart';

Address createAddress() => Address(
      customerId: IDGenerator.generate(),
      countryId: IDGenerator.generate(),
      firstName: 'firstName',
      lastName: 'lastName',
      city: 'city',
      street: 'street',
      createdAt: DateTime.now(),
    );
