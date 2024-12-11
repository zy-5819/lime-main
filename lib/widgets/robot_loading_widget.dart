import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RobotLoadingWidget extends StatelessWidget {
  const RobotLoadingWidget({super.key, this.size});
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        LoadingAnimationWidget.twoRotatingArc(
          color: Theme.of(context).colorScheme.primary,
          size: size ?? 40.sp,
        ),
      ],
    );
  }
}
