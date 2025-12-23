import 'package:flutter/material.dart';

// 表單元件示範頁
class FormsDemoPage extends StatelessWidget {
  const FormsDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: 實作 TextField 示範
    // TODO: 實作 Form 驗證示範
    // TODO: 實作 Checkbox/Radio/Switch 示範
    return Scaffold(
      appBar: AppBar(title: const Text('Form Widgets')),
      body: const Center(
        child: Text(
          '這裡將展示表單相關元件：TextField, Form, Checkbox 等',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
