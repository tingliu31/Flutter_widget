import 'package:flutter/material.dart';

// 示範項目資料模型
// 用於定義導航選單中每個項目的資訊
class DemoItem {
  const DemoItem({
    required this.title,
    required this.subtitle,
    required this.page,
    this.icon,
  });

  final String title; // 示範項目標題
  final String subtitle; // 示範項目描述
  final Widget page; // 目標頁面
  final IconData? icon; // 可選的圖示
}
