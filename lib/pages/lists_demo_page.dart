import 'package:flutter/material.dart';

// 列表元件示範頁
class ListsDemoPage extends StatelessWidget {
  const ListsDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: 實作 ListView 示範
    // TODO: 實作 GridView 示範
    return Scaffold(
      appBar: AppBar(title: const Text('List Widgets')),
      body: const Center(
        child: Text(
          '這裡將展示列表相關元件：ListView, GridView 等',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
