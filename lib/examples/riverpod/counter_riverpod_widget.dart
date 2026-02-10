import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget/examples/riverpod/counter_notifier.dart';

class CounterRiverpodWidget extends ConsumerWidget {
  const CounterRiverpodWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final count = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Counter Riverpod')),
      body: Center(
        child: Column(
          spacing: 16,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Count: $count', style: const TextStyle(fontSize: 28)),
            ElevatedButton(
              onPressed: () => ref.read(counterProvider.notifier).increment(), 
              child: const Text('Increment')
              ),
            ElevatedButton(
              onPressed: () => ref.read(counterProvider.notifier).decrement(), 
              child: const Text('Decrement')
              ),
            ElevatedButton(
              onPressed: () => ref.read(counterProvider.notifier).reset(), 
              child: const Text('Reset')
              ),
          ],
        ),
      ),
    );
  }
}