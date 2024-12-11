part of '../login_page.dart';

class _LoginButton extends HookConsumerWidget {
  const _LoginButton();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pwdMode = ref.watch(LoginProvider.passwordMode);
    final sessionId = ref.watch(LoginProvider.sessionId);
    final argeementChecked = ref.watch(LoginProvider.agreementChecked);
    final username = ref.watch(LoginProvider.username);
    final password = ref.watch(LoginProvider.password);

    return LoadingButton.elevated(
      child: const Text('登录'),
      onPressed: () => _login(context, ref, pwdMode, sessionId,
          argeementChecked, username, password),
    );
  }

  Future<void> _login(
    BuildContext context,
    WidgetRef ref,
    bool pwdMode,
    String? sessionId,
    bool argeementChecked,
    String username,
    String password,
  ) async {
    // clearChannel();
    // ref.invalidate(channelProvider);
    final nav = Navigator.of(context);

    if (!argeementChecked) {
      await Fluttertoast.showToast(msg: '请先同意用户协议');
      return;
    }

    if (username.isEmpty) {
      unawaited(Fluttertoast.showToast(msg: pwdMode ? '用户名不能为空' : '手机号不能为空'));
      return;
    }
    if (password.isEmpty) {
      unawaited(Fluttertoast.showToast(msg: pwdMode ? '密码不能为空' : '验证码不能为空'));
      return;
    }
    // try {
    //   if (pwdMode) {
    //     await ref
    //         .read(authServiceProvider)
    //         .loginWithPassword(username, password);
    //   } else {
    //     await ref
    //         .read(authServiceProvider)
    //         .loginWithVerificationCode(sessionId ?? '', password);
    //   }
    //   unawaited(Fluttertoast.showToast(msg: '登录成功'));
    //   final prefs = ref.read(sharedPreferencesProvider);
    //   await prefs.remove(kCurrentGroupId);
    //   ref.invalidate(sharedPreferencesProvider);
    //   await nav.pushReplacementNamed(Routes.bottomTabs);
    // } catch (e) {
    //   unawaited(Fluttertoast.showToast(msg: Em.exception(e)));
    // }
  }
}
