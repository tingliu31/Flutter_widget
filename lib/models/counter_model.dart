import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//ChangeNotifier ------------------------------
class CounterModel extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();  //通知所有監聽者狀態已更新
  }

  void decrement() {
    if (count > 0) {
      _count--;
      notifyListeners();  //通知所有監聽者狀態已更新
    }
  }

  void reset() {
    _count = 0;
    notifyListeners();  //通知所有監聽者狀態已更新
  }
}


class CounterWithChangeNotifierPage extends StatefulWidget {
  const CounterWithChangeNotifierPage({super.key});

  @override
  State<CounterWithChangeNotifierPage> createState() =>
      _CounterWithChangeNotifierPageState();
}

class _CounterWithChangeNotifierPageState extends State<CounterWithChangeNotifierPage> {
  final model = CounterModel();

  @override
  void dispose() {
    model.dispose(); // ✅ 記得釋放
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ChangeNotifier Demo')),
      body: Center(
        child: AnimatedBuilder(
          animation: model, // 監聽 model
          builder: (context, _) {
            return Text('Count: ${model.count}', style: const TextStyle(fontSize: 28));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: model.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
