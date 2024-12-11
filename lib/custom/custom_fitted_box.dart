import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lime/controllers/fitted_box_controller.dart';

class CustomFittedBox extends FittedBox {
  const CustomFittedBox({
    super.key,
    super.alignment,
    super.fit,
    super.clipBehavior,
    super.child,
    this.controller,
  });

  final FittedBoxController? controller;

  @override
  void updateRenderObject(BuildContext context, RenderFittedBox renderObject) {
    super.updateRenderObject(context, renderObject);
    controller?.box.boxSize = renderObject.size;
    if (renderObject.child != null) {
      controller?.box.childSize = renderObject.child!.size;
      controller?.box.scaleX = renderObject.child!.size.width.toDouble() /
          renderObject.size.width.toDouble();
      controller?.box.scaleY = renderObject.child!.size.height.toDouble() /
          renderObject.size.height.toDouble();
    }
  }
}
