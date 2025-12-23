import 'package:flutter/material.dart';

// 動畫元件示範頁
class AnimationDemoPage extends StatelessWidget {
  const AnimationDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: 實作 AnimatedContainer 示範
    // TODO: 實作 Hero 動畫示範
    return Scaffold(
      appBar: AppBar(title: const Text('Animation Widgets')),
      body: const Center(
        child: Text(
          '這裡將展示動畫相關元件：AnimatedContainer, Hero 等',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
