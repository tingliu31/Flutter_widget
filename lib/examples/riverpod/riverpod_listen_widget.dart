import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 狀態 Provider
final counterProvider = StateProvider<int>((ref) => 0);

class RiverpodListenWidget extends ConsumerWidget {
  const RiverpodListenWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ✅ 監聽 counter 變化
    ref.listen<int>(counterProvider, (previous, next) {
      // previous: 之前的值
      // next: 新的值
      print('Counter changed from $previous to $next');

      // 當計數到達 5 時顯示 SnackBar
      if (next == 5) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('到達 5 了！')));
      }
    });

    // 使用 watch 顯示 UI
    final count = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod Listen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count: $count', style: TextStyle(fontSize: 32)),
            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).state++;
              },
              child: Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ 最佳實踐組合
class BestPracticeExample extends ConsumerWidget {
  const BestPracticeExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. watch: 顯示 UI
    final count = ref.watch(counterProvider);

    // 2. listen: 副作用（導航、通知）
    ref.listen<int>(counterProvider, (previous, next) {
      if (next >= 10) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('達到 10 了！')));
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Best Practice')),
      body: Center(
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 使用 watch 的值
            Text('Count: $count'),

            ElevatedButton(
              onPressed: () {
                // 3. read: 事件處理
                ref.read(counterProvider.notifier).state++;
              },
              child: Text('Increment'),
            ),

            ElevatedButton(
              onPressed: () {
                // 4. refresh: 重置
                final newState = ref.refresh(counterProvider);
                print('Reset to: $newState');
              },
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
