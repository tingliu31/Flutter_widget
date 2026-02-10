import 'package:flutter_bloc/flutter_bloc.dart';

//sealed（Dart 3）代表：只能在同一個檔案內被繼承/實作，可以避變免 CounterEvent 在其他地方被繼承或使用
sealed class CounterEvent {}
final class CounterIncrementPressed extends CounterEvent {}
final class CounterDecrementPressed extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {

  CounterBloc() : super(0) {
    on<CounterIncrementPressed>((event, emit) => emit(state + 1));
    on<CounterDecrementPressed>((event, emit) => emit(state - 1));
  }

  @override
  void onEvent(CounterEvent event) {
    // TODO: implement onEvent
    super.onEvent(event);
    print('CounterBloc onEvent: $event');
  }

  @override
  void onChange(Change<int> change) {
    // TODO: implement onChange
    super.onChange(change);
    print('CounterBloc onChange: old state: ${change.currentState}, new state: ${change.nextState}');
  }

  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    super.onTransition(transition);
    print('CounterBloc onTransition: ${transition}');
  }

}


