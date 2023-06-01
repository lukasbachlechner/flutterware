import 'package:http/src/base_response.dart';
import 'dart:typed_data';

import 'package:shopware6_client/shopware6_client.dart';

class MockResponse<T> implements Response<T> {
  @override
  final T? body;
  MockResponse(this.body);

  @override
  // TODO: implement base
  BaseResponse get base => throw UnimplementedError();

  @override
  // TODO: implement bodyBytes
  Uint8List get bodyBytes => throw UnimplementedError();

  @override
  // TODO: implement bodyString
  String get bodyString => throw UnimplementedError();

  @override
  Response<NewBodyType> copyWith<NewBodyType>({
    BaseResponse? base,
    NewBodyType? body,
    Object? bodyError,
  }) =>
      MockResponse(body ?? (this.body as NewBodyType?));

  @override
  // TODO: implement error
  Object? get error => throw UnimplementedError();

  @override
  // TODO: implement headers
  Map<String, String> get headers => throw UnimplementedError();

  @override
  // TODO: implement isSuccessful
  bool get isSuccessful => throw UnimplementedError();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  // TODO: implement statusCode
  int get statusCode => throw UnimplementedError();

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}
