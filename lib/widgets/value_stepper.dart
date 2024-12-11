import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ValueStepper extends StatefulWidget {
  const ValueStepper({
    Key? key,
    required this.begin,
    required this.end,
    required this.step,
    required this.value,
    this.width,
    this.controller,
    this.onValueChanged,
    this.decimal = 0,
  }) : super(key: key);

  final double begin;
  final double end;
  final double step;
  final int decimal;
  final double value;
  final double? width;
  final StepperController? controller;
  final void Function(double)? onValueChanged;

  @override
  State<ValueStepper> createState() => _ValueStepperState();
}

class _ValueStepperState extends State<ValueStepper> {
  late ValueNotifier<double> _value;

  @override
  void initState() {
    super.initState();
    _value = ValueNotifier(widget.value);
    widget.controller?.text = widget.begin;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      width: widget.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ValueListenableBuilder(
              valueListenable: _value,
              builder: (context, double v, child) {
                return IconButton(
                  padding: EdgeInsets.zero,
                  style: ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: WidgetStateProperty.all(Size.zero),
                  ),
                  onPressed: v <= widget.begin
                      ? null
                      : () {
                          if (_value.value - widget.step / 2 >= widget.begin) {
                            _value.value -= widget.step;
                            widget.controller?.text = _value.value;
                            widget.onValueChanged?.call(_value.value);
                          }
                        },
                  icon: const Icon(Icons.keyboard_arrow_left_rounded),
                );
              }),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: ValueListenableBuilder(
                valueListenable: _value,
                builder: (context, value, child) {
                  return Text(_value.value.toStringAsFixed(widget.decimal));
                },
              )),
          ValueListenableBuilder(
              valueListenable: _value,
              builder: (context, double v, child) {
                return IconButton(
                  padding: EdgeInsets.zero,
                  style: ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: WidgetStateProperty.all(Size.zero),
                  ),
                  onPressed: v >= widget.end
                      ? null
                      : () {
                          if (_value.value + widget.step / 2 <= widget.end) {
                            _value.value += widget.step;
                            widget.controller?.text = _value.value;
                            widget.onValueChanged?.call(_value.value);
                          }
                        },
                  icon: const Icon(Icons.keyboard_arrow_right_rounded),
                );
              }),
        ],
      ),
    );
  }
}

class StepperController extends ValueNotifier<double> {
  StepperController({double? text}) : super(text ?? 0);

  double get text => value;

  set text(double newText) {
    value = newText;
  }
}
