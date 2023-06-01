import 'package:flutter/material.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:shopware6_client/shopware6_client.dart';

import '../fixtures/fixture.dart';

ShopwareClient getMockShopwareClient() {
  return ShopwareClient(
    client: MockClient((request) async {
      try {
        final pathForFixture = request.url.pathSegments.map((e) {
          if (RegExp(ID.validatorRegEx).hasMatch(e)) {
            return '[id]';
          }

          return e;
        }).join('/');

        final fixture = await Fixture(pathForFixture).get();

        return http.Response(
          fixture,
          200,
          headers: {
            'content-type': 'application/json; charset=utf-8',
          },
        );
      } catch (e) {
        // debugPrint(e.toString());
        debugPrint('Fixture not found for ${request.url.path}');
        return http.Response(
          '{}',
          404,
          headers: {
            'content-type': 'application/json; charset=utf-8',
          },
        );
      }
    }),
    config: const ShopwareClientConfig(
      baseUrl: '',
      swAccessKey: '',
    ),
  );
}
