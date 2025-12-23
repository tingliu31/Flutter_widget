import 'package:flutter/foundation.dart';

class CounterModel extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // ★ 通知所有監聽者：狀態變了
  }

  void reset() {
    _count = 0;
    notifyListeners();
  }
}