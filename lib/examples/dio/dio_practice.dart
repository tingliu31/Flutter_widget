import 'dart:developer' as dev;
import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';


Future<void> main() async {

  await getTodo();

}


Future<void> getTodo() async {
  try {
    final dio = createDio(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      languageCode: 'zh-TW',
    );
    final response = await dio.get('/todos/1');
    print('Response: ${response.data}');
  } on DioException catch (e) {
    print('Dio error: type=${e.type} msg=${e.message}');
  } catch (e) {
    print('Unknown error: $e');
  }
}

Dio createDio({
  required String baseUrl,
  String? accessToken,
  String languageCode = 'zh-TW',
}) {

  final dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {'Accept': 'application/json'},
  ));

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        // 1) 統一加語系
        // options.headers['Accept-Language'] = languageCode;

        // 2) 統一加 Token（若有）
        if (accessToken != null && accessToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }

        // 3) Request log
        dev.log(
          '[DIO][REQ] ${options.method} ${options.uri}\n'
          'Headers: ${options.headers}\n'
          'Query: ${options.queryParameters}\n'
          'Body: ${options.data}',
          name: 'Dio',
        );

        // 放行，繼續送出 request
        handler.next(options);
      },
      onResponse: (response, handler) {
        // Response log
        dev.log(
          '[DIO][RES] ${response.statusCode} ${response.requestOptions.uri}\n'
          'Data: ${response.data}',
          name: 'Dio',
        );

        // 放行，回傳 response
        handler.next(response);
      },
      onError: (e, handler) {
        final status = e.response?.statusCode;

        // Error log
        dev.log(
          '[DIO][ERR] status=$status uri=${e.requestOptions.uri}\n'
          'type=${e.type} message=${e.message}\n'
          'data=${e.response?.data}',
          name: 'Dio',
        );

        // 你可以在這裡做統一錯誤轉換（示意）
        // 例如把 timeout / no internet 轉成友善訊息
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          // 也可以用 handler.reject(...) 丟出你自訂的 DioException
        }

        // 放行，把錯誤往上丟
        handler.next(e);
      },
    ),
  );

  return dio;
}