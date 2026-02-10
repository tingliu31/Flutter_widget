import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'error_interceptor.dart';
import 'auth_header_interceptor.dart';
import 'dio_practice.dart';

/// 展示「一次加上多個 Interceptor」的範例頁面
class DioInterceptorsDemoPage extends StatefulWidget {
  const DioInterceptorsDemoPage({super.key});

  @override
  State<DioInterceptorsDemoPage> createState() =>
      _DioInterceptorsDemoPageState();
}

class _DioInterceptorsDemoPageState extends State<DioInterceptorsDemoPage> {
  late final Dio _dio;
  String _result = '尚未發送請求';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initDioWithInterceptors();
  }

  void _initDioWithInterceptors() {

    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    _dio.interceptors.add(InterceptorA());
    _dio.interceptors.add(InterceptorB());
    _dio.interceptors.add(InterceptorC());

    // // 一次註冊多個攔截器：Log + AuthHeader + ErrorInterceptor
    // _dio.interceptors.addAll([
    //   // 1) 官方提供的 LogInterceptor：方便快速查看請求/回應
    //   LogInterceptor(
    //     requestBody: true,
    //     responseBody: true,
    //   ),

    //   // 2) 自訂：統一幫所有請求加上 Token / Header
    //   AuthHeaderInterceptor(
    //     getToken: () async {
    //       // Demo：實務上會改成讀取你的登入 Token
    //       await Future<void>.delayed(const Duration(milliseconds: 200));
    //       return 'demo-token-123';
    //     },
    //   ),

    //   // 3) 自訂：錯誤處理 + 自動重試
    //   ErrorInterceptor(
    //     dio: _dio,
    //     maxRetries: 2,
    //     retryDelay: const Duration(milliseconds: 500),
    //   ),
    // ]);
  }

  void _setLoading(bool value) {
    if (!mounted) return;
    setState(() => _isLoading = value);
  }

  void _setResult(String value) {
    if (!mounted) return;
    setState(() => _result = value);
  }

  /// 成功範例：GET 單一資源
  Future<void> _sendSuccessRequest() async {
    _setLoading(true);
    try {
      final res = await _dio.get('/posts/1');
      _setResult('✅ 成功取得資料：\n\n${res.data}');
    } on DioException catch (e) {
      _setResult('❌ 錯誤：${e.message ?? e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// 錯誤範例：打不存在的路由，觸發 ErrorInterceptor 的 HTTP 錯誤處理
  Future<void> _sendErrorRequest() async {
    _setLoading(true);
    try {
      await _dio.get('/this-endpoint-not-exists-404');
      _setResult('✅ 意外成功？（理論上應該 404）');
    } on DioException catch (e) {
      _setResult('❌ 錯誤（經 ErrorInterceptor 處理後）：\n\n${e.message}');
    } finally {
      _setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dio 多攔截器範例')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: Text(
                          _result,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _sendSuccessRequest,
                    child: const Text('成功請求'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _sendErrorRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('錯誤/重試示範'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dio.close();
    super.dispose();
  }
}
