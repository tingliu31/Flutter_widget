// lib/examples/function_practice.dart
// 这个文件用于练习 Dart 函数的宣告和使用
// 运行方式: dart lib/examples/function_practice.dart
import 'package:flutter/foundation.dart';

// typedef 定义在顶层（函数类型别名）
typedef Operation = int Function(int, int);

void main() {

  debugPrint('===================================');
  debugPrint('  Dart 函数宣告和使用练习');
  debugPrint('===================================');

  // 调用各个示范函数
  basicFunctions();
  functionParameters();
  arrowFunctions();
  anonymousFunctionsAndClosures();

  debugPrint('\n===================================');
  debugPrint('  练习完成！');
  debugPrint('===================================');
}

// 1. 基本函数宣告
void basicFunctions() {
  debugPrint('\n=== 1. 基本函数宣告 ===');

  // 1.1 无参数无返回值
  void sayHello() {
    debugPrint('Hello, Flutter!');
  }

  sayHello();

  // 1.2 有参数的函数
  void greet(String name) {
    debugPrint('你好, $name!');
  }

  greet('小明');

  // 1.3 有返回值的函数
  int add(int a, int b) {
    return a + b;
  }

  debugPrint('3 + 5 = ${add(3, 5)}');

  // 1.4 返回多种类型
  String getFullName(String firstName, String lastName) {
    return '$firstName $lastName';
  }

  debugPrint('全名: ${getFullName("张", "三")}');

  // 1.5 使用表达式作为返回值
  double multiply(double x, double y) {
    return x * y;
  }

  debugPrint('2.5 * 4 = ${multiply(2.5, 4)}');

  debugPrint('\n💡 提示: 函数可以有参数、返回值，也可以没有');
}

// 2. 可选参数和命名参数
void functionParameters() {
  debugPrint('\n=== 2. 可选参数和命名参数 ===');

  // 2.1 可选位置参数 []
  String? greet1(String name, [String? title]) {
    if (title != null) {
      return '你好, $title $name';
    }
    return null;
  } 

  var gggg = greet1;
  final result = gggg('小明');
  debugPrint("result: $result");
  debugPrint(greet1('小明')); // 不传可选参数
  debugPrint(greet1('小明', '先生')); // 传递可选参数

  // 2.2 可选位置参数带默认值
  String makeMessage(String content, [String prefix = '提示']) {
    return '[$prefix] $content';
  }

  debugPrint(makeMessage('操作成功'));
  debugPrint(makeMessage('操作失败', '错误'));

  // 2.3 命名参数 {}
  void showUserInfo({String? name, int? age, String? city}) {
    debugPrint('用户信息:');
    debugPrint('  姓名: ${name ?? "未知"}');
    debugPrint('  年龄: ${age ?? "未知"}');
    debugPrint('  城市: ${city ?? "未知"}');
  }

  showUserInfo(name: '李四', age: 25);
  showUserInfo(name: '王五', city: '台北', age: 30);
  showUserInfo(); // 不传任何参数

  // 2.4 必需的命名参数 (required)
  double calculateArea({required double width, required double height}) {
    return width * height;
  }

  debugPrint('面积: ${calculateArea(width: 5.0, height: 3.0)}');
  // 2.5 命名参数带默认值
  String createUrl({
    String protocol = 'https',
    required String domain,
    String path = '/',
  }) {
    return '$protocol://$domain$path';
  }

  debugPrint(createUrl(domain: 'flutter.dev'));
  debugPrint(createUrl(domain: 'dart.dev', path: '/guides'));
  debugPrint(createUrl(protocol: 'http', domain: 'localhost', path: '/api'));

  // 2.6 同时使用可选参数和命名参数（分开使用）
  // 注意：Dart 不允许在同一个函数中混合 [] 和 {}
  // 下面展示两种分别的用法

  // 只使用可选位置参数
  String buildMessage1(String text, [String? prefix, bool? uppercase]) {
    String result = prefix != null ? '$prefix: $text' : text;
    return (uppercase ?? false) ? result.toUpperCase() : result;
  }

  debugPrint(buildMessage1('你好'));
  debugPrint(buildMessage1('你好', '消息'));
  debugPrint(buildMessage1('你好', '消息', true));

  // 只使用命名参数
  String buildMessage2(String text, {String? prefix, bool uppercase = false}) {
    String result = prefix != null ? '$prefix: $text' : text;
    return uppercase ? result.toUpperCase() : result;
  }

  debugPrint(buildMessage2('你好'));
  debugPrint(buildMessage2('你好', prefix: '消息'));
  debugPrint(buildMessage2('你好', prefix: '消息', uppercase: true));
  debugPrint('\n💡 提示: [] 表示可选位置参数，{} 表示命名参数，required 表示必需');
}

int square(int n) {
  return n * n;
}

// 3. 箭头函数
void arrowFunctions() {
  debugPrint('\n=== 3. 箭头函数 ===');

  // 3.1 基本箭头函数（单表达式）
  int square(int n) => n * n;
  debugPrint('5 的平方: ${square(5)}');
  
  // 3.2 无返回值的箭头函数
  void printSquare(int n) => debugPrint('$n 的平方是 ${n * n}');
  printSquare(7);

  // 3.3 多参数箭头函数
  int max(int a, int b) => a > b ? a : b;
  debugPrint('最大值: ${max(10, 20)}');

  // 3.4 带命名参数的箭头函数
  String formatName({required String first, required String last}) =>
      '$first $last';
  debugPrint(formatName(first: '张', last: '三'));

  // 3.5 在 List 操作中使用箭头函数
  List<int> numbers = [1, 2, 3, 4, 5];

  // map: 转换每个元素
  List<int> doubled = numbers.map((n) => n * 2).toList();
  debugPrint('\n原列表: $numbers');
  debugPrint('翻倍后: $doubled');

  // where: 过滤元素
  List<int> evenNumbers = numbers.where((n) => n % 2 == 0).toList();
  debugPrint('偶数: $evenNumbers');
  // forEach: 遍历元素
  debugPrint('遍历输出:');
  numbers.forEach((n) => debugPrint('数字: $n'));

  // 3.6 复杂的箭头函数链式调用
  List<String> fruits = ['apple', 'banana', 'cherry', 'date'];
  List<String> result = fruits
      .where((fruit) => fruit.length > 5) // 筛选长度 > 5 的
      .map((fruit) => fruit.toUpperCase()) // 转大写
      .toList();
  debugPrint('处理后的水果: $result');

  debugPrint('\n💡 提示: => 适合单表达式函数，让代码更简洁');
}

// 4. 匿名函数和闭包
void anonymousFunctionsAndClosures() {
  debugPrint('\n=== 4. 匿名函数和闭包 ===');

  // 4.1 匿名函数基础
  var multiply = (int a, int b) {
    return a * b;
  };
  debugPrint('匿名函数: 3 * 4 = ${multiply(3, 4)}');

  // 4.2 匿名函数作为参数
  void executeOperation(int a, int b, Function operation) {
    debugPrint('执行操作结果: ${operation(a, b)}');
  }

  executeOperation(10, 5, (a, b) => a + b); // 加法
  executeOperation(10, 5, (a, b) => a - b); // 减法
  executeOperation(10, 5, (a, b) => a * b); // 乘法

  // 4.3 返回函数的函数
  Function makeAdder(int addBy) {
    // 返回一个函数，这个函数会"记住" addBy 的值
    return (int value) => value + addBy;
  }

  var add5 = makeAdder(5);
  var add10 = makeAdder(10);

  debugPrint('\nadd5(3) = ${add5(3)}'); // 3 + 5 = 8
  debugPrint('add10(3) = ${add10(3)}'); // 3 + 10 = 13

  // 4.4 闭包捕获外部变量
  Function makeGreeting(String language) {
    return (String name) {
      switch (language) {
        case 'zh':
          return '你好, $name!';
        case 'en':
          return 'Hello, $name!';
        case 'ja':
          return 'こんにちは, $name!';
        default:
          return 'Hi, $name!';
      }
    };
  }

  var greetInChinese = makeGreeting('zh');
  var greetInEnglish = makeGreeting('en');

  debugPrint('\n${greetInChinese('小明')}');
  debugPrint(greetInEnglish('Tom'));
  // 4.5 闭包的实际应用：计数器
  Function makeCounter() {
    int count = 0; // 私有变量，外部无法直接访问

    return () {
      count++;
      return count;
    };
  }

  var counter = makeCounter();
  debugPrint('\n计数器: ${counter()}'); // 1
  debugPrint('计数器: ${counter()}'); // 2
  debugPrint('计数器: ${counter()}'); // 3

  // 4.6 List 的高级操作（使用匿名函数）
  List<Map<String, dynamic>> users = [
    {'name': '小明', 'age': 25},
    {'name': '小红', 'age': 30},
    {'name': '小刚', 'age': 28},
  ];

  debugPrint('\n用户列表处理:');

  // 筛选年龄 >= 28 的用户
  var filteredUsers = users.where((user) => user['age'] >= 28).toList();
  debugPrint('年龄 >= 28: $filteredUsers');
  // 提取所有用户名
  var names = users.map((user) => user['name']).toList();
  debugPrint('所有用户名: $names');

  // 计算平均年龄
  var totalAge = users.fold(0, (sum, user) => sum + (user['age'] as int));
  var averageAge = totalAge / users.length;
  debugPrint('平均年龄: ${averageAge.toStringAsFixed(1)}');

  // 4.7 typedef 定义函数类型（已在文件顶部定义）
  debugPrint('\n⭐ 函数类型别名 (typedef):');
  debugPrint('typedef Operation = int Function(int, int);');
  int calculate(int a, int b, Operation op) {
    return op(a, b);
  }

  Operation addition = (a, b) => a + b;
  Operation subtraction = (a, b) => a - b;

  debugPrint('使用 typedef: ${calculate(10, 3, addition)}');
  debugPrint('使用 typedef: ${calculate(10, 3, subtraction)}');
  debugPrint('\n💡 提示: 闭包可以"记住"外部变量，这在 Flutter 回调中非常有用');
}
