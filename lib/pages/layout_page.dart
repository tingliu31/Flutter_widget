import 'package:flutter/material.dart';
import '../widgets/bordered_image.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Layout Practice')),
      body: const RowWithImages() // 這裡換
    );
}

// Container
class ContainerWithImage extends StatelessWidget {
  const ContainerWithImage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow.withValues(alpha: 0.2),
      padding: EdgeInsets.all(16), //padding 內距
      child: const BorderedImage(
        image: AssetImage('assets/images/cats.jpg')
      ),
    );
  }
  
}

//Row
class RowWithImages extends StatelessWidget {
  const RowWithImages({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, //整體置左，預設
      //mainAxisAlignment: MainAxisAlignment.end, //整體置右
      //mainAxisAlignment: MainAxisAlignment.center, //整體置中
      //mainAxisAlignment: MainAxisAlignment.spaceBetween, //平均分配整體空間 → 空白只放在「元件之間」，左右不留
      //mainAxisAlignment: MainAxisAlignment.spaceAround, //元件左右都有空白，但「中間比較大」
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly, //每一段空白（含左右）都一樣大，最平均
      children: [
        Expanded(child: BorderedImage(image: AssetImage('assets/images/cats.jpg'))),
        Expanded(flex: 2, child: const BorderedImage(image: AssetImage('assets/images/cats.jpg'))),
        Expanded(child: const BorderedImage(image: AssetImage('assets/images/cats.jpg'))),
      ],
    );
  }

}

//Column
class ColumnWithImages extends StatelessWidget {
  const ColumnWithImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const BorderedImage(image: AssetImage('assets/images/cats.jpg')),
        const BorderedImage(image: AssetImage('assets/images/cats.jpg')),
        const BorderedImage(image: AssetImage('assets/images/cats.jpg')),
      ],
    );
  }

}