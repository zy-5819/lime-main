import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lime/nav/args.dart';
import 'package:lime/nav/routes.dart';
import 'package:lime/widgets/elevated_button_widget.dart';
import 'package:lime/widgets/textfields/pin_text_field.dart';

class UserPhoneNumberVerifyPage extends ConsumerStatefulWidget {
  ///需要验证的手机号码
  final VerifyPhoneNumberArguments args;

  ///使用指定手机号码创建的验证手机号页面
  const UserPhoneNumberVerifyPage(this.args, {super.key});

  ///从指定的[BuildContext]中提取参数初始化页面
  factory UserPhoneNumberVerifyPage.route(BuildContext context) =>
      UserPhoneNumberVerifyPage(context.args<VerifyPhoneNumberArguments>());

  @override
  ConsumerState<UserPhoneNumberVerifyPage> createState() =>
      _UserPhoneNumberVerifyPageState();
}

class _UserPhoneNumberVerifyPageState
    extends ConsumerState<UserPhoneNumberVerifyPage> {
  final _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sessionId = ref.watch(_sessionIdProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('更换手机号码')),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '更换绑定的手机号',
              style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.only(top: 5.h, bottom: 24.h),
              child: Text(
                '短信验证码将发送至${widget.args.phoneNumber.replaceRange(3, 7, '****')}\n通过身份验证后即可换绑',
                style: TextStyle(
                    fontSize: 14.sp,
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
                textAlign: TextAlign.start,
              ),
            ),
            PinTextField(
              controller: _pinController,
              sendVerification: _sendVerificationCode,
            ),
            ElevatedButtonWidget(
              onPressed: () => _verifyPhoneNumber(sessionId),
              margin: EdgeInsets.symmetric(vertical: 30.h),
              child: const Text('下一步'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _sendVerificationCode() async {
    // try {
    //   final id = await ref.read(authServiceProvider).sendVerificationCode(
    //       widget.args.phoneNumber,
    //       widget.args.newPhone
    //           ? ProtoCodeUsage.CODE_USAGE_UPDATE_PHONE_NUMBER
    //           : ProtoCodeUsage.CODE_USAGE_VERIFY_PHONE_NUMBER);
    //   ref.read(_sessionIdProvider.notifier).update((state) => id);
    // } catch (e) {
    //   unawaited(Fluttertoast.showToast(msg: Em.exception(e)));
    // }
  }

  Future<void> _verifyPhoneNumber(String sessionId) async {
    // try {
    //   final nav = Navigator.of(context);
    //   if (widget.args.newPhone) {
    //     await ref
    //         .read(authServiceProvider)
    //         .updatePhoneNumber(sessionId, _pinController.text);

    //     ref.invalidate(userResponseProvider);
    //     nav.pop();
    //     unawaited(Fluttertoast.showToast(msg: '换绑成功'));
    //   } else {
    //     await ref
    //         .read(authServiceProvider)
    //         .verifyPhoneNumber(sessionId, _pinController.text);
    //     unawaited(nav.pushReplacementNamed(Routes.userPhoneNumberNew));
    //   }
    // } catch (e) {
    //   unawaited(Fluttertoast.showToast(msg: Em.exception(e)));
    // }
  }
}

final _sessionIdProvider = StateProvider.autoDispose<String>((ref) => '');
