part of '../loading_button.dart';

class _Loading extends StatefulWidget {
  const _Loading({
    super.key,
    this.child,
    this.onPressed,
    this.style,
    this.frequentToast,
    this.duration = Duration.zero,
    this.done,
    this.doneColor,
    this.error,
    this.errorColor,
    this.loading,
    this.loadingColor,
    this.showDone = false,
    this.heroTag,
    this.stretch = false,
    required this.type,
    required this.allowLoad,
  });

  ///按下按钮后执行的回调
  final VoidFutureCallBack? onPressed;

  ///按钮内部内容
  final Widget? child;

  ///按钮样式
  final ButtonStyle? style;

  ///执行命令的延迟时间
  final Duration duration;

  ///重复操作按钮的提示语
  final String? frequentToast;

  ///预定样式的按钮
  final _ButtonType type;

  ///执行命令时的等待控件样式，优先级高于[loadingColor]
  final Widget? loading;

  ///执行命令时的等待控件颜色
  final Color? loadingColor;

  ///命令完成时的控件样式，优先级高于[doneColor]
  final Widget? done;

  ///命令完成时的控件颜色
  final Color? doneColor;

  ///命令出现错误时的控件样式，优先级高于[errorColor]
  final Widget? error;

  ///命令出现错误时的控件颜色
  final Color? errorColor;

  ///是否允许控件为加载模式，默认为[false]
  final bool allowLoad;

  ///是否允许控件在加载模式下出现完成提示，默认为[false]
  final bool showDone;

  ///当控件样式为[FloatingActionButton]时，此属性才做应用
  final String? heroTag;

  ///控件是否填满宽度，默认为[false]
  final bool stretch;

  @override
  State<_Loading> createState() => _LoadingState();
}

class _LoadingState extends State<_Loading> {
  late _ButtonState btnState;

  @override
  void initState() {
    btnState = _ButtonState.normal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.stretch ? double.infinity : null,
      child: _buildButton(),
    );
  }

  Widget _buildButton() {
    switch (widget.type) {
      case _ButtonType.text:
        return TextButton(
          onPressed: widget.onPressed == null ? null : _onPressed,
          style: widget.style,
          child: _buildChild()!,
        );
      case _ButtonType.elevated:
        return ElevatedButton(
          onPressed: widget.onPressed == null ? null : _onPressed,
          style: widget.style,
          child: _buildChild(),
        );
      case _ButtonType.material:
        return MaterialButton(
          onPressed: widget.onPressed == null ? null : _onPressed,
          child: _buildChild(),
        );
      case _ButtonType.outlined:
        return OutlinedButton(
          onPressed: widget.onPressed == null ? null : _onPressed,
          style: widget.style,
          child: _buildChild()!,
        );
      case _ButtonType.floatingAction:
        return FloatingActionButton(
          heroTag: widget.heroTag,
          onPressed: widget.onPressed == null ? null : _onPressed,
          child: _buildChild(),
        );
    }
  }

  Widget? _buildChild() {
    switch (btnState) {
      case _ButtonState.normal:
        return widget.child;
      case _ButtonState.loading:
        return widget.loading ??
            LoadingAnimationWidget.threeArchedCircle(
              color:
                  widget.loadingColor ?? Theme.of(context).colorScheme.primary,
              size: 24,
            );
      case _ButtonState.error:
        return widget.error ??
            Icon(
              Icons.error_outline,
              color: widget.errorColor ?? Theme.of(context).colorScheme.error,
              size: 28,
            );
      case _ButtonState.done:
        return widget.done ??
            Icon(
              Icons.check_circle_outline_outlined,
              color: widget.doneColor ?? Theme.of(context).colorScheme.primary,
              size: 28,
            );
    }
  }

  Future<void> _onPressed() async {
    if (widget.allowLoad) {
      try {
        if (btnState != _ButtonState.normal) {
          await Fluttertoast.showToast(msg: widget.frequentToast ?? '操作过于频繁');
          return;
        }
        setState(() {
          btnState = _ButtonState.loading;
        });
        await Future.delayed(widget.duration, () {});
        await widget.onPressed?.call();
        if (widget.showDone) {
          setState(() {
            btnState = _ButtonState.done;
          });
          await Future.delayed(_doneDuration, () {});
        }
        setState(() {
          btnState = _ButtonState.normal;
        });
      } catch (e) {
        setState(() {
          btnState = _ButtonState.error;
        });
        await Future.delayed(_errorDuration, () {});
        setState(() {
          btnState = _ButtonState.normal;
        });
        rethrow;
      }
    } else {
      await widget.onPressed?.call();
    }
  }
}
