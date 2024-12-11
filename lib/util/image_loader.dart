import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ImageLoader {
  ///通过ImageProvider读取Image
  static Future<ui.Image> loadImageByProvider(
    ImageProvider provider, {
    ImageConfiguration config = ImageConfiguration.empty,
  }) async {
    Completer<ui.Image> completer = Completer<ui.Image>(); //完成的回调
    ImageStream stream = provider.resolve(config); //获取图片流
    void listener(ImageInfo frame, bool sync) {
      //监听
      final ui.Image image = frame.image;
      completer.complete(image); //完成
      stream.removeListener(ImageStreamListener(listener)); //移除监听
    }

    stream.addListener(ImageStreamListener(listener)); //添加监听
    return completer.future; //返回
  }

  ///通过[Uint8List]获取图片
  static Future<ui.Image> loadImageByUint8List(Uint8List list) async {
    ui.Codec codec = await ui.instantiateImageCodec(list);
    ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image;
  }

  static Future<ui.Image> loadImageByList(List<int> data) =>
      loadImageByUint8List(Uint8List.fromList(data));

  ///对图片重定义宽高尺寸[dstWidth],[dstHeight]
  static Future<ui.Image> _resize(ui.Image image, int dstWidth, int dstHeight) {
    var recorder = ui.PictureRecorder(); //使用PictureRecorder对图片进行录制
    Paint paint = Paint();
    Canvas canvas = Canvas(recorder);
    double srcWidth = image.width.toDouble();
    double srcHeight = image.height.toDouble();
    canvas.drawImageRect(
        image, //使用drawImageRect对图片进行定尺寸填充
        Rect.fromLTWH(0, 0, srcWidth, srcHeight),
        Rect.fromLTWH(0, 0, dstWidth.toDouble(), dstHeight.toDouble()),
        paint);
    return recorder.endRecording().toImage(dstWidth, dstHeight); //返回图片
  }

  ///缩放加载[provider],缩放比例[scale]
  static Future<ui.Image> scaleLoad(
      ImageProvider provider, double scale) async {
    var img = await loadImageByProvider(provider);
    return _resize(
        img, (img.width * scale).toInt(), (img.height * scale).toInt());
  }

  ///缩放加载[provider],缩放比例[transform]
  static Future<ui.Image> resizeLoad(
      ImageProvider provider, int dstWidth, int dstHeight) async {
    var img = await loadImageByProvider(provider);
    return _resize(img, dstWidth, dstHeight);
  }

  ///保存一个Image
  static Future<File> saveImage(ui.Image image, String path,
      {ui.ImageByteFormat format = ui.ImageByteFormat.png}) async {
    var file = File(path);
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    ByteData? byteData = await image.toByteData(format: format);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    return file.writeAsBytes(pngBytes);
  }

  /// 检查缓存是否过期
  static Future<bool> isCacheDeath(File fileDeath) async {
    if (!await fileDeath.exists()) {
      return true;
    }
    var death = await fileDeath.readAsString();
    debugPrint(
        "$death ==== ${DateTime.now().millisecondsSinceEpoch}--${int.parse(death) > DateTime.now().millisecondsSinceEpoch}");
    return int.parse(death) < DateTime.now().millisecondsSinceEpoch;
  }
}
