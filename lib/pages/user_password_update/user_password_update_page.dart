import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lime/widgets/elevated_button_widget.dart';
import 'package:lime/widgets/textfields/password_text_field.dart';

part 'src/provider.dart';

class UserPasswordUpdatePage extends ConsumerStatefulWidget {
  ///用户更新密码的页面
  const UserPasswordUpdatePage({super.key});

  ///从指定的[BuildContext]中提取参数初始化用户更新密码页面
  factory UserPasswordUpdatePage.route(BuildContext context) =>
      const UserPasswordUpdatePage();

  @override
  ConsumerState<UserPasswordUpdatePage> createState() =>
      _UserPasswordUpdatePageState();
}

class _UserPasswordUpdatePageState
    extends ConsumerState<UserPasswordUpdatePage> {
  final _oldPwd = TextEditingController();
  final _newPwd = TextEditingController();
  final _confirmPwd = TextEditingController();

  final _oldNode = FocusNode();
  final _newNode = FocusNode();
  final _confirmNode = FocusNode();

  @override
  void dispose() {
    _oldPwd.dispose();
    _newPwd.dispose();
    _confirmPwd.dispose();
    _oldNode.dispose();
    _newNode.dispose();
    _confirmNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canupdate = ref.watch(_UpdateNotifier.provider);
    final confirmError = ref.watch(_UpdateNotifier.confirmErrorProvider);
    final oldError = ref.watch(_UpdateNotifier.oldErrorProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('修改密码')),
      body: ListView(
        physics: const RangeMaintainingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        children: [
          _buildTitle('原密码'),
          PasswordTextField(
            controller: _oldPwd,
            hintText: '请输入原密码',
            focusNode: _oldNode,
            error: oldError,
            onChanged: (v) => ref
                .read(_UpdateNotifier.oldPwdProvider.notifier)
                .update((state) => v.trim()),
            onEditingComplete: () {
              _newNode.requestFocus();
            },
          ),
          _buildTitle('新密码'),
          _buildSubtitle(),
          PasswordTextField(
            controller: _newPwd,
            hintText: '请输入新密码',
            focusNode: _newNode,
            onChanged: (v) => ref
                .read(_UpdateNotifier.newPwdProvider.notifier)
                .update((state) => v.trim()),
            onEditingComplete: () {
              _confirmNode.requestFocus();
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.h, bottom: 20.h),
            child: PasswordTextField(
              controller: _confirmPwd,
              focusNode: _confirmNode,
              hintText: '再次输入新密码',
              error: confirmError,
              onChanged: (v) {
                ref
                    .read(_UpdateNotifier.confirmProvider.notifier)
                    .update((state) => v.trim());
                ref
                    .read(_UpdateNotifier.confirmErrorProvider.notifier)
                    .update((state) => _newPwd.text != _confirmPwd.text);
              },
              onEditingComplete: () {
                _confirmNode.unfocus();
              },
            ),
          ),
          ElevatedButtonWidget(
            onPressed: canupdate ? _update : null,
            margin: EdgeInsets.zero,
            allowLoad: true,
            child: const Text('更改'),
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitle() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Text(
        '密码位数不低于8位',
        style: TextStyle(
            color:
                Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
            fontSize: 14.sp),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Container(
      padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
      child: Text(
        title,
        style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<void> _update() async {
    // try {
    //   final nav = Navigator.of(context);
    //   // await ref
    //   //     .read(userServiceProvider)
    //   //     .changeMyPassword(_newPwd.text.trim(), _oldPwd.text.trim());
    //   await Fluttertoast.showToast(msg: '密码修改成功，请重新登录');
    //   await nav.popAndPushNamed(Routes.login);
    // } catch (e) {
    //   unawaited(Fluttertoast.showToast(msg: Em.exception(e)));
    // }
  }
}
