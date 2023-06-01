import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route<dynamic> {}

GoRoute createTestRoute({
  required String path,
  required String name,
  required Key key,
}) {
  return GoRoute(
    path: path,
    name: name,
    builder: (context, state) => Scaffold(
      body: Container(key: key),
    ),
  );
}
