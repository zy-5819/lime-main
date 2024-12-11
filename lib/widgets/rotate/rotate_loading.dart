import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lime/constant/colors.dart';

class RotateLoading extends StatefulWidget {
  static const String routeName = 'rotateLoading';
  const RotateLoading({Key? key}) : super(key: key);

  @override
  State<RotateLoading> createState() => _RotateLoadingState();
}

class _RotateLoadingState extends State<RotateLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: const Size(100, 100),
        painter: RotateLoadingPainter(_ctrl),
      ),
    );
  }
}

class RotateLoadingPainter extends CustomPainter {
  RotateLoadingPainter(this.animation, {this.itemWidth = 33})
      : super(repaint: animation);

  final Animatable<double> rotateTween = Tween<double>(begin: pi, end: -pi)
      .chain(CurveTween(curve: Curves.easeIn));

  final double itemWidth;
  final Animation<double> animation;
  final Paint _paint = Paint();
  final double span = 16;
  final List<Color> colors = const [
    kThemeBlue,
    Color(0xff5c6bc0),
    Color(0xff5c6bc0),
    Colors.blue,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(animation.value * 2 * pi);
    final double len = itemWidth / 2 + span / 2;

    Offset centerA = Offset(-len, -len);
    drawItem(canvas, centerA, colors[0]);

    Offset centerB = Offset(len, len);
    drawItem(canvas, centerB, colors[1]);

    Offset centerC = Offset(len, -len);
    drawItem(canvas, centerC, colors[2]);

    Offset centerD = Offset(-len, len);
    drawItem(canvas, centerD, colors[3]);
  }

  void drawItem(Canvas canvas, Offset center, Color color) {
    Rect rect =
        Rect.fromCenter(center: center, width: itemWidth, height: itemWidth);

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotateTween.evaluate(animation));
    canvas.translate(-center.dx, -center.dy);

    canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(5)),
        _paint..color = color);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant RotateLoadingPainter oldDelegate) =>
      oldDelegate.itemWidth != itemWidth;
}
