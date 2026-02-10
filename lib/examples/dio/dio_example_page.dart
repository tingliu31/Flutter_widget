import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:developer' as dev;

/// Dio 範例頁面 - 展示各種常見的 HTTP 請求場景
class DioExamplePage extends StatefulWidget {
  const DioExamplePage({super.key});

  @override
  State<DioExamplePage> createState() => _DioExamplePageState();
}

class _DioExamplePageState extends State<DioExamplePage> {

  /// Dio 實例
  late final Dio _dio;
  String _result = '尚未執行任何請求';
  bool _isLoading = false;

  // 只在 State 建立時執行一次 用於初始化 Dio 實例
  @override
  void initState() {
    super.initState();
    _initDio();
  }

  /// 初始化 Dio 實例並設定攔截器
  void _initDio() {

    // 統一設定 baseUrl / timeout / headers
    _dio = Dio(BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ));

    // 添加 Request/Response 攔截器
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          dev.log(
            '📤 [REQUEST] ${options.method} ${options.uri}\n'
            'Headers: ${options.headers}\n'
            'Data: ${options.data}',
            name: 'Dio',
          );
          handler.next(options);
        },
        onResponse: (response, handler) {
          dev.log(
            '✅ [RESPONSE] ${response.statusCode} ${response.requestOptions.uri}\n'
            'Data: ${response.data}',
            name: 'Dio',
          );
          handler.next(response);
        },
        onError: (error, handler) {
          dev.log(
            '❌ [ERROR] ${error.response?.statusCode} ${error.requestOptions.uri}\n'
            'Type: ${error.type}\n'
            'Message: ${error.message}',
            name: 'Dio',
          );
          handler.next(error);
        },
      ),
    );
  }

  /// 設定載入狀態並更新結果
  void _setLoading(bool loading) {
    if (mounted) {
      setState(() => _isLoading = loading);
    }
  }

  void _setResult(String result) {
    if (mounted) {
      setState(() => _result = result);
    }
  }

  /// 範例 1: GET 請求 - 取得單一資源
  Future<void> _getTodo() async {
    _setLoading(true);
    try {
      final response = await _dio.get('/todos/1');
      _setResult('✅ GET 成功\n\n${_formatJson(response.data)}');
    } on DioException catch (e) {
      _setResult('❌ 錯誤: ${_getDioErrorMessage(e)}');
    } finally {
      _setLoading(false);
    }
  }

  /// 範例 2: GET 請求 - 取得列表（帶查詢參數）
  Future<void> _getTodoList() async {
    _setLoading(true);
    try {
      final response = await _dio.get(
        '/todos',
        queryParameters: {
          'userId': 1,
          '_limit': 5,
        },
      );
      final List todos = response.data;
      _setResult(
        '✅ GET 列表成功 (共 ${todos.length} 筆)\n\n'
        '${todos.map((t) => '• ${t['title']}').join('\n')}',
      );
    } on DioException catch (e) {
      _setResult('❌ 錯誤: ${_getDioErrorMessage(e)}');
    } finally {
      _setLoading(false);
    }
  }

  /// 範例 3: POST 請求 - 新增資料
  Future<void> _createPost() async {
    _setLoading(true);
    try {
      final response = await _dio.post(
        '/posts',
        data: {
          'title': 'Dio 測試文章',
          'body': '這是使用 Dio 套件發送的 POST 請求',
          'userId': 1,
        },
      );
      _setResult('✅ POST 成功\n\n${_formatJson(response.data)}');
    } on DioException catch (e) {
      _setResult('❌ 錯誤: ${_getDioErrorMessage(e)}');
    } finally {
      _setLoading(false);
    }
  }

  /// 範例 4: PUT 請求 - 更新資料
  Future<void> _updatePost() async {
    _setLoading(true);
    try {
      final response = await _dio.put(
        '/posts/1',
        data: {
          'id': 1,
          'title': '更新後的標題',
          'body': '更新後的內容',
          'userId': 1,
        },
      );
      _setResult('✅ PUT 成功\n\n${_formatJson(response.data)}');
    } on DioException catch (e) {
      _setResult('❌ 錯誤: ${_getDioErrorMessage(e)}');
    } finally {
      _setLoading(false);
    }
  }

  /// 範例 5: DELETE 請求 - 刪除資料
  Future<void> _deletePost() async {
    _setLoading(true);
    try {
      final response = await _dio.delete('/posts/1');
      _setResult('✅ DELETE 成功\n\nStatus: ${response.statusCode}');
    } on DioException catch (e) {
      _setResult('❌ 錯誤: ${_getDioErrorMessage(e)}');
    } finally {
      _setLoading(false);
    }
  }

  /// 範例 6: 並發請求 - 同時發送多個請求
  Future<void> _parallelRequests() async {
    _setLoading(true);
    try {
      final results = await Future.wait([
        _dio.get('/todos/1'),
        _dio.get('/posts/1'),
        _dio.get('/users/1'),
      ]);

      _setResult(
        '✅ 並發請求成功\n\n'
        'Todo: ${results[0].data['title']}\n\n'
        'Post: ${results[1].data['title']}\n\n'
        'User: ${results[2].data['name']}',
      );
    } on DioException catch (e) {
      _setResult('❌ 錯誤: ${_getDioErrorMessage(e)}');
    } finally {
      _setLoading(false);
    }
  }

  /// 範例 7: 模擬錯誤處理 - 404
  Future<void> _simulateError() async {
    _setLoading(true);
    try {
      await _dio.get('/invalid-endpoint-999999');
      _setResult('✅ 成功');
    } on DioException catch (e) {
      _setResult(
        '❌ 捕獲到錯誤（預期行為）\n\n'
        'Type: ${e.type.name}\n'
        'Status: ${e.response?.statusCode}\n'
        'Message: ${_getDioErrorMessage(e)}',
      );
    } finally {
      _setLoading(false);
    }
  }

  /// 範例 8: 取消請求
  Future<void> _cancelRequest() async {
    _setLoading(true);
    final cancelToken = CancelToken();

    // 模擬：1 秒後取消請求
    Future.delayed(const Duration(seconds: 1), () {
      if (!cancelToken.isCancelled) {
        cancelToken.cancel('使用者取消');
      }
    });

    try {
      await _dio.get(
        '/todos',
        queryParameters: {'_limit': 100},
        cancelToken: cancelToken,
      );
      _setResult('✅ 請求完成');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        _setResult('🚫 請求已取消');
      } else {
        _setResult('❌ 錯誤: ${_getDioErrorMessage(e)}');
      }
    } finally {
      _setLoading(false);
    }
  }

  /// 格式化 JSON 顯示
  String _formatJson(dynamic data) {
    if (data is Map) {
      return data.entries
          .map((e) => '${e.key}: ${e.value}')
          .join('\n');
    }
    return data.toString();
  }

  /// 取得友善的錯誤訊息
  String _getDioErrorMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return '連線逾時';
      case DioExceptionType.sendTimeout:
        return '發送逾時';
      case DioExceptionType.receiveTimeout:
        return '接收逾時';
      case DioExceptionType.badResponse:
        return '伺服器回應錯誤 (${e.response?.statusCode})';
      case DioExceptionType.cancel:
        return '請求已取消';
      case DioExceptionType.connectionError:
        return '連線錯誤（無網路或伺服器無回應）';
      case DioExceptionType.unknown:
        return '未知錯誤: ${e.message}';
      default:
        return e.message ?? '發生錯誤';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dio 範例'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // 結果顯示區域
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: _isLoading
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('載入中...'),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Text(
                        _result,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
            ),
          ),

          // 按鈕區域
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildButton(
                    label: '1. GET 單一資源',
                    icon: Icons.download,
                    color: Colors.blue,
                    onPressed: _getTodo,
                  ),
                  _buildButton(
                    label: '2. GET 列表（帶查詢參數）',
                    icon: Icons.list,
                    color: Colors.blue[700]!,
                    onPressed: _getTodoList,
                  ),
                  _buildButton(
                    label: '3. POST 新增資料',
                    icon: Icons.add,
                    color: Colors.green,
                    onPressed: _createPost,
                  ),
                  _buildButton(
                    label: '4. PUT 更新資料',
                    icon: Icons.edit,
                    color: Colors.orange,
                    onPressed: _updatePost,
                  ),
                  _buildButton(
                    label: '5. DELETE 刪除資料',
                    icon: Icons.delete,
                    color: Colors.red,
                    onPressed: _deletePost,
                  ),
                  _buildButton(
                    label: '6. 並發請求',
                    icon: Icons.sync,
                    color: Colors.purple,
                    onPressed: _parallelRequests,
                  ),
                  _buildButton(
                    label: '7. 錯誤處理示範',
                    icon: Icons.warning,
                    color: Colors.amber[800]!,
                    onPressed: _simulateError,
                  ),
                  _buildButton(
                    label: '8. 取消請求',
                    icon: Icons.cancel,
                    color: Colors.grey,
                    onPressed: _cancelRequest,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ElevatedButton.icon(
        onPressed: _isLoading ? null : onPressed,
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          disabledBackgroundColor: Colors.grey[300],
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
