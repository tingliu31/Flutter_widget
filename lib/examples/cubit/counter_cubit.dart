import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0); // 初始 state = 0

  void increment() => emit(state + 1);

  void decrement() => emit(state - 1);

  void reset() => emit(0);

  @override
  void onChange(Change<int> change) {
    // change.currentState 舊值、change.nextState 新值
    print('CounterCubit onChange: old state: ${change.currentState}, new state: ${change.nextState}');
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // TODO: implement onError
    print('CounterCubit onError: $error');
    super.onError(error, stackTrace);
  }
  
}

