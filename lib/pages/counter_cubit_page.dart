import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0); // 初始 state = 0

  void increment() => emit(state + 1);

  void decrement() => emit(state - 1);

  void reset() => emit(0);
}

class CounterCubitPage extends StatelessWidget {
  const CounterCubitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Cubit Counter')),
        body: Center(
          child: BlocBuilder<CounterCubit, int>(
            builder: (context, count) {
              return Text('Count: $count', style: const TextStyle(fontSize: 28));
            },
          ),
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: 'inc',
              onPressed: () => context.read<CounterCubit>().increment(),
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 12),
            FloatingActionButton(
              heroTag: 'dec',
              onPressed: () => context.read<CounterCubit>().decrement(),
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}