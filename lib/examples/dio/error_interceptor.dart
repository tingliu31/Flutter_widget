import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'auth_header_interceptor.dart';

/// 獨立的錯誤攔截器：負責 retry + 統一狀態碼處理
class ErrorInterceptor extends Interceptor {
  ErrorInterceptor({
    required this.dio,
    this.maxRetries = 2,
    this.retryDelay = const Duration(milliseconds: 500),
  });

  final Dio dio;
  final int maxRetries;
  final Duration retryDelay;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    switch (err.type) {
      // === 連線/超時類：嘗試重試 ===
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        await _handleRetry(err, handler);
        return;

      // === 伺服器有回應但狀態碼不在 2xx ===
      case DioExceptionType.badResponse:
        _handleHttpError(err, handler);
        return;

      default:
        // 其他：取消、未知錯誤等
        handler.next(err);
        return;
    }
  }

  Future<void> _handleRetry(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = err.requestOptions;

    // 取得已重試次數（放在 extra 內追蹤）
    final retries = (requestOptions.extra['retries'] as int?) ?? 0;

    if (retries >= maxRetries) {
      dev.log('[Retry] reached maxRetries=$maxRetries, give up.', name: 'Dio');
      handler.next(err);
      return;
    }

    // 更新重試次數
    requestOptions.extra['retries'] = retries + 1;

    // 延遲一下再重試（避免瞬間連打）
    await Future.delayed(retryDelay);

    dev.log(
      '[Retry] ${requestOptions.method} ${requestOptions.uri} '
      'attempt=${retries + 1}',
      name: 'Dio',
    );

    try {
      // 重新送出同一個 request
      final response = await dio.fetch(requestOptions);
      handler.resolve(response);
    } catch (e) {
      // 重試仍失敗，繼續往上丟（或讓下一層 onError 處理）
      handler.next(err);
    }
  }

  void _handleHttpError(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    final url = err.requestOptions.uri.toString();

    dev.log('[HTTP Error] $statusCode $url data=${err.response?.data}', name: 'Dio');

    // 你可以在這裡「統一轉換成自訂例外」讓上層更好處理
    switch (statusCode) {
      case 400:
        handler.reject(_wrap(err, message: 'Bad Request（參數錯誤）'));
        return;
      case 401:
        handler.reject(_wrap(err, message: 'Unauthorized（未登入或 Token 過期）'));
        return;
      case 403:
        handler.reject(_wrap(err, message: 'Forbidden（沒有權限）'));
        return;
      case 404:
        handler.reject(_wrap(err, message: 'Not Found（資源不存在）'));
        return;
      case 500:
      case 502:
      case 503:
        handler.reject(_wrap(err, message: 'Server Error（伺服器忙碌）'));
        return;
      default:
        handler.next(err);
        return;
    }
  }

  DioException _wrap(DioException err, {required String message}) {
    // 建議把友善訊息塞到 DioException.message（或 extra）讓 UI 顯示
    return DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: err.error,
      message: message,
      stackTrace: err.stackTrace,
    );
  }
}