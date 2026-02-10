import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 非同步 Provider → 返回 AsyncValue
final apiDataProvider = FutureProvider<String>((ref) async {
  debugPrint('🔄 API 被呼叫'); 
  await Future.delayed(Duration(seconds: 2));
  return '資料時間: ${DateTime.now().toIso8601String()}';
});

// AsyncValue 有這些屬性
// dataAsync.isLoading      // 是否在載入中（包含首次和 refresh）
// dataAsync.isRefreshing   // 是否在 refresh 中（有舊資料的情況下重新載入）
// dataAsync.isReloading    // 是否在 reload 中（錯誤後重試）
// dataAsync.hasValue       // 是否有資料
// dataAsync.hasError       // 是否有錯誤
// dataAsync.value          // 資料值（可能為 null）
// dataAsync.error          // 錯誤（可能為 null）
// ```

class RiverpodRefreshWidget extends ConsumerWidget {
  const RiverpodRefreshWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    //返回 AsyncValue<String>
    final dataAsync = ref.watch(apiDataProvider);
    
    return Scaffold(
      appBar: AppBar(title: Text('Refresh 範例')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            dataAsync.when(
              data: (data) => Column(
                children: [
                  Text(
                    data,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  // ✅ 顯示 refresh 狀態
                  if (dataAsync.isRefreshing)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '正在更新...',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              loading: () => CircularProgressIndicator(),
              error: (error, stack) => Text('錯誤: $error'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final _ = ref.refresh(apiDataProvider);
              },
              child: Text('重新整理'),
            ),
          ],
        ),
      ),
    );
  }
}