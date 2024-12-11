
import 'package:flutter/material.dart';
import 'package:lime/widgets/loading_button/loading_button.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    super.key,
    this.onPressed,
    this.child,
    this.margin = const EdgeInsets.symmetric(horizontal: 8),
    this.elevation,
    this.tight = false,
    this.style,
    this.allowLoad = false,
    this.duration = Duration.zero,
    this.showDone = false,
  });

  final Widget? child;
  final Future<void> Function()? onPressed;
  final EdgeInsetsGeometry margin;
  final double? elevation;
  final bool tight;
  final ButtonStyle? style;
  final bool allowLoad;
  final Duration duration;
  final bool showDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: tight ? null : double.infinity,
      margin: margin,
      child: LoadingButton.elevated(
        duration: duration,
        allowLoad: allowLoad,
        showDone: showDone,
        style: style ??
            ButtonStyle(
              elevation: WidgetStateProperty.all(elevation),
            ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
