import 'package:flutter/material.dart';

class FittedBoxController extends ValueNotifier<FittedBoxModel> {
  FittedBoxController({FittedBoxModel? box})
      : super(box ??
            FittedBoxModel(
              scaleX: 1,
              scaleY: 1,
              boxSize: Size.zero,
              childSize: Size.zero,
            ));

  set box(FittedBoxModel value) {
    box = value;
  }

  FittedBoxModel get box => value;
}

class FittedBoxModel {
  double scaleX;
  double scaleY;
  Size boxSize;
  Size childSize;
  FittedBoxModel({
    required this.scaleX,
    required this.scaleY,
    required this.boxSize,
    required this.childSize,
  });
}
