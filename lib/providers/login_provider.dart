import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userNameEditProvider = StateProvider((ref) {
  return TextEditingController();
});
final pwdEditProvider = StateProvider((ref) {
  return TextEditingController();
});
final loginModeProvider = StateProvider((ref) {
  return true;
});
final verifyStrProvider = StateProvider((ref) {
  return "获取验证码";
});
final isAvailableGetVCodeProvider = StateProvider((ref) {
  return true;
});
final sessionIdProvider = StateProvider<String?>((ref) {
  return null;
});
final userErrorProvider = StateProvider<String?>((ref) {
  return null;
});
final pwdErrorProvider = StateProvider<String?>((ref) {
  return null;
});
