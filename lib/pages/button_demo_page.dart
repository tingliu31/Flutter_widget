import 'package:flutter/material.dart';

// Button 互動式樣式示範頁面
// 使用者可以透過多種控制元件調整 Button 的樣式屬性
class ButtonDemoPage extends StatefulWidget {
  const ButtonDemoPage({super.key});

  @override
  State<ButtonDemoPage> createState() => _ButtonDemoPageState();
}

class _ButtonDemoPageState extends State<ButtonDemoPage> {
  // Button 類型選擇
  String _buttonType = 'elevatedddddddd'; // 'elevated', 'text', 'outlined', 'icon'

  // 顏色選擇
  String _colorOption = 'primary'; // 'primary', 'error', 'success'

  // 大小控制
  double _padding = 16.0; // 8-32
  double _height = 48.0; // 32-64

  // 形狀選擇
  String _shape = 'rounded'; // 'rectangular', 'rounded', 'pill'

  // 陰影控制（僅適用於 ElevatedButton）
  double _elevation = 4.0; // 0-12

  // 文字大小
  double _fontSize = 16.0; // 12-24

  // 狀態切換
  bool _isEnabled = true; // 啟用/停用
  bool _hasIcon = false; // 是否顯示圖示

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Button Widgets Practice')),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(), // 改善滑動流暢度
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 控制面板區
            _buildControlPanel(),
            const SizedBox(height: 32),

            // Button 預覽區
            _buildPreviewSection(),
            const SizedBox(height: 32),

            // 程式碼範例區
            _buildCodeSection(),
          ],
        ),
      ),
    );
  }

  // 控制面板（包含所有控制元件）
  Widget _buildControlPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '控制面板',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        // Button 類型選擇
        _buildButtonTypeControl(),
        const SizedBox(height: 16),

        // 顏色選擇
        _buildColorControl(),
        const SizedBox(height: 16),

        // 形狀選擇
        _buildShapeControl(),
        const SizedBox(height: 16),

        // Padding 滑桿
        _buildSliderControl(
          '內距 (Padding)',
          _padding,
          8,
          32,
          (value) => setState(() => _padding = value),
        ),
        const SizedBox(height: 16),

        // Height 滑桿
        _buildSliderControl(
          '高度 (Height)',
          _height,
          32,
          64,
          (value) => setState(() => _height = value),
        ),
        const SizedBox(height: 16),

        // Elevation 滑桿（僅 ElevatedButton）
        if (_buttonType == 'elevated') ...[
          _buildSliderControl(
            '陰影 (Elevation)',
            _elevation,
            0,
            12,
            (value) => setState(() => _elevation = value),
          ),
          const SizedBox(height: 16),
        ],

        // Font Size 滑桿
        _buildSliderControl(
          '文字大小',
          _fontSize,
          12,
          24,
          (value) => setState(() => _fontSize = value),
        ),
        const SizedBox(height: 16),

        // Switch 控制
        _buildSwitchControl(
          '啟用按鈕',
          _isEnabled,
          (value) => setState(() => _isEnabled = value),
        ),
        const SizedBox(height: 8),

        if (_buttonType != 'icon')
          _buildSwitchControl(
            '顯示圖示',
            _hasIcon,
            (value) => setState(() => _hasIcon = value),
          ),
      ],
    );
  }

  // Button 類型選擇器
  Widget _buildButtonTypeControl() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Button 類型：',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SegmentedButton<String>(
          segments: const [
            ButtonSegment(value: 'elevated', label: Text('Elevated')),
            ButtonSegment(value: 'text', label: Text('Text')),
            ButtonSegment(value: 'outlined', label: Text('Outlined')),
            ButtonSegment(value: 'icon', label: Text('Icon')),
          ],
          selected: {_buttonType},
          onSelectionChanged: (Set<String> newSelection) {
            setState(() => _buttonType = newSelection.first);
          },
        ),
      ],
    );
  }

  // 顏色選擇器
  Widget _buildColorControl() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '顏色：',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SegmentedButton<String>(
          segments: const [
            ButtonSegment(value: 'primary', label: Text('Primary')),
            ButtonSegment(value: 'error', label: Text('Error')),
            ButtonSegment(value: 'success', label: Text('Success')),
          ],
          selected: {_colorOption},
          onSelectionChanged: (Set<String> newSelection) {
            setState(() => _colorOption = newSelection.first);
          },
        ),
      ],
    );
  }

  // 形狀選擇器
  Widget _buildShapeControl() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '形狀：',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SegmentedButton<String>(
          segments: const [
            ButtonSegment(value: 'rectangular', label: Text('方形')),
            ButtonSegment(value: 'rounded', label: Text('圓角')),
            ButtonSegment(value: 'pill', label: Text('膠囊')),
          ],
          selected: {_shape},
          onSelectionChanged: (Set<String> newSelection) {
            setState(() => _shape = newSelection.first);
          },
        ),
      ],
    );
  }

  // 滑桿控制器（可重用）
  Widget _buildSliderControl(
    String label,
    double value,
    double min,
    double max,
    ValueChanged<double> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ${value.toStringAsFixed(0)}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          onChanged: onChanged,
        ),
      ],
    );
  }

  // Switch 控制器（可重用）
  Widget _buildSwitchControl(
    String label,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  // 預覽區（顯示實際的 Button）
  Widget _buildPreviewSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Button 預覽xxxxxx',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Center(
            child: _buildPreviewButton(),
          ),
        ],
      ),
    );
  }

  // 建立預覽的 Button
  Widget _buildPreviewButton() {
    // 取得顏色
    final color = _getButtonColor();

    // 取得形狀
    final shape = _getButtonShape();

    // 取得按鈕樣式
    final buttonStyle = ButtonStyle(
      backgroundColor: _buttonType == 'elevated' || _buttonType == 'outlined'
          ? WidgetStateProperty.all(
              _buttonType == 'elevated' ? color : Colors.transparent)
          : null,
      foregroundColor: WidgetStateProperty.all(
        _buttonType == 'elevated' ? Colors.white : color,
      ),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(horizontal: _padding, vertical: _padding / 2),
      ),
      minimumSize: WidgetStateProperty.all(Size.fromHeight(_height)),
      shape: WidgetStateProperty.all(shape),
      elevation: _buttonType == 'elevated'
          ? WidgetStateProperty.all(_elevation)
          : null,
      side: _buttonType == 'outlined'
          ? WidgetStateProperty.all(BorderSide(color: color, width: 2))
          : null,
    );

    // 按鈕文字/圖示
    final child = _buttonType == 'icon'
        ? Icon(Icons.favorite, size: _fontSize + 8, color: color)
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_hasIcon) ...[
                Icon(Icons.check, size: _fontSize),
                const SizedBox(width: 8),
              ],
              Text(
                'Button 範例',
                style: TextStyle(fontSize: _fontSize),
              ),
            ],
          );

    // 回調函數
    final onPressed = _isEnabled ? () {} : null;

    // 根據類型建立按鈕
    switch (_buttonType) {
      case 'elevated':
        return ElevatedButton(
          style: buttonStyle,
          onPressed: onPressed,
          child: child,
        );
      case 'text':
        return TextButton(
          style: buttonStyle,
          onPressed: onPressed,
          child: child,
        );
      case 'outlined':
        return OutlinedButton(
          style: buttonStyle,
          onPressed: onPressed,
          child: child,
        );
      case 'icon':
        return IconButton(
          iconSize: _fontSize + 8,
          color: color,
          onPressed: onPressed,
          icon: child,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  // 取得按鈕顏色
  Color _getButtonColor() {
    switch (_colorOption) {
      case 'primary':
        return Colors.blue;
      case 'error':
        return Colors.red;
      case 'success':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  // 取得按鈕形狀
  OutlinedBorder _getButtonShape() {
    switch (_shape) {
      case 'rectangular':
        return const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        );
      case 'rounded':
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        );
      case 'pill':
        return const StadiumBorder();
      default:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        );
    }
  }

  // 程式碼範例區（顯示對應的程式碼）
  Widget _buildCodeSection() {
    final codeExample = _generateCodeExample();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade50,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '程式碼範例',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SelectableText(
            codeExample,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // 產生程式碼範例文字
  String _generateCodeExample() {
    final buttonName = _getButtonTypeName();
    final colorName = _getColorName();
    final shapeName = _getShapeName();

    return '''$buttonName(
  style: ButtonStyle(
    ${_buttonType == 'elevated' ? 'backgroundColor: WidgetStateProperty.all($colorName),' : ''}
    foregroundColor: WidgetStateProperty.all(${_buttonType == 'elevated' ? 'Colors.white' : colorName}),
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(horizontal: ${_padding.toStringAsFixed(0)}, vertical: ${(_padding / 2).toStringAsFixed(0)}),
    ),
    minimumSize: WidgetStateProperty.all(Size.fromHeight(${_height.toStringAsFixed(0)})),
    shape: WidgetStateProperty.all($shapeName),${_buttonType == 'elevated' ? '\n    elevation: WidgetStateProperty.all(${_elevation.toStringAsFixed(0)}),' : ''}${_buttonType == 'outlined' ? '\n    side: WidgetStateProperty.all(BorderSide(color: $colorName, width: 2)),' : ''}
  ),
  onPressed: ${_isEnabled ? '() {}' : 'null'},
  child: ${_buttonType == 'icon' ? 'Icon(Icons.favorite, size: ${(_fontSize + 8).toStringAsFixed(0)})' : 'Text(\'Button 範例\', style: TextStyle(fontSize: ${_fontSize.toStringAsFixed(0)}))'},
)''';
  }

  String _getButtonTypeName() {
    switch (_buttonType) {
      case 'elevated':
        return 'ElevatedButton';
      case 'text':
        return 'TextButton';
      case 'outlined':
        return 'OutlinedButton';
      case 'icon':
        return 'IconButton';
      default:
        return 'ElevatedButton';
    }
  }

  String _getColorName() {
    switch (_colorOption) {
      case 'primary':
        return 'Colors.blue';
      case 'error':
        return 'Colors.red';
      case 'success':
        return 'Colors.green';
      default:
        return 'Colors.blue';
    }
  }

  String _getShapeName() {
    switch (_shape) {
      case 'rectangular':
        return 'RoundedRectangleBorder(borderRadius: BorderRadius.zero)';
      case 'rounded':
        return 'RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))';
      case 'pill':
        return 'StadiumBorder()';
      default:
        return 'RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))';
    }
  }
}
