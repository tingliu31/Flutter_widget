import 'package:flutter/material.dart';
import '../models/demo_item.dart';
import 'layout_page.dart';
import 'counter_page.dart';
import 'forms_demo_page.dart';
import 'lists_demo_page.dart';
import 'navigation_demo_page.dart';
import 'animation_demo_page.dart';

// 主導航頁面
// 顯示所有 Widget 示範的分類選單
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Widget 學習'),
      ),
      body: ListView(
        children: [
          _buildCategory(context, '基礎佈局', _getLayoutDemos()),
          _buildCategory(context, '狀態管理', _getStateDemos()),
          _buildCategory(context, '表單元件', _getFormDemos()),
          _buildCategory(context, '列表元件', _getListDemos()),
          _buildCategory(context, '導航元件', _getNavigationDemos()),
          _buildCategory(context, '動畫元件', _getAnimationDemos()),
        ],
      ),
    );
  }

  // 建立分類區塊（包含標題和項目列表）
  Widget _buildCategory(BuildContext context, String title, List<DemoItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 分類標題
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.grey[200],
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
        // 分類項目
        ...items.map((item) => ListTile(
          leading: Icon(item.icon),
          title: Text(item.title),
          subtitle: Text(item.subtitle),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => item.page),
            );
          },
        )),
      ],
    );
  }

  // 基礎佈局示範項目
  List<DemoItem> _getLayoutDemos() => [
    const DemoItem(
      title: 'Container, Row, Column 練習',
      subtitle: '基礎佈局元件示範',
      page: LayoutPage(),
      icon: Icons.view_quilt,
    ),
  ];

  // 狀態管理示範項目
  List<DemoItem> _getStateDemos() => [
    const DemoItem(
      title: 'ChangeNotifier 練習',
      subtitle: 'Provider 狀態管理示範',
      page: CounterPage(),
      icon: Icons.add_circle_outline,
    ),
  ];

  // 表單元件示範項目
  List<DemoItem> _getFormDemos() => [
    const DemoItem(
      title: '表單元件練習',
      subtitle: 'TextField, Form, Checkbox 等',
      page: FormsDemoPage(),
      icon: Icons.edit_note,
    ),
  ];

  // 列表元件示範項目
  List<DemoItem> _getListDemos() => [
    const DemoItem(
      title: '列表元件練習',
      subtitle: 'ListView, GridView 等',
      page: ListsDemoPage(),
      icon: Icons.list,
    ),
  ];

  // 導航元件示範項目
  List<DemoItem> _getNavigationDemos() => [
    const DemoItem(
      title: '導航元件練習',
      subtitle: 'BottomNavigationBar, Drawer 等',
      page: NavigationDemoPage(),
      icon: Icons.navigation,
    ),
  ];

  // 動畫元件示範項目
  List<DemoItem> _getAnimationDemos() => [
    const DemoItem(
      title: '動畫元件練習',
      subtitle: 'AnimatedContainer, Hero 等',
      page: AnimationDemoPage(),
      icon: Icons.animation,
    ),
  ];
}
