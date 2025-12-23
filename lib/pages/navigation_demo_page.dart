import 'package:flutter/material.dart';

// 導航元件示範頁
class NavigationDemoPage extends StatelessWidget {
  const NavigationDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: 實作 BottomNavigationBar 示範
    // TODO: 實作 Drawer 示範
    return Scaffold(
      appBar: AppBar(title: const Text('Navigation Widgets')),
      body: const Center(
        child: Text(
          '這裡將展示導航相關元件：BottomNavigationBar, Drawer 等',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
