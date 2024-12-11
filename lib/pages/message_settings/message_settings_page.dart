import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessageSettingsPage extends HookConsumerWidget {
  ///消息通知设置页面
  const MessageSettingsPage({super.key});

  ///从指定的[BuildContext]提取参数初始化页面
  factory MessageSettingsPage.route(BuildContext context) =>
      const MessageSettingsPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('消息设置'),
      ),
      body: ListView(
        physics: const RangeMaintainingScrollPhysics(),
        children: const [
          _MessageSettingsItem('异常消息设置'),
          _MessageSettingsItem('提醒消息设置'),
          _MessageSettingsItem('系统公告通知'),
          _MessageSettingsItem('消息提示音'),
          _MessageSettingsItem('震动'),
        ],
      ),
    );
  }
}

class _MessageSettingsItem extends StatefulWidget {
  const _MessageSettingsItem(this.title);
  final String title;

  @override
  State<_MessageSettingsItem> createState() => __MessageSettingsItemState();
}

class __MessageSettingsItemState extends State<_MessageSettingsItem> {
  final _switchIsOn = ValueNotifier(true);
  @override
  void dispose() {
    _switchIsOn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.title,
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
      ),
      trailing: ValueListenableBuilder(
        valueListenable: _switchIsOn,
        builder: (_, bool value, c) {
          return Switch.adaptive(
              activeColor: Theme.of(context).colorScheme.primary,
              value: value,
              onChanged: (v) {
                _switchIsOn.value = v;
              });
        },
      ),
    );
  }
}
