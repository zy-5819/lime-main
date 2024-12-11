part of '../user_password_update_page.dart';

class _UpdateNotifier extends StateNotifier<bool> {
  ///存储文本信息的provider
  static final oldPwdProvider = StateProvider.autoDispose<String>((ref) => '');
  static final newPwdProvider = StateProvider.autoDispose<String>((ref) => '');
  static final confirmProvider = StateProvider.autoDispose<String>((ref) => '');

  ///因为设置文本时已去除空格，此处不需要检查空格，当文本长度小于8位时，将显示错误
  static final oldErrorProvider =
      StateProvider.autoDispose<bool>((ref) => false);
  static final confirmErrorProvider =
      StateProvider.autoDispose<bool>((ref) => false);

  static final provider =
      StateNotifierProvider.autoDispose<_UpdateNotifier, bool>((ref) {
    final old = ref.watch(oldPwdProvider);
    final newPwd = ref.watch(newPwdProvider);
    final confirm = ref.watch(confirmProvider);
    return _UpdateNotifier(
        (old.length >= 8 && newPwd.length >= 8 && newPwd == confirm));
  });

  final bool canUpdate;

  _UpdateNotifier(this.canUpdate) : super(canUpdate);
}
