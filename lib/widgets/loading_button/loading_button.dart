import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
part 'src/loading.dart';
part 'src/constants.dart';
part 'src/models.dart';

///防止命令重复执行的[Button]，可延迟执行命令，命令执行过程中可显示状态
class LoadingButton {
  LoadingButton._();

  ///防止命令重复执行的[ElevatedButton]
  static Widget elevated({
    Key? key,
    VoidFutureCallBack? onPressed,
    Widget? child,
    ButtonStyle? style,
    Duration? duration,
    String? frequentToast,
    bool allowLoad = true,
    Widget? done,
    Color? doneColor,
    Widget? error,
    Color? errorColor,
    Widget? loading,
    Color? loadingColor,
    bool showDone = false,
    bool stretch = false,
  }) {
    return _Loading(
      key: key,
      onPressed: onPressed,
      style: style,
      duration: duration ?? _loadingDuration,
      frequentToast: frequentToast,
      type: _ButtonType.elevated,
      allowLoad: allowLoad,
      done: done,
      doneColor: doneColor,
      error: error,
      errorColor: errorColor,
      loading: loading,
      loadingColor: loadingColor,
      showDone: showDone,
      stretch: stretch,
      child: child,
    );
  }

  static Widget text({
    Key? key,
    VoidFutureCallBack? onPressed,
    required Widget child,
    ButtonStyle? style,
    Duration? duration,
    String? frequentToast,
    bool allowLoad = true,
    Widget? done,
    Color? doneColor,
    Widget? error,
    Color? errorColor,
    Widget? loading,
    Color? loadingColor,
    bool showDone = false,
    bool stretch = false,
  }) {
    return _Loading(
      key: key,
      onPressed: onPressed,
      style: style,
      duration: duration ?? _loadingDuration,
      frequentToast: frequentToast,
      type: _ButtonType.text,
      allowLoad: allowLoad,
      done: done,
      doneColor: doneColor,
      error: error,
      errorColor: errorColor,
      loading: loading,
      loadingColor: loadingColor,
      showDone: showDone,
      stretch: stretch,
      child: child,
    );
  }

  static Widget outlined({
    Key? key,
    VoidFutureCallBack? onPressed,
    required Widget child,
    ButtonStyle? style,
    Duration? duration,
    String? frequentToast,
    bool allowLoad = true,
    Widget? done,
    Color? doneColor,
    Widget? error,
    Color? errorColor,
    Widget? loading,
    Color? loadingColor,
    bool showDone = false,
    bool stretch = false,
  }) {
    return _Loading(
      key: key,
      onPressed: onPressed,
      style: style,
      duration: duration ?? _loadingDuration,
      frequentToast: frequentToast,
      type: _ButtonType.outlined,
      allowLoad: allowLoad,
      done: done,
      doneColor: doneColor,
      error: error,
      errorColor: errorColor,
      loading: loading,
      loadingColor: loadingColor,
      showDone: showDone,
      stretch: stretch,
      child: child,
    );
  }

  static Widget material({
    Key? key,
    VoidFutureCallBack? onPressed,
    Widget? child,
    Duration? duration,
    String? frequentToast,
    bool allowLoad = true,
    Widget? done,
    Color? doneColor,
    Widget? error,
    Color? errorColor,
    Widget? loading,
    Color? loadingColor,
    bool showDone = false,
    bool stretch = false,
  }) {
    return _Loading(
      key: key,
      onPressed: onPressed,
      duration: duration ?? _loadingDuration,
      frequentToast: frequentToast,
      type: _ButtonType.material,
      allowLoad: allowLoad,
      done: done,
      doneColor: doneColor,
      error: error,
      errorColor: errorColor,
      loading: loading,
      loadingColor: loadingColor,
      showDone: showDone,
      stretch: stretch,
      child: child,
    );
  }

  static Widget floatingAction({
    Key? key,
    VoidFutureCallBack? onPressed,
    Widget? child,
    Duration? duration,
    String? frequentToast,
    bool allowLoad = true,
    Widget? done,
    Color? doneColor,
    Widget? error,
    Color? errorColor,
    Widget? loading,
    Color? loadingColor,
    bool showDone = false,
    bool stretch = false,
    String? heroTag,
  }) {
    return _Loading(
      key: key,
      onPressed: onPressed,
      duration: duration ?? _loadingDuration,
      frequentToast: frequentToast,
      type: _ButtonType.floatingAction,
      allowLoad: allowLoad,
      done: done,
      doneColor: doneColor,
      error: error,
      errorColor: errorColor,
      loading: loading,
      loadingColor: loadingColor,
      showDone: showDone,
      heroTag: heroTag,
      stretch: stretch,
      child: child,
    );
  }
}
