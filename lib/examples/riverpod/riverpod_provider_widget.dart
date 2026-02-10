import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget/examples/riverpod/counter_notifier.dart';

// Provider: 依賴 counterProvider
final doubledCounterProvider = Provider((ref) {
  final count = ref.watch(counterProvider);  // ← 依賴追蹤
  return count * 2;
});

void main() {
  final container = ProviderContainer();
  
  // 監聽 doubledCounterProvider 的變化
  container.listen<int>(
    doubledCounterProvider,
    (previous, next) {
      print('Doubled count changed from $previous to $next');
    },
    fireImmediately: true,
  );
  
  // 印出初始值
  print('Initial count: ${container.read(counterProvider)}');
  print('Initial doubled count: ${container.read(doubledCounterProvider)}');

  // 更新
  container.read(counterProvider.notifier).state = 10;
  print('Updated count: ${container.read(counterProvider)}');
  print('Updated doubled count: ${container.read(doubledCounterProvider)}');

  // 再次更新
  container.read(counterProvider.notifier).state = 20;

  container.dispose();
}