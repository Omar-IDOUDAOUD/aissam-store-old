import 'dart:convert';

import 'package:aissam_store/core/constants/products_server.dart';
import 'package:aissam_store/data/model/response.dart';
import 'package:dio/dio.dart';

class Ts {}

typedef ResponseBodyConverter<T> = T Function(dynamic dataContent);

abstract class ProductsServerRepository<T> {
  late final Dio _requestBase;
  // final T? noContentBody;

  ProductsServerRepository() {
    final authHeader =
        'Basic ${base64.encode(utf8.encode('${ProductsServerConsts.header_auth_username}:${ProductsServerConsts.header_auth_pass}'))}';
    _requestBase = Dio(
      BaseOptions(
        baseUrl: ProductsServerConsts.baseUrl,
        responseType: ResponseType.json,
        headers: {
          'Authorization': authHeader,
        },
      ),
    );
    _requestBase.interceptors.add(
      InterceptorsWrapper(
        onResponse: (Response e, ResponseInterceptorHandler handler) {
          print('TEST 2');
          e.data = ServerResponse<T>.success(e, responseBodyConverter);
          print('TEST 3');
          handler.resolve(e);
          print('TEST 4');
        },
        onError: (DioException e, ErrorInterceptorHandler handler) {
          if (e.response == null) {
            // Connection err
            final newResponse = Response<ServerResponse<T>>(
              requestOptions: e.requestOptions,
              data: ServerResponse.fail(e),
            );
            handler.resolve(newResponse);
            return;
          }
          e.response!.data =
              ServerResponse<T>.success(e.response!, responseBodyConverter);
          handler.resolve(e.response!);
        },
      ),
    );
  }

  T responseBodyConverter(dynamic dataContent);

  abstract final String path;
  abstract final RequestContentTypedef<T> requestContent;
  Future<ServerResponse<T>> run() async {
    return (await requestContent(_requestBase)).data!;
  }
}

typedef RequestContentTypedef<T> = Future<Response<ServerResponse<T>>> Function(
    Dio requestBase);
