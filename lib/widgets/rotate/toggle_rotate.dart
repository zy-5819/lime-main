import 'dart:math';

import 'package:flutter/material.dart';

class ToggleRotate extends StatefulWidget {
  const ToggleRotate({
    Key? key,
    required this.child,
    this.onTap,
    this.onEnd,
    this.beginAngle = 0,
    this.endAngle = 90,
    this.closewise = true,
    this.durationMs = 200,
    this.curve = Curves.fastOutSlowIn,
    this.rotated = false,
  }) : super(key: key);

  final Widget child;
  final ValueChanged<bool>? onEnd;
  final VoidCallback? onTap;
  final double beginAngle;
  final double endAngle;
  final int durationMs;
  final bool closewise;
  final Curve curve;
  final bool rotated;

  @override
  State<ToggleRotate> createState() => _ToggleRotateState();
}

class _ToggleRotateState extends State<ToggleRotate>
    with SingleTickerProviderStateMixin {
  late bool _rotated;
  late bool _rev;
  late AnimationController _controller;
  late Animation<double> _rotateAnim;

  @override
  void initState() {
    super.initState();
    _rotated = widget.rotated;
    _rev = _rotated;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: widget.durationMs,
      ),
    );
    _initTweenAnim(_rotated);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initTweenAnim(bool rev) {
    if (rev) {
      _rotateAnim = Tween<double>(
        begin: widget.endAngle / 180 * pi,
        end: widget.beginAngle / 180 * pi,
      ).chain(CurveTween(curve: widget.curve)).animate(_controller);
    } else {
      _rotateAnim = Tween<double>(
        begin: widget.beginAngle / 180 * pi,
        end: widget.endAngle / 180 * pi,
      ).chain(CurveTween(curve: widget.curve)).animate(_controller);
    }
  }

  double get rad => widget.closewise ? _rotateAnim.value : -_rotateAnim.value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _toggleRotate,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.rotationZ(rad),
            alignment: Alignment.center,
            child: widget.child,
          );
        },
      ),
    );
  }

  Future<void> _toggleRotate() async {
    widget.onTap?.call();
    if (_rev ? !_rotated : _rotated) {
      await _controller.reverse();
    } else {
      await _controller.forward();
    }
    _rotated = !_rotated;
    widget.onEnd?.call(_rotated);
  }
}
