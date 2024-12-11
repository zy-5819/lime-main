import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lime/extensions/datetime_extension.dart';
part 'src/notification_item.dart';

class MessageSystemNotificationsPage extends StatefulWidget {
  ///显示系统通知的页面
  const MessageSystemNotificationsPage({super.key});

  ///从指定的[BuildContext]提取参数初始化页面
  factory MessageSystemNotificationsPage.route(BuildContext context) =>
      const MessageSystemNotificationsPage();

  @override
  State<MessageSystemNotificationsPage> createState() =>
      _MessageSystemNotificationsPageState();
}

class _MessageSystemNotificationsPageState
    extends State<MessageSystemNotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('系统通知'),
        actions: [TextButton(onPressed: () {}, child: const Text('清空'))],
      ),
      body: SafeArea(
          child: ListView(
        children: List.generate(3, (index) => _NotificationItem(onTap: () {})),
      )),
    );
  }
}
