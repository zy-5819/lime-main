import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lime/app_icons.dart';
import 'package:lime/constant/strings.dart';
import 'package:lime/models/server_version.dart';
import 'package:lime/providers/top_level_providers.dart';
import 'package:lime/widgets/loading_button/loading_button.dart';
import 'package:lime/widgets/textfields/password_text_field.dart';
import 'package:lime/widgets/textfields/pin_text_field.dart';

part 'src/login_provider.dart';
part 'src/login_mode.dart';
part 'src/login_button.dart';
part 'src/register_button_widget.dart';
part 'src/the_agreement.dart';
part 'src/splash.dart';
part 'src/server_version_switch_button.dart';
part 'src/security_button.dart';

class LoginPage extends StatefulHookConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  /// 从指定的[BuildContext]加载路由参数并初始化页面。
  factory LoginPage.route(BuildContext context) => const LoginPage();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _nameController = TextEditingController();
  final _pwdController = TextEditingController();
  final _phoneController = TextEditingController();
  final _pinController = TextEditingController();
  final _pwdNode = FocusNode();
  final _pinTimerController = PinFieldController();

  @override
  void initState() {
    super.initState();
    // 在退出登录后删除本地的kToken和kExpiry。
    // ref.read(authServiceProvider).logout();
    // 不可以使用依赖channelProvider的provider
    // 不然会因为服务器地址不正确导致的页面异常显示问题。
    ref
        .read(sharedPreferencesProvider)
        .remove(SharedPreferenceKeys.kUserAccess);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _pwdController.dispose();
    _phoneController.dispose();
    _pinController.dispose();
    _pwdNode.dispose();
    _pinTimerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pwdMode = ref.watch(LoginProvider.passwordMode);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: ListView(
          physics: const RangeMaintainingScrollPhysics(),
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: _ServerVersionSwitchButton(),
            ),
            Container(
                width: 0.4.sw,
                height: 0.4.sw,
                margin: EdgeInsets.symmetric(vertical: 50.h),
                child: const FittedBox(
                  fit: BoxFit.contain,
                  child: Icon(
                    AppIcons.appIcon,
                  ), // 填充父组件
                )),
            AnimatedCrossFade(
                // firstChild: IntlPhoneField(
                //   onChanged: (v) => ref
                //       .read(LoginProvider.username.notifier)
                //       .update((state) => v.completeNumber),
                //   controller: _phoneController,
                //   showDropdownIcon: false,
                //   languageCode: 'zh',
                //   initialCountryCode: 'CN',
                //   showCountryFlag: false,
                //   flagsButtonPadding: EdgeInsets.symmetric(horizontal: 12.w),
                //   textAlignVertical: TextAlignVertical.center,
                //   disableLengthCheck: true,
                //   autofocus: true,
                //   decoration: InputDecoration(
                //     contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                //     isCollapsed: true,
                //     border: const OutlineInputBorder(),
                //   ),
                // ),
                firstChild: PasswordTextField(
                  obscureText: false,
                  onChanged: (v) => ref
                      .read(LoginProvider.username.notifier)
                      .update((s) => v.trim()),
                  controller: _phoneController,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11)
                  ],
                  hintText: '请输入手机号',
                ),
                secondChild: PasswordTextField(
                  controller: _nameController,
                  prefixIcon: const Icon(Icons.person),
                  obscureText: false,
                  hintText: '用户名',
                  onEditingComplete: () => _pwdNode.requestFocus(),
                  onChanged: (v) => ref
                      .read(LoginProvider.username.notifier)
                      .update((state) => v.trim()),
                ),
                crossFadeState: pwdMode
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300)),
            SizedBox(height: 10.h),
            AnimatedCrossFade(
                firstChild: PinTextField(
                  controller: _pinController,
                  onChanged: (v) => ref
                      .read(LoginProvider.password.notifier)
                      .update((state) => v.trim()),
                  pinController: _pinTimerController,
                  sendVerification: _sendVerificationCode,
                ),
                secondChild: PasswordTextField(
                  controller: _pwdController,
                  prefixIcon: const Icon(Icons.lock),
                  focusNode: _pwdNode,
                  hintText: '密码',
                  onEditingComplete: () => _pwdNode.unfocus(),
                  onChanged: (v) => ref
                      .read(LoginProvider.password.notifier)
                      .update((state) => v.trim()),
                ),
                crossFadeState: pwdMode
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300)),
            _LoginMode(
              onModeChanged: (passwordMode) {
                if (passwordMode) {
                  _phoneController.clear();
                  _pinController.clear();
                } else {
                  _nameController.clear();
                  _pwdController.clear();
                }
              },
            ),
            const _LoginButton(),
            // SizedBox(height: 4.h),
            //   SizedBox(
            //     width: double.infinity,
            //     child: _RegisterButtonWidget(),
            //   ),
            SizedBox(height: 12.h),
            _TheAgreement(),
          ],
        ),
      ),
    );
  }

  Future<void> _sendVerificationCode() async {
    // try {
    //   final sessionId = await ref
    //       .read(authServiceProvider)
    //       .sendVerificationCode(
    //           _phoneController.text, ProtoCodeUsage.CODE_USAGE_LOGIN);
    //   ref.read(LoginProvider.sessionId.notifier).update((state) => sessionId);
    // } catch (e) {
    //   unawaited(Fluttertoast.showToast(msg: Em.exception(e)));
    //   _pinTimerController.resetTimer();
    // }
  }
}
