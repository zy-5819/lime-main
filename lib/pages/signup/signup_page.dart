import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
part 'src/signup_provider.dart';
part 'src/item_widget.dart';
part 'src/vertify_code.dart';
part 'src/register_button.dart';
part 'src/the_agreement.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  /// 从指定的[BuildContext]加载路由参数并初始化页面。
  factory SignUpPage.route(BuildContext context) => const SignUpPage();

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController _userName;
  late TextEditingController _displayName;
  late TextEditingController _pass;
  late TextEditingController _pass2;
  late TextEditingController _phone;
  late TextEditingController _vCode;
  late FocusNode displayNameFocusNode;
  late FocusNode passFocusNode;
  late FocusNode pass2FocusNode;
  late FocusNode phoneFocusNode;
  late FocusNode vCodeFocusNode;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    displayNameFocusNode = FocusNode();
    passFocusNode = FocusNode();
    pass2FocusNode = FocusNode();
    phoneFocusNode = FocusNode();
    vCodeFocusNode = FocusNode();
    _userName = TextEditingController();
    _displayName = TextEditingController();
    _pass = TextEditingController();
    _pass2 = TextEditingController();
    _phone = TextEditingController();
    _vCode = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    displayNameFocusNode.dispose();
    passFocusNode.dispose();
    pass2FocusNode.dispose();
    phoneFocusNode.dispose();
    vCodeFocusNode.dispose();
    _userName.dispose();
    _displayName.dispose();
    _pass.dispose();
    _pass2.dispose();
    _phone.dispose();
    _vCode.dispose();
  }

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  void loading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  // Future<void> _checkUserName(Account account, WidgetRef ref) async {
  //   final r = await account.checkUserNameAvailability(_userName.text);
  //   ref.read(_usernameErrorProvider.notifier).update((state) => r);
  // }

  // Future<void> _checkPhoneNumber(Account account, WidgetRef ref) async {
  //   final msg = await account.checkPhoneNumberAvailability(_phone.text);
  //   ref.read(_phoneErrorProvider.notifier).update((state) => msg);
  // }

  // Future<void> _getVCode(AuthService auth, WidgetRef ref) async {
  //   final msg = await auth.sendVerificationCode(
  //       _phone.text, ProtoCodeUsage.CODE_USAGE_REGISTRATION);
  //   if (msg != null) {
  //     ref.read(_phoneErrorProvider.notifier).update((state) => msg);
  //     return;
  //   }

  //   int seconds = 60;
  //   Timer.periodic(const Duration(seconds: 1), (timer) {
  //     seconds--;
  //     ref
  //         .read(_signupIsAvailableGetVCodeProvider.notifier)
  //         .update((state) => false);
  //     ref
  //         .read(_signupVerifyStrProvider.notifier)
  //         .update((state) => '剩余${seconds}s');
  //     if (seconds == 0) {
  //       ref.read(_signupVerifyStrProvider.notifier).update((state) => "重新获取");
  //       ref
  //           .read(_signupIsAvailableGetVCodeProvider.notifier)
  //           .update((state) => true);
  //       seconds = 60;
  //       timer.cancel();
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("注册"),
        centerTitle: true,
        elevation: 0.3,
      ),
      body: SafeArea(
        child: HookConsumer(
          builder: (context, ref, child) {
            // final account = ref.watch(_accountProvider);
            // final auth = ref.watch(_authProvider);
            final usernameError = ref.watch(_usernameErrorProvider);
            final phoneError = ref.watch(_phoneErrorProvider);
            final verifyStr = ref.watch(_signupVerifyStrProvider);
            final availableVCode =
                ref.watch(_signupIsAvailableGetVCodeProvider);
            final sessionId = ref.watch(signupSessionIdProvider);
            final background = Theme.of(context).colorScheme.surface;

            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //用户名
                    _ItemWidget(
                        background: background,
                        controller: _userName,
                        onChanged: ((value) {}),
                        validator: ((value) => usernameError),
                        hintText: '用户名',
                        suffixText: "由数字、字母和下划线组成",
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp("[A-Z,a-z,0-9,_]"))
                        ],
                        icon: FaIcon(
                          FontAwesomeIcons.person,
                          size: 24.sp,
                        )),
                    SizedBox(height: 2.r),
                    //昵称
                    _ItemWidget(
                      background: background,
                      controller: _displayName,
                      onEditingComplete: (() {
                        ref
                            .read(_signupUserNameProvider.notifier)
                            .update((state) => _displayName.text);
                        passFocusNode.requestFocus();
                      }),
                      hintText: '昵称',
                      icon: FaIcon(
                        FontAwesomeIcons.solidUser,
                        size: 18.sp,
                      ),
                    ),
                    SizedBox(height: 2.r),
                    //设置密码
                    _ItemWidget(
                      controller: _pass,
                      background: background,
                      hintText: '设置密码',
                      suffixText: "密码长度不低于8位",
                      obscureText: true,
                      focusNode: passFocusNode,
                      onChanged: ((value) => ref
                          .read(_signupPwdProvider.notifier)
                          .update((state) => value)),
                      validator: (v) {
                        if (v!.isEmpty || v.length < 8) {
                          return "密码长度不低于8位";
                        }
                        return null;
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.lock,
                        size: 18.sp,
                      ),
                    ),
                    SizedBox(height: 2.r),
                    //确认密码
                    _ItemWidget(
                      controller: _pass2,
                      background: background,
                      hintText: '确认密码',
                      obscureText: true,
                      focusNode: pass2FocusNode,
                      onChanged: ((value) => ref
                          .read(_signupPwd2Provider.notifier)
                          .update((state) => value)),
                      validator: (v) {
                        if (v!.isEmpty || v != _pass.text) {
                          return "两次密码输入不一致";
                        }
                        return null;
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.lock,
                        size: 18.sp,
                      ),
                    ),
                    SizedBox(height: 12.r),
                    //手机号码
                    _ItemWidget(
                      controller: _phone,
                      background: background,
                      focusNode: phoneFocusNode,
                      hintText: '手机号码',
                      icon: FaIcon(
                        FontAwesomeIcons.phone,
                        size: 18.sp,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(11),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onChanged: (value) {},
                      validator: (value) => phoneError,
                      errorText: phoneError,
                    ),
                    SizedBox(height: 2.r),
                    // 验证码
                    _VertifyCode(
                      background: background,
                      focusNode: vCodeFocusNode,
                      onPressed: phoneError == null && availableVCode
                          ? () async {}
                          : null,
                      controller: _vCode,
                      verifyStr: verifyStr,
                    ),
                    SizedBox(height: 12.h),
                    _RegisterButton(
                      formKey: _formKey,
                      // account: account,
                      userName: _userName.text,
                      displayName: _displayName.text,
                      password: _pass.text,
                      sessionId: sessionId,
                      vCode: _vCode.text,
                    ),
                    _TheAgreement(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
