import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lime/widgets/elevated_button_widget.dart';

class UserPhoneNumberNewPage extends ConsumerStatefulWidget {
  ///初始化当前用户关联新手机号码的页面
  const UserPhoneNumberNewPage({super.key});

  ///从指定的[BuildContext]中提取参数初始化页面
  factory UserPhoneNumberNewPage.route(BuildContext context) =>
      const UserPhoneNumberNewPage();

  @override
  ConsumerState<UserPhoneNumberNewPage> createState() =>
      _UserPhoneNumberNewPageState();
}

class _UserPhoneNumberNewPageState
    extends ConsumerState<UserPhoneNumberNewPage> {
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('更换手机号码'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '请输入新的手机号',
              style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.only(top: 5.h, bottom: 44.h),
              child: Text(
                '输入新的手机号，并进行身份验证',
                style: TextStyle(
                    fontSize: 14.sp,
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
                textAlign: TextAlign.start,
              ),
            ),
            IntlPhoneField(
              controller: _phoneController,
              initialCountryCode: 'CN',
              textAlignVertical: TextAlignVertical.center,
              disableLengthCheck: true,
              autofocus: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                isCollapsed: true,
                border: const OutlineInputBorder(),
              ),
            ),
            ElevatedButtonWidget(
              onPressed: _onPressed,
              margin: EdgeInsets.symmetric(vertical: 30.h),
              allowLoad: true,
              child: const Text('下一步'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _onPressed() async {
    // try {
    //   unawaited(Navigator.of(context).pushReplacementNamed(
    //       Routes.userPhoneNumberVerify,
    //       arguments: VerifyPhoneNumberArguments(_phoneController.text, true)));
    // } catch (e) {
    //   unawaited(Fluttertoast.showToast(msg: Em.exception(e)));
    // }
  }
}
