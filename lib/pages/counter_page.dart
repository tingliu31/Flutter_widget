import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/counter_model.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 只要 CounterModel notifyListeners()，這個 Text 就會自動重建更新
    final count = context.watch<CounterModel>().count;

    return Scaffold(
      appBar: AppBar(title: const Text('ChangeNotifier Practice')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Count: $count', style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () => context.read<CounterModel>().increment(),
                  child: const Text('+1'),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () => context.read<CounterModel>().reset(),
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CounterProvider extends InheritedWidget {
  final int counter;
  final VoidCallback increment;

  CounterProvider({
    Key? key,
    required this.counter,
    required this.increment,
    required Widget child,
  }) : super(key: key, child: child);

  static CounterProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(CounterProvider oldWidget) {
    return counter != oldWidget.counter;
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});
  //從上層的 CounterProvider 取出共享的狀態與方法，並用它們來顯示計數器與觸發 +1
  @override
  Widget build(BuildContext context) {
    //內部調用的是 context.dependOnInheritedWidgetOfExactType<CounterProvider>()，往上找 最近的 CounterProvider
    final provider = CounterProvider.of(context);
    if (provider == null) {
      return const SizedBox();
    }
    return Scaffold(
      appBar: AppBar(title: const Text('InheritedWidget Practice')),
      body: Center(
        child: Column(
          children: [
            Text('Count: ${provider.counter}'),
            ElevatedButton(
              onPressed: provider.increment,
              child: Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}

class CounterApp extends StatefulWidget {
  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  //CounterProvider(...) 被建立並插入 widget tree
  //CounterWidget() 被放在 CounterProvider 的下面（child 子樹）， CounterWidget 以及它的所有子孫 widget 都可以用
  @override
  Widget build(BuildContext context) {
    return CounterProvider(
      counter: _counter,
      increment: _incrementCounter,
      child: CounterWidget(),
    );
  }
}

//ValueNotifier ------------------------------

class CounterWithValueNotifierPage extends StatefulWidget {
  const CounterWithValueNotifierPage({super.key});

  @override
  State<CounterWithValueNotifierPage> createState() =>
      _CounterWithValueNotifierPageState();
}

class _CounterWithValueNotifierPageState extends State<CounterWithValueNotifierPage> {
  final ValueNotifier<int> counter = ValueNotifier<int>(0);

  @override
  void dispose() {
    counter.dispose();
    super.dispose();
  }

  void increment() => counter.value++;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ValueNotifier Counter')),
      body: Center(
        child: ValueListenableBuilder<int>(
          valueListenable: counter,
          builder: (context, value, _) {
            return Text('Count: $value', style: const TextStyle(fontSize: 28));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
