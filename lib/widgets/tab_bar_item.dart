import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabBarItem extends StatelessWidget {
  ///[TabBar]显示样式
  const TabBarItem({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 48.h,
      child: Text(label),
    );
  }
}
