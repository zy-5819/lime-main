part of '../login_page.dart';

class LoginProvider {
  static final passwordMode = StateProvider.autoDispose<bool>((ref) => true);

  static final sessionId = StateProvider.autoDispose<String?>((ref) => null);

  static final agreementChecked =
      StateProvider.autoDispose<bool>((ref) => false);

  static final username = StateProvider.autoDispose<String>((ref) => '');

  static final password = StateProvider.autoDispose<String>((ref) => '');
}
