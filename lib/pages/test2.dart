import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

import 'package:lime/main.dart';

class CanvasCustomText extends StatefulWidget {
  const CanvasCustomText({super.key});

  @override
  State<CanvasCustomText> createState() => _CanvasCustomTextState();
}

class _CanvasCustomTextState extends State<CanvasCustomText>
    with TickerProviderStateMixin {
  Timer? _timer;
  List _sounds = [];
  @override
  void initState() {
    super.initState();

    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer.periodic(Duration(milliseconds: 400), (timer) {
      double num = (0.6.sw) / 8;
      Random _random = new Random(DateTime.now().microsecondsSinceEpoch);
      if (_sounds.length > num) {
        _sounds.removeAt(0);
      }
      _sounds.add({'size': (_random.nextDouble() * 10) * 4});
      setState(() {});
    });
    ;
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      child: Container(
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    offset: Offset(1, 1.0), //阴影xy轴偏移量
                    blurRadius: 2, //阴影模糊程度
                    spreadRadius: 0.5 //阴影扩散程度
                    )
              ],
              borderRadius: BorderRadius.all(Radius.circular(30)),
              border: Border.all(color: Colors.grey.withAlpha(122))),
          child: CustomPaint(
            painter: CustomSoundSizeAnim(soundList: _sounds),
          )),
    );
  }
}

class CustomSoundSizeAnim extends CustomPainter {
  List? soundList;
  CustomSoundSizeAnim({this.soundList});
  Paint? _paint;
  @override
  void paint(Canvas canvas, Size size) {
    _paint = Paint()..color = Colors.orange;
    drawRect(canvas, size);
  }

  drawRect(Canvas canvas, Size size) {
    double count = (0.6.sw / 8);
    soundList = [...soundList!.reversed];
    for (int i = 0; i < count; i++) {
      canvas.drawRRect(
          RRect.fromRectXY(
              Rect.fromCenter(center: Offset(i * 8, 100), width: 4, height: 4),
              8,
              8),
          _paint!);
    }
    for (int i = 0; i < soundList!.length / 2; i++) {
      canvas.drawRRect(
          RRect.fromRectXY(
              Rect.fromCenter(
                  center: Offset(size.width / 2 + i * 8, size.height / 2),
                  width: 4,
                  height: soundList![i]['size']),
              8,
              8),
          _paint!);
      canvas.drawRRect(
          RRect.fromRectXY(
              Rect.fromCenter(
                  center: Offset(size.width / 2 - i * 8, size.height / 2),
                  width: 4,
                  height: soundList![i]['size']),
              8,
              8),
          _paint!);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
