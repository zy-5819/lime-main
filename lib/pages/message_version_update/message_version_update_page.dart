import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lime/widgets/elevated_button_widget.dart';

class MessageVersionUpdatePage extends StatefulWidget {
  ///通知应用有新版本的消息页面
  const MessageVersionUpdatePage({super.key});

  ///从指定的[BuildContext]提取参数初始化页面
  factory MessageVersionUpdatePage.route(BuildContext context) =>
      const MessageVersionUpdatePage();

  @override
  State<MessageVersionUpdatePage> createState() =>
      _MessageVersionUpdatePageState();
}

class _MessageVersionUpdatePageState extends State<MessageVersionUpdatePage> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: cs.onPrimary, borderRadius: BorderRadius.circular(12.r)),
            margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            padding: EdgeInsets.only(bottom: 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.r),
                      margin: EdgeInsets.all(24.r),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: cs.primary),
                      child: Text(
                        '2.0',
                        style: TextStyle(color: cs.onPrimary),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'V 2.0',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '56.7MB',
                          style: TextStyle(
                              color: cs.onSurfaceVariant.withOpacity(0.3)),
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.h),
                  child: RichText(
                    text: TextSpan(
                      text: '''V2.0包括针对消息中心，历史消杀记录等功能的开放及其他功能和错误修复。
                    \n\n某些功能并非所有用户可以使用，如需了解APP软件更新的安全性内容，请访问网站:''',
                      style: TextStyle(color: cs.onSurface),
                      children: [
                        TextSpan(
                            text: 'https://www.tongji.cq.cn',
                            style: TextStyle(color: cs.primary))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButtonWidget(
            onPressed: () async {},
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            child: const Text('下载并安装'),
          )
        ],
      ),
    );
  }
}
