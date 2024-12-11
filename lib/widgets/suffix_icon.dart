import 'package:flutter/material.dart';

class SuffixIcon extends StatelessWidget {
  /// 当点击了清除按钮时需要执行的方法。
  final VoidCallback? onRemove;

  /// 查询条件后面的小图标
  const SuffixIcon({super.key, this.onRemove});

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).colorScheme.secondary;

    if (onRemove == null) {
      return Icon(Icons.keyboard_arrow_right_rounded, color: iconColor);
    }

    return InkWell(
      onTap: onRemove,
      child: Icon(Icons.clear, color: iconColor),
    );
  }
}
