import 'package:flutter/material.dart';

// 1. 定義一個簡單的函式
String greet(String name) {
  print('$name!');
  return 'Hello, $name!';
}

// 定義一個接受函式作為參數的函式
void executeOperation(int a, int b, int Function(int, int) operation) {
  var result = operation(a, b);
  print('結果: $result');
}

// 定義不同的運算函式
int add(int x, int y) => x + y;
int multiply(int x, int y) => x * y;

// 通用的資料包裝類別
class Box<T> {
  final T value;

  Box(this.value);

  T getValue() => value;

  void printValue() {
    print('Box 裡面的值: $value');
  }
}

enum Color { red, green, blue, yellow }

// 使用範例
void main() {
  final VoidCallback onPressed;

  // 2. 將函式賦值給變數
  var greeting = greet;

  // 3. 透過變數呼叫函式
  print(greeting('Ting')); // 輸出: Hello, Ting!

  executeOperation(5, 3, add); // 輸出: 結果: 8
  executeOperation(5, 3, multiply); // 輸出: 結果: 15

  var stringBox = Box<String>('Hello');
  var intBox = Box<int>(42);
  var listBox = Box<List<int>>([1, 2, 3]);

  print(stringBox.getValue()); // Hello
  print(intBox.getValue()); // 42
  print(listBox.getValue()); // [1, 2, 3]

  // 建立一個 Record（使用小括號）
  var person = ('Ting', age: 28);

  // 存取元素（從 $1 開始，不是從 0）
  print(person.$1); // Ting
  print(person.age); //28

  // 型別是 (String, int)
  print(person.runtimeType); // (String, int)

  (String, {int age}) typedPerson = ('Alice', age: 25);

  // 基礎解構：從陣列中提取數據
  var numbers = [1, 2, 3];
  var [first, second, third] = numbers;
  print('第一個數字是 $second'); // 輸出：第一個數字是 1

  var colors = ['red', 'green', 'blue'];
  // 只取需要的元素
  var [firstColor, ...others] = colors;
  print(firstColor); // red
  print(others); // [green, blue]

  // 跳過某些元素
  var [_, _, lastColor] = colors;
  print(lastColor); // blue

  // 對象解構：從 Map 中提取數據
  var people = {'name': '小明', 'age': 25};
  var {'name': name, 'age': age} = people;
  print('$name 今年 $age 歲'); // 輸出：小明 今年 25 歲

  // 複雜結構解構
  var data = {
    'user': {
      'profile': {'name': '小華', 'age': 30},
    },
  };
  var {'user': {'profile': {'name': userName}}} = data;
  print('用戶名：$userName'); // 輸出：用戶名：小華

  var numberLiat = [1, 2, 3, 4, 5];
  var evenNumbers = [
    for (var n in numberLiat)
      if (n.isEven) n,
  ];

  // 從 List 解構
  var [a, b] = [1, 2];
  print('a = $a'); // a = 1
  print('b = $b'); // b = 2

  // 從 Record 解構
  var (x, y) = (10, 20);
  print('x = $x'); // x = 10
  print('y = $y'); // y = 20

  // 字串解構
  var [firstText, secondText] = ['Hello', 'World'];
  print('$first $second'); // Hello World

  var names = ['alice', 'bob', 'charlie', 'david'];

  // 只要長度大於 4 的名字，並轉成大寫
  var longNames = [
    for (var name in names)
      if (name.length > 4) name.toUpperCase(),
  ];

  var favoriteColor = Color.red;

  print(favoriteColor); // Color.red
  print(favoriteColor.name); // red
  print(favoriteColor.index); // 0 (索引從 0 開始)

  // 列出所有值
  print(Color.values); // [Color.red, Color.green, Color.blue, Color.yellow]


}

String getGrade(int score) {
  return switch (score) {
    >= 90 => 'A',
    >= 80 => 'B',
    >= 70 => 'C',
    >= 60 => 'D',
    _ => 'F', // _ 是預設情況（萬用字元）
  };
}

//匹配 Record 的值
String describePoint((int, int) point) {
  return switch (point) {
    (0, 0) => '原點',
    (var x, 0) => 'X軸上的點 ($x, 0)',
    (0, var y) => 'Y軸上的點 (0, $y)',
    (var x, var y) when x == y => '對角線上 ($x, $y)',
    (var x, var y) when x > 0 && y > 0 => '第一象限 ($x, $y)',
    (var x, var y) => '其他位置 ($x, $y)',
  };
}

//匹配 Map 的內容
void handleResponse(Map<String, dynamic> response) {
  switch (response) {
    case {'status': 'success', 'data': var data}:
      print('成功: $data');

    case {'status': 'error', 'code': 404}:
      print('錯誤: 找不到資源');

    case {'status': 'error', 'code': var code, 'message': var msg}:
      print('錯誤 $code: $msg');

    case {'status': 'loading'}:
      print('載入中...');

    default:
      print('未知的回應格式');
  }
}

class User {
  final String name;
  final int age;
  final String role;

  User(this.name, this.age, this.role);
}

//匹配類別實例
String describeUser(User user) {
  return switch (user) {
    User(age: < 18) => '${user.name} 是未成年人',
    User(role: 'admin', name: var userName) => '$userName 是管理員',
    User(role: 'moderator', name: var userName, age: var userAge) =>
      '$userName ($userAge歲) 是版主',
    User(name: var userName, age: var userAge) when userAge >= 65 =>
      '$userName 是資深使用者',
    User(name: var userName) => '$userName 是一般使用者',
  };
}

void processData(dynamic data) {
  // 條件檢查與解構
  if (data case {'status': 'success', 'user': var user}) {
    print('成功取得使用者: $user');
  } else if (data case {'status': 'error', 'message': var msg}) {
    print('錯誤: $msg');
  } else {
    print('未知格式');
  }
}

void checkAge(int age) {
  if (age case var a when a >= 18) {
    print('$a 歲，已成年');
  } else {
    print('$age 歲，未成年');
  }
}

enum TrafficLight {
  red,
  yellow,
  green,
}

String getAction(TrafficLight light) {
  return switch (light) {
    .red => '停止',
    .yellow => '準備',
    .green => '通行',
  };
}


enum Planet {
  mercury(3.7, 0.055),
  venus(8.87, 0.815),
  earth(9.81, 1.0),
  mars(3.71, 0.107);
  
  // 屬性
  /// 重力
  final double gravity;
  /// 質量
  final double mass;         
  
  // 建構子
  const Planet(this.gravity, this.mass);
  
  // 方法
  double surfaceWeight(double earthWeight) {
    return earthWeight * gravity / Planet.earth.gravity;
  }
}


enum HttpMethod {
  get,
  post,
  put,
  delete,
  patch;
  
  // 判斷是否需要 body
  bool get needsBody {
    return switch (this) {
      HttpMethod.post || HttpMethod.put || HttpMethod.patch => true,
      _ => false,
    };
  }
}

enum UserRole {
  guest(
    displayName: '訪客',
    permissions: [],
  ),
  user(
    displayName: '一般使用者',
    permissions: ['read', 'comment'],
  ),
  moderator(
    displayName: '版主',
    permissions: ['read', 'comment', 'edit', 'delete'],
  ),
  admin(
    displayName: '管理員',
    permissions: ['read', 'comment', 'edit', 'delete', 'manage_users'],
  );
  
  final String displayName;
  final List<String> permissions;
  
  const UserRole({
    required this.displayName,
    required this.permissions,
  });
  
  bool hasPermission(String permission) {
    return permissions.contains(permission);
  }
  
  bool get canDelete => hasPermission('delete');
  bool get canEdit => hasPermission('edit');
  bool get canManageUsers => hasPermission('manage_users');
}


mixin Moveable {
  int x = 0;
  int y = 0;
  
  void move(int deltaX, int deltaY) {
    x += deltaX;
    y += deltaY;
    print('移動到位置: ($x, $y)');
  }
}


