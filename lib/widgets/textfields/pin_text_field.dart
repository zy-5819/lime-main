import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lime/util/log_util.dart';

class PinTextField extends StatefulWidget {
  const PinTextField({
    super.key,
    required this.controller,
    this.pinController,
    this.textInputAction,
    this.sendVerification,
    this.onChanged,
    this.error = false,
  });

  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final VoidCallback? sendVerification;
  final bool error;
  final void Function(String)? onChanged;
  final PinFieldController? pinController;

  @override
  State<PinTextField> createState() => _PinTextFieldState();
}

class _PinTextFieldState extends State<PinTextField> {
  ///记录发送验证码之后的剩余时间，单位为s
  final _remaining = ValueNotifier<int>(0);
  late PinFieldController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.pinController ?? PinFieldController();
    _remaining.value = _controller.remainingSeconds;
    _controller.addListener(_updateSeconds);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateSeconds);
    if (widget.pinController == null) {
      _controller.dispose();
    }
    _remaining.dispose();
    super.dispose();
  }

  void _updateSeconds() {
    _remaining.value = _controller.remainingSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ],
      textInputAction: widget.textInputAction,
      textAlignVertical: TextAlignVertical.center,
      onChanged: (v) {
        widget.controller.text = v;
        widget.onChanged?.call(v);
      },
      decoration: InputDecoration(
        errorText: widget.error ? '' : null,
        errorStyle: const TextStyle(height: 0),
        contentPadding: EdgeInsets.all(16.r),
        isCollapsed: true,
        hintText: '请输入验证码',
        suffixIcon: UnconstrainedBox(
          child: SizedBox(
            width: 100.w,
            child: ValueListenableBuilder(
              valueListenable: _remaining,
              builder: (context, int value, child) {
                if (value > 0) {
                  return TextButton(
                    onPressed: null,
                    child: Text('剩余${value}s', textAlign: TextAlign.center),
                  );
                }
                return TextButton(
                  onPressed: sendVerification,
                  child: const Text('发送验证码', textAlign: TextAlign.center),
                );
              },
            ),
          ),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
    );
  }

  void sendVerification() {
    try {
      widget.sendVerification?.call();
      _controller.startTimer();
    } catch (e) {
      Log.e('Unexpected error occurred when sending verification code: $e.');
      _controller.resetTimer();
    }
  }
}

class PinFieldController extends ChangeNotifier {
  int _remainingSeconds = 0;
  int get remainingSeconds => _remainingSeconds;
  set remainingSeconds(int newValue) {
    if (_remainingSeconds == newValue) {
      return;
    }
    _remainingSeconds = newValue;
    notifyListeners();
  }

  Timer? _timer;

  void startTimer() {
    if (_timer != null) {
      return;
    }
    remainingSeconds = 59;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingSeconds--;
      if (remainingSeconds <= 0) {
        resetTimer();
      }
    });
  }

  void resetTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
      remainingSeconds = 0;
    }
  }

  @override
  dispose() {
    resetTimer();
    super.dispose();
  }
}
