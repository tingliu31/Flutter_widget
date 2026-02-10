import 'dart:developer' as dev;
import 'package:dio/dio.dart';
import 'dart:async';

void main() async {
  // await getTodo();

  final dio = Dio();

  dio.interceptors.add(InterceptorA());
  dio.interceptors.add(InterceptorB());
  dio.interceptors.add(InterceptorC());
  try {
    // 發送請求
    await dio.get('jsonplaceholder.typicode.com/posts/1');
  } catch (e) {
    print('Error: $e');
  }
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
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Accept': 'application/json'},
    ),
  );

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

// Interceptor A
class InterceptorA extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('A - onRequest');
    handler.next(options); // 繼續下一個
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('A - onResponse');
    handler.next(response); // 繼續下一個
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('A - onError');
    handler.next(err); // 繼續下一個
  }
}

// Interceptor B
class InterceptorB extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('B - onRequest');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('B - onResponse');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('B - onError');
    handler.next(err);
  }
}

// Interceptor C
class InterceptorC extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('C - onRequest');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('C - onResponse');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('C - onError');
    handler.next(err);
  }
}
