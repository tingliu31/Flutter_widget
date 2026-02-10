import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_cubit.dart';

class CounterCubitPage extends StatelessWidget {
  const CounterCubitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const CubitCounterView(),
    );
  }
}

class CubitCounterView extends StatelessWidget {
  const CubitCounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cubit Counter')),
      body: Center(
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, count) {
            return Column(
              children: [
                Text('Count: $count', style: const TextStyle(fontSize: 28)),
                ElevatedButton(
                  onPressed: () => context.read<CounterCubit>().increment(), 
                  child: const Text('Increment')),
              ],
            );
          },
        ),
      ),
    );
  }
}