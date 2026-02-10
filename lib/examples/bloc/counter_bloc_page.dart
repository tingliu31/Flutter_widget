import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_bloc.dart';

class CounterBlocPage extends StatelessWidget {
  const CounterBlocPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: const CounterBlocView(),
    );
  }
}

class CounterBlocView extends StatelessWidget {
  const CounterBlocView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter Bloc')),
      body: Center(
        child: BlocBuilder<CounterBloc, int>(
          builder: (context, count) {
            return Column(
              children: [
                Text('Count: $count', style: const TextStyle(fontSize: 28)),
                ElevatedButton(
                  onPressed: () => context.read<CounterBloc>().add(CounterIncrementPressed()), 
                  child: const Text('Increment')
                  ),
                ElevatedButton(
                  onPressed: () => context.read<CounterBloc>().add(CounterDecrementPressed()), 
                  child: const Text('Decrement')
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}