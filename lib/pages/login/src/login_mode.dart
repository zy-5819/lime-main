part of '../login_page.dart';

class _LoginMode extends HookConsumerWidget {
  const _LoginMode({this.onModeChanged});

  final void Function(bool passwordMode)? onModeChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordMode = ref.watch(LoginProvider.passwordMode);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            ref
                .read(LoginProvider.passwordMode.notifier)
                .update((state) => !state);
            ref.read(LoginProvider.username.notifier).update((state) => '');
            ref.read(LoginProvider.password.notifier).update((state) => '');
            onModeChanged?.call(!passwordMode);
          },
          child: Text(
            passwordMode ? '验证码登录' : '密码登录',
            style: TextStyle(fontSize: 11.sp),
          ),
        ),
      ],
    );
  }
}
