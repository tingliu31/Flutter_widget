// HTTP Practice Examples
// This file demonstrates how to make HTTP requests in Flutter

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_widget/models/user.dart';
import 'package:dio/dio.dart';


// class User {

//   final String name;
//   final int age;

//   User({
//     required this.name,
//     required this.age,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'age': age,
//     };
//   }

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       name: json['name'],
//       age: json['age'],
//     );
//   }
// }

void main() {

//user model: 跑完 dart run build_runner build 後，會生成 user.g.dart 檔案，裡面有 toJson 和 fromJson 方法
  //序列化
  // var user = User(name: 'Alice', age: 30);
  // var userJson = user.toJson();
  // debugPrint('User JSON: $userJson'); //User JSON: {name: Alice, age: 30}

  // //反序列化
  // var newUser = User.fromJson({'name': 'Bob', 'age': 25});
  // debugPrint('User Name: ${newUser.name}, Age: ${newUser.age}'); //User Name: Bob, Age: 25

  var user1 = User(name: 'Alice', age: 30);
  var user2 = user1.copyWith(age: 30);

  debugPrint('user1 == user2: ${user1 == user2}');

  var user3 = User.fromJson({'name': 'Bob', 'age': 25});
  debugPrint('User Name: ${user3.name}, Age: ${user3.age}'); //User Name: Bob, Age: 25
}


/// Simple GET request example
Future<void> fetchData() async {
  try {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
    );

    if (response.statusCode == 200) {
      debugPrint('Success: ${response.body}');
    } else {
      debugPrint('Error: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Exception: $e');
  }
}

/// POST request example
Future<void> postData() async {
  try {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: '{"title": "Test", "body": "This is a test post", "userId": 1}',
    );

    if (response.statusCode == 201) {
      debugPrint('Post successful: ${response.body}');
    } else {
      debugPrint('Error: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Exception: $e');
  }
}

/// PUT request example
Future<void> updateData(int id) async {
  try {
    final response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: '{"title": "Updated", "body": "This is updated", "userId": 1}',
    );

    if (response.statusCode == 200) {
      debugPrint('Update successful: ${response.body}');
    } else {
      debugPrint('Error: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Exception: $e');
  }
}

/// DELETE request example
Future<void> deleteData(int id) async {
  try {
    final response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
    );

    if (response.statusCode == 200) {
      debugPrint('Delete successful');
    } else {
      debugPrint('Error: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Exception: $e');
  }
}

/// Custom headers example
Future<void> requestWithHeaders() async {
  try {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {
        'Authorization': 'Bearer your_token_here',
        'Custom-Header': 'custom_value',
      },
    );

    if (response.statusCode == 200) {
      debugPrint('Request with headers successful');
    }
  } catch (e) {
    debugPrint('Exception: $e');
  }
}

/// Query parameters example
Future<void> requestWithQueryParams() async {
  try {
    final uri = Uri.parse('https://jsonplaceholder.typicode.com/posts').replace(
      queryParameters: {
        'userId': '1',
        '_limit': '5',
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      debugPrint('Query params request successful');
    }
  } catch (e) {
    debugPrint('Exception: $e');
  }
}



/// Dio request example

Future<void> getHttp() async {
  try {
    final _ = await Dio().get('https://api.emample.com/test');
  } catch (e) {
    debugPrint('Exception: $e');
  }
}



Future<void> dioRequest() async {
  try {
    final _ = await Dio().get('https://jsonplaceholder.typicode.com/posts/1');
  } catch (e) {
    debugPrint('Exception: $e');
  }
}