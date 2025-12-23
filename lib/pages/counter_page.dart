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