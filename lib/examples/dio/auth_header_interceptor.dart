import 'package:dio/dio.dart';

/// 提供 Token 的方法型別（例如從記憶體、SecureStorage 取得）
typedef TokenProvider = Future<String?> Function();

/// 統一在每個請求上加上 Authorization / 自訂 Header 的攔截器
class AuthHeaderInterceptor extends Interceptor {
  AuthHeaderInterceptor({
    required this.getToken,
  });

  final TokenProvider getToken;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // 例如：從本地或記憶體取得 Token
    final token = await getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // 也可以在這裡統一設定一些自訂 Header
    options.headers['X-Platform'] = 'flutter';

    handler.next(options);
  }
}
