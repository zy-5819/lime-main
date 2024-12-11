part of '../user_page.dart';

class _AvatorItem extends HookConsumerWidget {
  ///用户头像栏
  const _AvatorItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      margin: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: theme.colorScheme.surface,
      ),
      child: Row(
        children: [
          ClipOval(
            child: Container(
              width: 64.r,
              height: 64.r,
              color: theme.colorScheme.primary,
              //child: Image.asset(kUserProfileImage, fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            ref.watch(_usernameProvider),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () => _logout(ref, context),
                  child: const Text('登出')),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _logout(WidgetRef ref, BuildContext context) async {
    try {
      final nav = Navigator.of(context);
      await Fluttertoast.showToast(msg: '退出成功');
      await nav.popAndPushNamed(Routes.login);
    } catch (e) {
      Log.e('logout: $e');
      await Fluttertoast.showToast(msg: '退出失败，请稍后重试！');
    }
  }
}

final _usernameProvider = Provider.autoDispose<String>((ref) {
  return '';
});
