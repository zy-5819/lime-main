import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

enum ImageType { net, file, asset }

class ImageUtils {
  static Future<ui.Image> loadImage(String path, ImageType type) async {
    ImageStream stream;
    switch (type) {
      case ImageType.net:
        stream = NetworkImage(path).resolve(ImageConfiguration.empty);
        break;
      case ImageType.file:
        stream = FileImage(File(path)).resolve(ImageConfiguration.empty);
        break;
      case ImageType.asset:
        stream = ExactAssetImage(path).resolve(ImageConfiguration.empty);
        break;
    }
    Completer<ui.Image> completer = Completer<ui.Image>();
    void listener(ImageInfo frame, bool synchronousCall) {
      final ui.Image image = frame.image;
      completer.complete(image);
      stream.removeListener(ImageStreamListener(listener));
    }

    stream.addListener(ImageStreamListener(listener));
    return completer.future;
  }

  static Future<ui.Image?> getRenderedImg(CustomPainter? editCustomPainter,
      ui.Image? image, Size size, double scale) {
    if (editCustomPainter != null) {
      ui.PictureRecorder recorder = ui.PictureRecorder();
      Canvas canvas = Canvas(recorder);
      if (image != null) {
        canvas.drawImage(image, Offset.zero, Paint());
      }
      canvas.scale(1 / scale);

      editCustomPainter.paint(canvas, size);

      return recorder
          .endRecording()
          .toImage(size.width.floor(), size.height.floor());
    }
    return Future.value(null);
  }

  // static Future<ui.Image?> saveMapImage(
  //     ui.Image image, List<Line> lines, Matrix4 matrix) async {
  //   ui.PictureRecorder recorder = ui.PictureRecorder();
  //   Canvas canvas = Canvas(recorder);

  //   ui.Paint paint = ui.Paint();

  //   canvas.drawImage(image, Offset.zero, paint);
  //   for (var line in lines) {
  //     line.paint(canvas, Size(image.width.toDouble(), image.height.toDouble()),
  //         image.width.toDouble(), image.height.toDouble(), paint, matrix);
  //   }

  //   return recorder
  //       .endRecording()
  //       .toImage(image.width.floor(), image.height.floor());
  // }
}
