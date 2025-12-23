import 'package:flutter/material.dart';
import '../widgets/bordered_image.dart';

// LayoutPage: 互動式 MainAxisAlignment 示範
// 使用者可以透過 SegmentedButton 切換不同的對齊方式
// 同時觀察 Row 和 Column 的視覺差異
class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  // 儲存使用者選擇的對齊方式
  MainAxisAlignment _selectedAlignment = MainAxisAlignment.start;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Layout Practice')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 控制區：SegmentedButton 切換 mainAxisAlignment
            _buildAlignmentControl(),
            const SizedBox(height: 24),

            // Row 示範區
            _buildDemoSection(
              'Row 範例',
              RowWithImages(mainAxisAlignment: _selectedAlignment),
            ),
            const SizedBox(height: 32),

            // Column 示範區（需要固定高度才能看出對齊效果）
            _buildDemoSection(
              'Column 範例',
              SizedBox(
                height: 400,
                child: ColumnWithImages(mainAxisAlignment: _selectedAlignment),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 建立標題區塊：標題 + 帶邊框的示範內容
  Widget _buildDemoSection(String title, Widget demo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8),
          child: demo,
        ),
      ],
    );
  }

  // 建立 SegmentedButton 控制元件
  Widget _buildAlignmentControl() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'MainAxisAlignment 設定：',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SegmentedButton<MainAxisAlignment>(
          segments: const [
            ButtonSegment(
              value: MainAxisAlignment.start,
              label: Text('Start'),
            ),
            ButtonSegment(
              value: MainAxisAlignment.end,
              label: Text('End'),
            ),
            ButtonSegment(
              value: MainAxisAlignment.center,
              label: Text('Center'),
            ),
            ButtonSegment(
              value: MainAxisAlignment.spaceBetween,
              label: Text('Between'),
            ),
            ButtonSegment(
              value: MainAxisAlignment.spaceAround,
              label: Text('Around'),
            ),
            ButtonSegment(
              value: MainAxisAlignment.spaceEvenly,
              label: Text('Evenly'),
            ),
          ],
          selected: {_selectedAlignment},
          onSelectionChanged: (Set<MainAxisAlignment> newSelection) {
            setState(() {
              _selectedAlignment = newSelection.first;
            });
          },
        ),
      ],
    );
  }
}

// Container 示範（保留供未來使用）
class ContainerWithImage extends StatelessWidget {
  const ContainerWithImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow.withValues(alpha: 0.2),
      padding: const EdgeInsets.all(16), //padding 內距
      child: const BorderedImage(image: AssetImage('assets/images/cats.jpg')),
    );
  }
}

// Row 示範：接受 mainAxisAlignment 參數
class RowWithImages extends StatelessWidget {
  const RowWithImages({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start, // 預設值
  });

  final MainAxisAlignment mainAxisAlignment; // 可從外部傳入

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment, // 使用參數
      children: const [
        BorderedImage(image: AssetImage('assets/images/cats.jpg')),
        BorderedImage(image: AssetImage('assets/images/cats.jpg')),
        BorderedImage(image: AssetImage('assets/images/cats.jpg')),
        // Expanded(child: BorderedImage(image: AssetImage('assets/images/cats.jpg'))),
        // Expanded(flex: 2, child: BorderedImage(image: AssetImage('assets/images/cats.jpg'))),
        // Expanded(child: BorderedImage(image: AssetImage('assets/images/cats.jpg'))),
      ],
    );
  }
}

// Column 示範：接受 mainAxisAlignment 參數
class ColumnWithImages extends StatelessWidget {
  const ColumnWithImages({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly, // 預設值
  });

  final MainAxisAlignment mainAxisAlignment; // 可從外部傳入

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment, // 使用參數
      children: const [
        BorderedImage(image: AssetImage('assets/images/cats.jpg')),
        BorderedImage(image: AssetImage('assets/images/cats.jpg')),
        BorderedImage(image: AssetImage('assets/images/cats.jpg')),
      ],
    );
  }
}
