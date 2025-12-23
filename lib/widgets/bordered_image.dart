import 'package:flutter/material.dart';

class BorderedImage extends StatelessWidget {
  const BorderedImage({
    super.key,
    required this.image,
    this.size = 80,
    this.borderWidth = 2,
    this.borderColor = const Color(0xFFB39DDB), // 淡紫
    this.borderRadius = 12,
    this.fit = BoxFit.cover,
    this.backgroundColor = Colors.white,
  });

  /// 你可以傳 AssetImage / NetworkImage / MemoryImage...
  final ImageProvider image;

  final double size;
  final double borderWidth;
  final Color borderColor;
  final double borderRadius;
  final BoxFit fit;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.hardEdge, // 讓 child 也被圓角裁切
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: Image(
        image: image,
        fit: fit,
      ),
    );
  }
}