// lib/examples/variable_practice.dart
// 這個文件用於練習 Dart 變數的宣告和使用
// 運行方式: dart lib/examples/variable_practice.dart
import 'package:flutter/foundation.dart';

void main() {
  debugPrint('===================================');
  debugPrint('  Dart 變數宣告和使用練習');
  debugPrint('===================================');

  // 調用各個示範函數
  basicTypes();
  stringAndBoolean();
  typeInference();
  dynamicType();
  constants();
  nullableTypes();
  collections();
  practicalOperations();

  debugPrint('\n===================================');
  debugPrint('  練習完成！');
  debugPrint('===================================');
}

// 1. 基本數值類型 (int, double)
void basicTypes() {
  debugPrint('\n=== 1. 基本數值類型 ===');

  // 整數 (int) - 用於存儲整數值
  int age = 25;
  int year = 2024;

  // 浮點數 (double) - 用於存儲小數值
  double price = 19.99;
  double pi = 3.14159;

  debugPrint('年齡: $age');
  debugPrint('年份: $year');
  debugPrint('價格: \$$price');
  debugPrint('圓周率: $pi');
}

// 2. 字符串和布林類型
void stringAndBoolean() {
  debugPrint('\n=== 2. 字符串和布林類型 ===');

  // 字符串 (String)
  String name = "Flutter";
  String greeting = 'Hello, $name!'; // 字符串插值
  String multiLine = """
這是一個
多行字符串
範例""";

  // 布林值 (bool) - 只有 true 或 false
  bool isActive = true;
  bool isCompleted = false;

  debugPrint('名稱: $name');
  debugPrint('問候: $greeting');
  debugPrint('多行字符串: $multiLine');
  debugPrint('啟用狀態: $isActive');
  debugPrint('完成狀態: $isCompleted');
}

// 3. 型別推斷 (var)
void typeInference() {
  debugPrint('\n=== 3. 型別推斷 (var) ===');

  // var: Dart 會自動推斷變數的類型
  var inferredInt = 100; // 自動推斷為 int
  var inferredString = "text"; // 自動推斷為 String
  var inferredDouble = 3.14; // 自動推斷為 double

  // 注意：一旦類型確定，就不能改變
  // inferredInt = "字符串";  // ❌ 錯誤！類型已確定為 int

  debugPrint('推斷的整數: $inferredInt (類型: ${inferredInt.runtimeType})');
  debugPrint('推斷的字符串: $inferredString (類型: ${inferredString.runtimeType})');
  debugPrint('推斷的浮點數: $inferredDouble (類型: ${inferredDouble.runtimeType})');
}

// 4. 動態類型 (dynamic)
void dynamicType() {
  debugPrint('\n=== 4. 動態類型 (dynamic) ===');

  // dynamic: 可以在運行時改變類型
  dynamic flexibleVar = 42;
  debugPrint('初始值: $flexibleVar (類型: ${flexibleVar.runtimeType})');

  flexibleVar = "現在是字符串";
  debugPrint('改變後: $flexibleVar (類型: ${flexibleVar.runtimeType})');

  flexibleVar = true;
  debugPrint('再次改變: $flexibleVar (類型: ${flexibleVar.runtimeType})');

  flexibleVar = [1, 2, 3];
  debugPrint('最後改變: $flexibleVar (類型: ${flexibleVar.runtimeType})');
}

// 5. 常量宣告 (final, const)
void constants() {
  debugPrint('\n=== 5. 常量宣告 (final, const) ===');

  // final: 運行時確定的常量
  final currentTime = DateTime.now();

  // const: 編譯時確定的常量
  const double PI = 3.14159;



  const String finalName = "Flutter";
  const int maxUsers = 100;

  debugPrint('Final 值: $finalName');
  debugPrint('當前時間 (final): $currentTime');
  debugPrint('Const 圓周率: $PI');
  debugPrint('Const 最大用戶數: $maxUsers');

  // finalName = "Dart";  // ❌ 錯誤！final 變數不能重新賦值
  // PI = 3.14;           // ❌ 錯誤！const 變數不能重新賦值

  debugPrint('\n提示: final 和 const 的差異');
  debugPrint('- final: 運行時確定，適用於需要在運行時計算的值');
  debugPrint('- const: 編譯時確定，適用於真正的常量');
}

// 6. 可空類型 (Nullable)
void nullableTypes() {
  debugPrint('\n=== 6. 可空類型 (Nullable) ===');

  // 可空類型：類型後加 ? 表示可以是 null

  String? nullableString = "可以是 null";


  debugPrint('可空字符串: $nullableString');

  nullableString = null; // 允許
  debugPrint('設為 null: $nullableString');

  // 非可空類型：不能是 null
  String nonNullable = "必須有值";
  // nonNullable = null;  // ❌ 編譯錯誤
  debugPrint('非可空字符串: $nonNullable');

  // 空值檢查操作符
  String? maybeNull = null;
  String result1 = maybeNull ?? "預設值"; // ?? 提供預設值
  int? length = maybeNull?.length; // ?. 安全訪問

  debugPrint('使用 ?? 操作符: $result1');
  debugPrint('使用 ?. 操作符: $length');

  // 實際例子
  String? userName; // 用戶可能未登入
  debugPrint('顯示用戶名: ${userName ?? "訪客"}');
}

// 7. 集合類型 (List, Map, Set)
void collections() {
  debugPrint('\n=== 7. 集合類型 ===');

  // List（列表）- 有序集合
  List<int> numbers = [1, 2, 3, 4, 5];
  List<String> fruits = ["蘋果", "香蕉", "橘子"];

  debugPrint('數字列表: $numbers');
  debugPrint('第一個水果: ${fruits[0]}');
  debugPrint('列表長度: ${fruits.length}');

  // Map（映射）- 鍵值對集合
  Map<String, int> ages = {"Alice": 25, "Bob": 30, "Charlie": 35};

  debugPrint('\n年齡映射: $ages');
  debugPrint('Alice 的年齡: ${ages["Alice"]}');
  debugPrint('所有人名: ${ages.keys.toList()}');

  // Set（集合）- 無序且唯一的集合
  Set<String> uniqueNames = {"Flutter", "Dart"}; // 重複的會被移除

  debugPrint('\n唯一名稱集合: $uniqueNames');
  debugPrint('集合大小: ${uniqueNames.length}');
  debugPrint('包含 Dart: ${uniqueNames.contains("Dart")}');
}

// 8. 實用操作和型別轉換
void practicalOperations() {
  debugPrint('\n=== 8. 實用操作 ===');

  // 型別檢查
  var value = 42;
  debugPrint('value = $value');
  debugPrint('是否為 String: ${value is String}');

  // 型別轉換
  debugPrint('\n型別轉換示範:');
  String numberStr = "123";
  int number = int.parse(numberStr);
  debugPrint('字符串轉整數: "$numberStr" -> $number');

  double decimal = 45.67;
  String decimalStr = decimal.toString();
  debugPrint('數字轉字符串: $decimal -> "$decimalStr"');
  // 列表操作
  debugPrint('\n列表操作示範:');
  List<int> nums = [1, 2, 3];
  debugPrint('原始列表: $nums');
  nums.add(4); // 添加元素
  debugPrint('添加 4 後: $nums');

  nums.remove(2); // 移除元素
  debugPrint('移除 2 後: $nums');

  nums.addAll([5, 6]); // 添加多個元素
  debugPrint('添加 [5, 6] 後: $nums');

  // 字符串操作
  debugPrint('\n字符串操作示範:');
  String text = "Flutter Development";
  debugPrint('原字符串: $text');
  debugPrint('轉大寫: ${text.toUpperCase()}');
  debugPrint('轉小寫: ${text.toLowerCase()}');
  debugPrint('包含 Flutter: ${text.contains("Flutter")}');
  debugPrint('分割: ${text.split(" ")}');
}
