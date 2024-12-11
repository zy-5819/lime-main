import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ButtonStyle kButtonStyle = ButtonStyle(
  shape: WidgetStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  minimumSize: WidgetStateProperty.all(const Size(0, 40)),
);

ButtonStyle kCircleTextButton = ButtonStyle(
    shape: WidgetStateProperty.all(
      const CircleBorder(side: BorderSide.none),
    ),
    padding: WidgetStateProperty.all(EdgeInsets.zero),
    maximumSize: WidgetStateProperty.all(Size(48.h, 48.h)));

ButtonStyle kMapSizeButton = ButtonStyle(
    minimumSize: WidgetStateProperty.all(Size(40.w, 30.h)),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    padding: WidgetStateProperty.all(EdgeInsets.zero));

ButtonStyle kPoseSizeButton = ButtonStyle(
    minimumSize: WidgetStateProperty.all(Size(40.w, 30.h)),
    padding: WidgetStateProperty.all(EdgeInsets.zero));

///5s
const Duration kTimeout = Duration(milliseconds: 5000);
